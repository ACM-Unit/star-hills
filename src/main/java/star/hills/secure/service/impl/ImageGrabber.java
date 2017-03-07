package star.hills.secure.service.impl;

import com.xuggle.mediatool.IMediaReader;
import com.xuggle.mediatool.IMediaWriter;
import com.xuggle.mediatool.ToolFactory;
import org.springframework.stereotype.Service;
import star.hills.secure.main.MyVideoListener;
import star.hills.secure.main.Resizer;

import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * Created by Admin on 15.07.2016.
 */
@Service
public class ImageGrabber {

    private String realPath;
    private String sourcePath;
    private String endvideo;
    private String finishPath;
    private static final Integer WIDTH = 640;

    public void setRealPath(String realPath) {
        this.realPath = realPath;
    }

    public void setFinishPath(String finishPath) {
        this.finishPath = finishPath;
    }

    public void setSourcePath(String sourcePath) {
        this.sourcePath = sourcePath;
    }

    public void setEndvideo(String endvideo) {
        this.endvideo = endvideo;
    }

    public boolean graberImage() throws  IOException {
        MyVideoListener myVideoListener = new MyVideoListener(WIDTH);
        Resizer resizer = new Resizer(WIDTH, finishPath + ".png", sourcePath);
        IMediaReader reader = ToolFactory.makeReader(realPath + "."+endvideo);
        reader.setBufferedImageTypeToGenerate(BufferedImage.TYPE_3BYTE_BGR);
        reader.addListener(resizer);
        IMediaWriter writer = ToolFactory.makeWriter(finishPath + ".mp4", reader);
        resizer.addListener(writer);
        writer.addListener(myVideoListener);
        while (reader.readPacket() == null) {
        }
        return true;
    }
}
