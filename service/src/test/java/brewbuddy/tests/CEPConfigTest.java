package brewbuddy.tests;

import brewbuddy.model.Beer;
import brewbuddy.model.Rating;
import brewbuddy.model.User;
import org.junit.Test;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import java.util.List;


public class CEPConfigTest {

    @Test
    public void test() {
         KieServices ks = KieServices.Factory.get();
         KieContainer kContainer = ks.getKieClasspathContainer();
         KieSession ksession = kContainer.newKieSession("cepKsession");
         User user = new User();
         user.setId(1);
         Beer beer = new Beer();
         beer.setId(1);
         Rating rating = new Rating();
         rating.setId(1);
         rating.setBeer(beer);
         rating.setUser(user);
         ksession.insert(rating);
         ksession.insert(beer);
         ksession.insert(user);
         int count = ksession.fireAllRules();
         System.out.println(count);
         List<Beer> resultList = (List) ksession.getGlobal("resultList");

    }
}
