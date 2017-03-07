package star.hills.secure.test.service;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.junit.Test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

/**
 * Created by androlekss on 08.07.16.
 */
public class Tester {

    @Test
    public void whenPostJsonUsingHttpClient_thenCorrect()
            throws ClientProtocolException, IOException {
        System.setProperty("https.protocols", "TLSv1");
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("https://www.sofort.com/payment/status");

        StringEntity entity = new StringEntity("transaction=133738-292118-5784B0A2-832D");
        httpPost.setEntity(entity);
        CloseableHttpResponse respons = client.execute(httpPost);

        System.out.println("[PayPal check string] " + respons.toString());

        URL url = new URL("https://www.sofort.com/payment/status");
        URLConnection conn = url.openConnection();
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        OutputStreamWriter wr = new OutputStreamWriter(
                conn.getOutputStream());
        wr.write("transaction=133738-292118-5784B0A2-832D");
        wr.flush();

        System.out.println("[PayPal otpravil] ");
        // response from PayPal - VERIFIED or INVALID
        BufferedReader br = new BufferedReader(new InputStreamReader(
                conn.getInputStream()));
        String line = br.readLine();


        wr.close();
        br.close();

        System.out.println("[PayPal check string] " + line);
    }

}