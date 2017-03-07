package star.hills.secure.service;

import org.springframework.data.domain.Page;
import star.hills.secure.entity.Order;
import star.hills.secure.entity.Star;

import java.util.Date;
import java.util.List;

/**
 * Created by Admin on 29.04.2016.
 */
public interface OrderService {
    Order getOrder (int id);
    List<Order> getOrderByStar(Star star);
    Page<Order> getOrdersByStarAndActive(int page, Star star, int active);
    List<Order> getOrdersByStarAndActive(Star star, int active);
    Order addOrder(Order order);
    Order editOrder(Order order);
    void delete(int id);
    List<Order> getOrderByDate(Date start, Date finish);
}
