package star.hills.secure.service;

import star.hills.secure.entity.Star;
import star.hills.secure.entity.Video;

import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */

public interface VideoService {
    Video getVideo(Star star);
    Video addVideo(Video video);
    void delete(int id);
    List<Video> getAll();
    Video editVideo(Video video);
}
