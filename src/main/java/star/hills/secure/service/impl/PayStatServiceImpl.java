package star.hills.secure.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import star.hills.secure.entity.PayStat;
import star.hills.secure.entity.Star;
import star.hills.secure.repository.PayStatRepository;
import star.hills.secure.service.PayStatService;

import java.util.List;

/**
 * Created by Admin on 26.08.2016.
 */
@Service
public class PayStatServiceImpl implements PayStatService {
    @Autowired
    private PayStatRepository repository;
    @Override
    public List<PayStat> getAllByStar(Star star) {
        return repository.findByStar(star);
    }

    @Override
    public PayStat addPayStat(PayStat paystat) {
        return repository.saveAndFlush(paystat);
    }
}
