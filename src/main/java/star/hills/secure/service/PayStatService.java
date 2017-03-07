package star.hills.secure.service;

import star.hills.secure.entity.PayStat;
import star.hills.secure.entity.Star;

import java.util.List;

/**
 * Created by Admin on 26.08.2016.
 */
public interface PayStatService {
    List<PayStat> getAllByStar(Star star);
    PayStat addPayStat(PayStat paystat);
}
