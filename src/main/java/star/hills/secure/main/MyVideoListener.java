package star.hills.secure.main;

import com.xuggle.mediatool.MediaToolAdapter;
import com.xuggle.mediatool.event.IAddStreamEvent;
import com.xuggle.xuggler.*;

public class MyVideoListener extends MediaToolAdapter {
    private Integer width;

    public MyVideoListener(Integer aWidth) {
        this.width = aWidth;
    }

    @Override
    public void onAddStream(IAddStreamEvent event) {
        Integer height;
        int streamIndex = event.getStreamIndex();
        IStreamCoder streamCoder = event.getSource().getContainer().getStream(streamIndex).getStreamCoder();
        if(streamCoder.getWidth()!=0) {
            height = streamCoder.getHeight() * width / streamCoder.getWidth();
        }else{
            height=0;
        }
        if (streamCoder.getCodecType() == ICodec.Type.CODEC_TYPE_AUDIO) {
            streamCoder.setCodec(ICodec.ID.CODEC_ID_AAC);
        } else if (streamCoder.getCodecType() == ICodec.Type.CODEC_TYPE_VIDEO) {
            streamCoder.setWidth(width);
            streamCoder.setHeight(height);
            System.out.println(streamCoder.getCodec());
            IRational frameRate = IRational.make(15, 1);
            streamCoder.setCodec(ICodec.ID.CODEC_ID_H264);
            streamCoder.setBitRate(250000); // 250kbps
            streamCoder.setBitRateTolerance(9000);
            streamCoder.setPixelType(IPixelFormat.Type.YUV420P);
            streamCoder.setGlobalQuality(10);
            streamCoder.setFrameRate(frameRate);
            streamCoder.setTimeBase(IRational.make(1, 1000)); // 1/1000??(flv???????)
            streamCoder.setProperty("level", "50");
            streamCoder.setProperty("coder", "0");
            streamCoder.setProperty("qmin", "10");
            streamCoder.setProperty("bf", "0");
            streamCoder.setProperty("wprefp", "0");
            streamCoder.setProperty("cmp", "+chroma");
            streamCoder.setProperty("partitions", "-parti8x8+parti4x4+partp8x8+partp4x4-partb8x8");
            streamCoder.setProperty("me_method", "hex");
            streamCoder.setProperty("subq", "5");
            streamCoder.setProperty("me_range", "16");
            streamCoder.setProperty("keyint_min", "25");
            streamCoder.setProperty("sc_threshold", "40");
            streamCoder.setProperty("i_qfactor", "0.71");
            streamCoder.setProperty("b_strategy", "0");
            streamCoder.setProperty("qcomp", "0.6");
            streamCoder.setProperty("qmax", "30");
            streamCoder.setProperty("qdiff", "4");
            streamCoder.setProperty("directpred", "0");
            streamCoder.setProperty("cqp", "0");
            streamCoder.setFlag(IStreamCoder.Flags.FLAG_LOOP_FILTER, true);
            streamCoder.setFlag(IStreamCoder.Flags.FLAG_CLOSED_GOP, true);
        }
        super.onAddStream(event);
    }

}