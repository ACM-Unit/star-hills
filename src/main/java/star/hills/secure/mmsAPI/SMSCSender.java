/*
package star.hills.secure.mmsAPI;

import javax.servlet.http.HttpServletRequest;
import java.net.*;
import java.io.*;
import java.lang.Math;

public class SMSCSender {

	private String SMSC_LOGIN    = "acmunit";     // логин клиента
	private String SMSC_PASSWORD = "acmunit22";  // пароль или MD5-хеш пароля в нижнем регистре
	private boolean SMSC_HTTPS   = false;         // использовать HTTPS протокол
	private String SMSC_CHARSET  = "utf-8";       // кодировка сообщения: koi8-r, windows-1251 или utf-8 (по умолчанию)
	private boolean SMSC_DEBUG   = false;         // флаг отладки
	private boolean SMSC_POST    = false;         // Использовать метод POST

	public SMSCSender() {
	}

	public SMSCSender(String login, String password) {
		SMSC_LOGIN    = login;
		SMSC_PASSWORD = password;
	}

	public SMSCSender(String login, String password, String charset) {
		SMSC_LOGIN    = login;
		SMSC_PASSWORD = password;
		SMSC_CHARSET  = charset;
	}

	public SMSCSender(String login, String password, String charset, boolean debug) {
		SMSC_LOGIN    = login;
		SMSC_PASSWORD = password;
		SMSC_CHARSET  = charset;
		SMSC_DEBUG    = debug;
	}

	public String[] sendSms(String phones, String message, int translit, String time, String id, int format, String sender, String query, String[] files) {
		String[] formats = {"flash=1", "push=1", "hlr=1", "bin=1", "bin=2", "ping=1", "mms=1", "mail=1", "call=1"};
		String[] m = {};
		try {
			m = SmscSendCmd("send", "cost=3&phones=" + URLEncoder.encode(phones, SMSC_CHARSET)
					+ "&mes=" + URLEncoder.encode(message, SMSC_CHARSET)
					+ "&translit=" + translit + "&id=" + id + (format > 0 ? "&" + formats[format] : "")
					+ (sender == "" ? "" : "&sender=" + URLEncoder.encode(sender, SMSC_CHARSET))
					+ (time == "" ? "" : "&time=" + URLEncoder.encode(time, SMSC_CHARSET))
					+ (query == "" ? "" : "&" + query), files);
		}
		catch (UnsupportedEncodingException e) {

		}

		if (SMSC_DEBUG) {
			if (Integer.parseInt(m[1]) > 0) {
				System.out.println("Сообщение отправлено успешно. ID: " + m[0] + ", всего SMS: " + m[1] + ", стоимость: " + m[2] + ", баланс: " + m[3]);
			}
			else {
				System.out.print("Ошибка №" + Math.abs(Integer.parseInt(m[1])));
				System.out.println(Integer.parseInt(m[0])>0 ? (", ID: " + m[0]) : "");
			}
		}

		return m;
	}

	public String[] getSmsCost(String phones, String message, int translit, int format, String sender, String query){
		String[] formats = {"flash=1", "push=1", "hlr=1", "bin=1", "bin=2", "ping=1", "mms=1", "mail=1", "call=1"};
		String[] m = {};

		try {
			m = SmscSendCmd("send", "cost=1&phones=" + URLEncoder.encode(phones, SMSC_CHARSET)
					+ "&mes=" + URLEncoder.encode(message, SMSC_CHARSET)
					+ "&translit=" + translit + (format > 0 ? "&" + formats[format] : "")
					+ (sender == "" ? "" : "&sender=" + URLEncoder.encode(sender, SMSC_CHARSET))
					+ (query == "" ? "" : "&" + query), null);
		}
		catch (UnsupportedEncodingException e) {

		}
		// (cost, cnt) или (0, -error)

		if (SMSC_DEBUG) {
			if (Integer.parseInt(m[1]) > 0) {
				System.out.println("Стоимость рассылки: " + m[0] + ", Всего SMS: " + m[1]);
			}
			else {
				System.out.print("Ошибка №" + Math.abs(Integer.parseInt(m[1])));
			}
		}
		return m;
	}

	public String[] getStatus(int id, String phone, int all){
		String[] m = {};
		String tmp;

		try {
			m = SmscSendCmd("status", "phone=" + URLEncoder.encode(phone, SMSC_CHARSET) + "&id=" + id + "&all=" + all, null);

			if (SMSC_DEBUG) {
				if (m[1] != "" && Integer.parseInt(m[1]) >= 0) {
					java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Integer.parseInt(m[1]));
					System.out.println("Статус SMS = " + m[0]);
				}
				else
					System.out.println("Ошибка №" + Math.abs(Integer.parseInt(m[1])));
			}

			if (all == 1 && m.length > 9 && (m.length < 14 || m[14] != "HLR")) {
				tmp = implode(m, ",");
				m = tmp.split(",", 9);
			}
		}
		catch (UnsupportedEncodingException e) {

		}

		return m;
	}

	public String getBalance() {
		String[] m = {};

		m = SmscSendCmd("balance", "", null); // (balance) или (0, -error)

		if (SMSC_DEBUG) {
			if (m.length == 1)
				System.out.println("Сумма на счете: " + m[0]);
			else
				System.out.println("Ошибка №" + Math.abs(Integer.parseInt(m[1])));
		}

		return m.length == 2 ?  "" : m[0];
	}

	private String[] SmscSendCmd(String cmd, String arg, String[] files){
		String[] m = {};
		HttpServletRequest request;
		HttpServletResponse response;
		String ret = ",";

		try {
			String url = (SMSC_HTTPS ? "https" : "http") + "://smsc.ru/sys/" + cmd +".php?login=" + URLEncoder.encode(SMSC_LOGIN, SMSC_CHARSET)
					+ "&psw=" + URLEncoder.encode(SMSC_PASSWORD, SMSC_CHARSET)
					+ "&fmt=1&charset=" + SMSC_CHARSET + "&" + arg;

			int i = 0;
			do {
				if (i > 0)
					Thread.sleep(2000);
				ret = SmscReadUrl(url);
				request = (HttpWebRequest)WebRequest.Create(url);
				if (SMSC_POST) {
					request.Method = "POST";

					String postHeader, boundary = "----------" + DateTime.Now.Ticks.ToString("x");
					byte[] postHeaderBytes, boundaryBytes = Encoding.ASCII.GetBytes("--" + boundary + "--\r\n"), tbuf;
					StringBuilder sb = new StringBuilder();
					int bytesRead;

					byte[] output = new byte[0];

					if (files == null) {
						request.ContentType = "application/x-www-form-urlencoded";
						output = Encoding.UTF8.GetBytes(arg);
						request.ContentLength = output.Length;
					}
					else {
						request.ContentType = "multipart/form-data; boundary=" + boundary;

						string[] par = arg.Split('&');
						int fl = files.Length;

						for (int pcnt = 0; pcnt < par.Length + fl; pcnt++)
						{
							sb.Clear();

							sb.Append("--");
							sb.Append(boundary);
							sb.Append("\r\n");
							sb.Append("Content-Disposition: form-data; name="");

									bool pof = pcnt < fl;
							String[] nv = new String[0];

							if (pof)
							{
								sb.Append("File" + (pcnt + 1));
								sb.Append(""; filename="");
								sb.Append(Path.GetFileName(files[pcnt]));
							}
							else {
								nv = par[pcnt - fl].Split('=');
								sb.Append(nv[0]);
							}

							sb.Append(""");
									sb.Append("\r\n");
							sb.Append("Content-Type: ");
							sb.Append(pof ? "application/octet-stream" : "text/plain; charset="" + SMSC_CHARSET + """);
							sb.Append("\r\n");
							sb.Append("Content-Transfer-Encoding: binary");
							sb.Append("\r\n");
							sb.Append("\r\n");

							postHeader = sb.ToString();
							postHeaderBytes = Encoding.UTF8.GetBytes(postHeader);

							output = _concatb(output, postHeaderBytes);

							if (pof)
							{
								FileStream fileStream = new FileStream(files[pcnt], FileMode.Open, FileAccess.Read);

								// Write out the file contents
								byte[] buffer = new Byte[checked((uint)Math.Min(4096, (int)fileStream.Length))];

								bytesRead = 0;
								while ((bytesRead = fileStream.Read(buffer, 0, buffer.Length)) != 0)
								{
									tbuf = buffer;
									Array.Resize(ref tbuf, bytesRead);

									output = _concatb(output, tbuf);
								}
							}
							else {
								byte[] vl = Encoding.UTF8.GetBytes(nv[1]);
								output = _concatb(output, vl);
							}

							output = _concatb(output, Encoding.UTF8.GetBytes("\r\n"));
						}
						output = _concatb(output, boundaryBytes);

						request.ContentLength = output.Length;
					}

					Stream requestStream = request.GetRequestStream();
					requestStream.Write(output, 0, output.Length);
				}

				try
				{
					response = (HttpWebResponse)request.GetResponse();

					sr = new StreamReader(response.GetResponseStream());
					ret = sr.ReadToEnd();
				}
				catch (WebException) {
					ret = "";
				}
			}
			while (ret == "" && ++i < 4);

			if (ret == "") {
				if (SMSC_DEBUG)
					_print_debug("Ошибка чтения адреса: " + url);

				ret = ","; // фиктивный ответ
			}

			char delim = ',';

			if (cmd == "status")
			{
				string[] par = arg.Split('&');

				for (i = 0; i < par.Length; i++)
				{
					string[] lr = par[i].Split("=".ToCharArray(), 2);

					if (lr[0] == "id" && lr[1].IndexOf("%2c") > 0) // запятая в id - множественный запрос
						delim = '\n';
				}
			}

			return ret.Split(delim);
		}
	}
			while (ret == "" && ++i < 3);
		}
		catch (UnsupportedEncodingException e) {

		}
		catch (InterruptedException e) {

		}

		return ret.split(",");
	}

	private String SmscReadUrl(String url) {

		String line = "", real_url = url;
		String[] param = {};
		boolean is_post = (SMSC_POST || url.length() > 2000);

		if (is_post) {
			param = url.split("\\?",2);
			real_url = param[0];
		}

		try {
			URL u = new URL(real_url);
			InputStream is;

			if (is_post){
				URLConnection conn = u.openConnection();
				conn.setDoOutput(true);
				OutputStreamWriter os = new OutputStreamWriter(conn.getOutputStream(), SMSC_CHARSET);
				os.write(param[1]);
				os.flush();
				os.close();
				System.out.println("post");
				is = conn.getInputStream();
			}
			else {
				is = u.openStream();
			}

			InputStreamReader reader = new InputStreamReader(is, SMSC_CHARSET);

			int ch;
			while ((ch = reader.read()) != -1) {
				line += (char)ch;
			}

			reader.close();
		}
		catch (MalformedURLException e) { // Неверно урл, протокол...

		}
		catch (IOException e) {

		}

		return line;
	}

	private static String implode(String[] ary, String delim) {
		String out = "";

		for (int i = 0; i < ary.length; i++) {
			if (i != 0)
				out += delim;
			out += ary[i];
		}

		return out;
	}
}*/
