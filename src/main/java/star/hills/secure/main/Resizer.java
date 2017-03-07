package star.hills.secure.main;

import com.xuggle.mediatool.MediaToolAdapter;
import com.xuggle.mediatool.event.IVideoPictureEvent;
import com.xuggle.mediatool.event.VideoPictureEvent;
import com.xuggle.xuggler.IVideoPicture;
import com.xuggle.xuggler.IVideoResampler;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class Resizer extends MediaToolAdapter {
    private Integer width;
    private int count=0;
    private String path;
    public void setSourcepath(String sourcepath) {
        this.sourcepath = sourcepath;
    }

    private String sourcepath;
    private IVideoResampler videoResampler = null;

    public Resizer(Integer aWidth, String path, String sourcepath) {
        this.width = aWidth;
        this.path = path;
        this.sourcepath = sourcepath;
    }

    @Override
    public void onVideoPicture(IVideoPictureEvent event) {
        IVideoPicture pic = event.getPicture();
        Integer height=pic.getHeight()*width/pic.getWidth();
        if(count==1){
            String outputFilename = dumpImageToFile(event.getImage(), width, height);
        }
        count++;
        if (videoResampler == null) {
            videoResampler = IVideoResampler.make(width, height, pic.getPixelType(), pic.getWidth(), pic
                    .getHeight(), pic.getPixelType());
        }
        IVideoPicture out = IVideoPicture.make(pic.getPixelType(), width, height);
        videoResampler.resample(out, pic);

        IVideoPictureEvent asc = new VideoPictureEvent(event.getSource(), out, event.getStreamIndex());
        super.onVideoPicture(asc);
        out.delete();
    }
    private String dumpImageToFile(BufferedImage image, int width, int height)  {
        try {
            BufferedImage newImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
            BufferedImage img2 = ImageIO.read(new File(sourcepath + "/starSource/play.png"));
            Graphics2D g2 = newImage.createGraphics();
            Color oldColor = g2.getColor();
            g2.setPaint(Color.WHITE);
            g2.fillRect(0, 0, width, height);
            g2.setColor(oldColor);
            g2.drawImage(image, 0, 0, width, height, null);
            ImageIO.write(newImage, "png", new File(path));
            g2.drawImage(img2, (width-150)/2, (height-150)/2, 150, 150, null);
            g2.dispose();
            if(!new File(path).getName().split("\\.")[0].equals("videoconfirm")) {
                ImageIO.write(newImage, "png", new File(sourcepath + "/starSource/screens/" + new File(path).getName().split("\\.")[0] + ".png"));
            }
        } catch (IOException e) {
            System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
            e.printStackTrace();
        }
            return path;
    }
}