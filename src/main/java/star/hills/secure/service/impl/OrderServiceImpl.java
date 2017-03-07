package star.hills.secure.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import star.hills.secure.entity.Order;
import star.hills.secure.entity.Star;
import star.hills.secure.repository.OrderRepository;
import star.hills.secure.service.OrderService;

import java.util.Date;
import java.util.List;

/**
 * Created by Admin on 05.05.2016.
 */
@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderRepository orderRepository;

    @Override
    public Order getOrder(int id) {
        return orderRepository.findOne(id);
    }

    @Override
    public List<Order> getOrderByStar(Star star) {
        return orderRepository.findByStar(star);
    }

    @Override
    public List<Order> getOrdersByStarAndActive(Star star, int active) {
        return orderRepository.findByStarAndActive(star, active);
    }
    public Page<Order> getOrdersByStarAndActive(int page, Star star, int active) {
        return orderRepository.findAllByStarAndActive(new PageRequest(page,5, Sort.Direction.DESC, "date"), star, active);
    }

    @Override
    public Order addOrder(Order order) {
        return orderRepository.saveAndFlush(order);
    }

    @Override
    public Order editOrder(Order order) {
        return orderRepository.saveAndFlush(order);
    }

    @Override
    public void delete(int id) {
orderRepository.delete(id);
    }

    @Override
    public List<Order> getOrderByDate(Date start, Date finish) {
        return orderRepository.findByDateBetween(start, finish);
    }
}
