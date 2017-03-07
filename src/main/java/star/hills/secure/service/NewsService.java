package star.hills.secure.service;

import org.springframework.data.domain.Page;
import star.hills.secure.entity.News;

import java.util.List;

/**
 * Created by androlekss on 15.08.16.
 */


public interface NewsService {

    List<News> getNewsByStatus(int status);
    News addNews(News news);
    News editNews(News news);
    News getNewsById(int id);
    Page<News> getNews(int page, int status);
    Page<News> getAllNews(int page);
}
