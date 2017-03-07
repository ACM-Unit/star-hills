package star.hills.secure.test.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import star.hills.secure.entity.Client;
import star.hills.secure.test.config.TestDataBaseConfig;

/**
 * Created by Admin on 08.09.2016.
 */
@DirtiesContext
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = TestDataBaseConfig.class)
@WebAppConfiguration
class Testes {

    @Test
    public void test(){
        Client client=new Client();
        client.setTitle("привет");
        Client client1=client;
        System.out.println(client1.getTitle());
        client.setTitle("hello");
        System.out.println(client1.getTitle());

    }
}
