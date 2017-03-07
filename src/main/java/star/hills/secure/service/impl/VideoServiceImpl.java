package star.hills.secure.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import star.hills.secure.entity.Star;
import star.hills.secure.entity.Video;
import star.hills.secure.repository.VideoRepository;
import star.hills.secure.service.VideoService;

import java.util.List;

/**
 * Created by Admin on 05.05.2016.
 */
@Service
public class VideoServiceImpl implements VideoService {

    @Autowired
    private VideoRepository videoRepository;
    @Override
    public Video getVideo(Star star) {
        return videoRepository.findByStar(star);
    }

    @Override
    public Video addVideo(Video video) {
        return videoRepository.saveAndFlush(video);
    }

    @Override
    public void delete(int id) {
        videoRepository.delete(id);
    }

    @Override
    public List<Video> getAll() {
        return videoRepository.findAll();
    }

    @Override
    public Video editVideo(Video video) {
        return videoRepository.saveAndFlush(video);
    }
}
