package brewbuddy.tests;

import brewbuddy.events.Rating;
import brewbuddy.events.UserBeerLogger;
import brewbuddy.models.*;
import brewbuddy.models.enums.BeerType;
import org.drools.template.DataProvider;
import org.drools.template.DataProviderCompiler;
import org.drools.template.objects.ArrayDataProvider;
import org.junit.Ignore;
import org.junit.Test;
import org.kie.api.KieBaseConfiguration;
import org.kie.api.KieServices;
import org.kie.api.builder.Message;
import org.kie.api.builder.Results;
import org.kie.api.conf.EventProcessingOption;
import org.kie.api.io.ResourceType;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.kie.internal.utils.KieHelper;

import java.io.InputStream;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Ignore
public class CEPConfigTest {
    @Test
    public void beerRecommendation() {

        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("beerKsession");
        ksession.getAgenda().getAgendaGroup("beerRecommendation").setFocus();

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
        rating1.setRate(5);

        Rating rating2 = new Rating();
        rating2.setId(2);
        rating2.setBeer(beer2);
        rating2.setUser(user);
        rating2.setRate(5);

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
    public void festivalCoupon() {

        InputStream template = CEPConfigTest.class.getResourceAsStream("/rules/template/festivalCoupons.drt");
        DataProvider dataProvider = new ArrayDataProvider(new String[][]{
                new String[]{"1", "20", "10", "10"}
        });

        DataProviderCompiler converter = new DataProviderCompiler();
        String drl = converter.compile(dataProvider, template);

        System.out.println(drl);

        KieSession ksession = createKieSessionFromDRL(drl);

        ArrayList<FestivalCoupon> coupons = new ArrayList<>();
        ksession.setGlobal("coupons", coupons);


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
        ArrayList<Beer> b1beers = new ArrayList<>();
        b1beers.add(beer1);
        b1beers.add(beer2);
        brewery1.setBeers(b1beers);
        Brewery brewery2 = new Brewery();
        brewery2.setId(2);
        ArrayList<Beer> b2beers = new ArrayList<>();
        b2beers.add(beer4);
        b2beers.add(beer3);
        brewery2.setBeers(b2beers);

        UserBeerLogger ub1 = new UserBeerLogger();
        ub1.setId(1);
        ub1.setBeer(beer1);
        ub1.setUser(user);
        ub1.setTimestamp(new Date());

        UserBeerLogger ub2 = new UserBeerLogger();
        ub2.setId(2);
        ub2.setBeer(beer3);
        ub2.setUser(user2);
        LocalDate localDate = LocalDate.of(2023, 5, 28);
        ub2.setTimestamp(Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));

        Festival f = new Festival();
        f.setId(1);
        ArrayList<Brewery> breweries = new ArrayList<>();
        breweries.add(brewery2);
        breweries.add(brewery1);
        f.setBreweries(breweries);

        //ksession.insert(rating2);

        ksession.insert(user);
        ksession.insert(user2);
        ksession.insert(f);
        ksession.insert(ub1);
        ksession.insert(ub2);

        int count = ksession.fireAllRules();
        System.out.println(count);
        coupons = (ArrayList<FestivalCoupon>) ksession.getGlobal("coupons");
        System.out.println(coupons.size());

    }

    @Test
    public void breweryCoupon() {

        InputStream template = CEPConfigTest.class.getResourceAsStream("/rules/template/breweryCoupons.drt");
        DataProvider dataProvider = new ArrayDataProvider(new String[][]{
                new String[]{"2", "20", "10", "10"}
        });

        DataProviderCompiler converter = new DataProviderCompiler();
        String drl = converter.compile(dataProvider, template);

        System.out.println(drl);

        KieSession ksession = createKieSessionFromDRL(drl);

        ArrayList<BreweryCoupon> coupons = new ArrayList<>();
        ksession.setGlobal("coupons", coupons);


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
        ArrayList<Beer> b1beers = new ArrayList<>();
        b1beers.add(beer1);
        b1beers.add(beer2);
        brewery1.setBeers(b1beers);
        Brewery brewery2 = new Brewery();
        brewery2.setId(2);
        ArrayList<Beer> b2beers = new ArrayList<>();
        b2beers.add(beer4);
        b2beers.add(beer3);
        brewery2.setBeers(b2beers);

        UserBeerLogger ub1 = new UserBeerLogger();
        ub1.setId(1);
        ub1.setBeer(beer1);
        ub1.setUser(user);

        UserBeerLogger ub2 = new UserBeerLogger();
        ub2.setId(2);
        ub2.setBeer(beer2);
        ub2.setUser(user2);



        ksession.insert(brewery1);

        ksession.insert(user);
        ksession.insert(user2);
        ksession.insert(ub1);
        ksession.insert(ub2);

        int count = ksession.fireAllRules();
        System.out.println(count);
        coupons = (ArrayList<BreweryCoupon>) ksession.getGlobal("coupons");
        System.out.println(coupons.size());

    }
    private KieSession createKieSessionFromDRL(String drl){
        KieHelper kieHelper = new KieHelper();
        kieHelper.addContent(drl, ResourceType.DRL);

        Results results = kieHelper.verify();

        if (results.hasMessages(Message.Level.WARNING, Message.Level.ERROR)){
            List<Message> messages = results.getMessages(Message.Level.WARNING, Message.Level.ERROR);
            for (Message message : messages) {
                System.out.println("Error: "+message.getText());
            }

            throw new IllegalStateException("Compilation errors were found. Check the logs.");
        }

        return kieHelper.build(createStreamModeKieBaseConfiguration()).newKieSession();
    }
    private KieBaseConfiguration createStreamModeKieBaseConfiguration() {
        KieServices kieServices = KieServices.Factory.get();
        KieBaseConfiguration config = kieServices.newKieBaseConfiguration();
        config.setOption(EventProcessingOption.STREAM);
        return config;
    }
}
