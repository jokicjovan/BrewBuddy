package brewbuddy.tests;

import brewbuddy.model.*;
import brewbuddy.model.enums.BeerType;
import org.junit.Test;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import java.util.ArrayList;
import java.util.Arrays;
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
        beer1.setPercentageOfAlcohol(8.0);

        Beer beer2 = new Beer();
        beer2.setId(2);
        beer2.setType(BeerType.IPA);
        beer2.setBrewery(brewery1);
        beer2.setPercentageOfAlcohol(5.0);

        Beer beer3 = new Beer();
        beer3.setId(3);
        beer3.setType(BeerType.IPA);
        beer3.setBrewery(brewery2);
        beer3.setPercentageOfAlcohol(8.5);

        Beer beer4 = new Beer();
        beer4.setId(4);
        beer4.setType(BeerType.ALE);
        beer4.setBrewery(brewery2);
        beer4.setPercentageOfAlcohol(4.0);

        Rating rating1 = new Rating();
        rating1.setId(1);
        rating1.setBeer(beer1);
        rating1.setUser(user);
        rating1.setRating(5);

        Rating rating2 = new Rating();
        rating2.setId(2);
        rating2.setBeer(beer2);
        rating2.setUser(user);
        rating2.setRating(5);

        ksession.insert(rating1);
        //ksession.insert(rating2);
        ksession.insert(beer1);
        ksession.insert(beer2);
        ksession.insert(beer3);
        ksession.insert(user);

        int count = ksession.fireAllRules();
        System.out.println(count);
        recommendationMap = (HashMap<Beer, Integer>) ksession.getGlobal("recommendationMap");
        System.out.println(recommendationMap);
    }

    @Test
    public void test2() {

        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("couponKsession");

        ArrayList<User> fullDiscount = new ArrayList<>();
        ksession.setGlobal("fullDiscount", fullDiscount);
        ArrayList<User> partialDiscount = new ArrayList<>();
        ksession.setGlobal("partialDiscount", partialDiscount);


        User user = new User();
        user.setId(1);
        User user2 = new User();
        user2.setId(2);



        Beer beer1 = new Beer();
        beer1.setId(1);
        beer1.setType(BeerType.IPA);
        beer1.setPercentageOfAlcohol(8.0);

        Beer beer2 = new Beer();
        beer2.setId(2);
        beer2.setType(BeerType.IPA);
        beer2.setPercentageOfAlcohol(5.0);

        Beer beer3 = new Beer();
        beer3.setId(3);
        beer3.setType(BeerType.IPA);
        beer3.setPercentageOfAlcohol(8.5);

        Beer beer4 = new Beer();
        beer4.setId(4);
        beer4.setType(BeerType.ALE);
        beer4.setPercentageOfAlcohol(4.0);

        Brewery brewery1 = new Brewery();
        brewery1.setId(1);
        ArrayList<Beer> b1beers=new ArrayList<>();
        b1beers.add(beer1);b1beers.add(beer2);
        brewery1.setBeers(b1beers);
        Brewery brewery2 = new Brewery();
        brewery2.setId(2);
        ArrayList<Beer> b2beers=new ArrayList<>();
        b2beers.add(beer4);b2beers.add(beer3);
        brewery2.setBeers(b2beers);

        UserBeerLogger ub1=new UserBeerLogger();
        ub1.setId(1); ub1.setBeer(beer1);ub1.setUser(user);

        UserBeerLogger ub2=new UserBeerLogger();
        ub2.setId(2); ub2.setBeer(beer3);ub2.setUser(user2);

        Festival f= new Festival();
        f.setId(1);
        ArrayList<Brewery> breweries=new ArrayList<>();
        breweries.add(brewery2);
        f.setBreweries(breweries);

        //ksession.insert(rating2);

        ksession.insert(user);
        ksession.insert(user2);
        ksession.insert(f);
        ksession.insert(ub1);
        ksession.insert(ub2);

        int count = ksession.fireAllRules();
        System.out.println(count);
        fullDiscount = (ArrayList<User>)  ksession.getGlobal("fullDiscount");
        partialDiscount = (ArrayList<User>)  ksession.getGlobal("partialDiscount");
        for (User u:fullDiscount){
            System.out.println(u.getId());
        }

        System.out.println("------------------------------------");
        for (User u:partialDiscount){
            System.out.println(u.getId());
        }

    }
}
