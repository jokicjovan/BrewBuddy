package brewbuddy.tests;

import brewbuddy.model.Beer;
import brewbuddy.model.Brewery;
import brewbuddy.model.Rating;
import brewbuddy.model.User;
import brewbuddy.model.enums.BeerType;
import org.junit.Test;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import java.util.ArrayList;
import java.util.HashMap;


public class CEPConfigTest {

    @Test
    public void test() {

        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("recommendationKsession");

        HashMap<Beer, Integer> recommendationMap = new HashMap<Beer, Integer>();
        ksession.setGlobal("recommendationMap", recommendationMap);

        User user = new User();
        user.setId(1);

        Brewery brewery1 = new Brewery();
        brewery1.setId(1);
        Brewery brewery2 = new Brewery();
        brewery2.setId(2);

        Beer beer1 = new Beer();
        beer1.setId(1);
        beer1.setType(BeerType.IPA);
        beer1.setBrewery(brewery1);

        Beer beer2 = new Beer();
        beer2.setId(2);
        beer2.setType(BeerType.IPA);
        beer2.setBrewery(brewery1);

        Beer beer3 = new Beer();
        beer3.setId(3);
        beer3.setType(BeerType.IPA);
        beer3.setBrewery(brewery2);

        Beer beer4 = new Beer();
        beer4.setId(4);
        beer4.setType(BeerType.ALE);
        beer4.setBrewery(brewery2);

        Rating rating1 = new Rating();
        rating1.setId(1);
        rating1.setBeer(beer1);
        rating1.setUser(user);
        rating1.setRating(5);

        Rating rating2 = new Rating();
        rating2.setId(1);
        rating2.setBeer(beer2);
        rating2.setUser(user);
        rating2.setRating(5);

        ksession.insert(rating1);
        ksession.insert(rating2);
        ksession.insert(beer1);
        ksession.insert(beer2);
        ksession.insert(beer3);
        ksession.insert(user);

        int count = ksession.fireAllRules();
        System.out.println(count);
        recommendationMap = (HashMap<Beer, Integer>) ksession.getGlobal("recommendationMap");
        System.out.println(recommendationMap);
    }
}
