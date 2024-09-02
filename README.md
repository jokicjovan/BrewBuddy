# Brew Buddy
This software solution is a rule-based recommendation system designed to assist beer enthusiasts in exploring a wide variety of beers and discovering options that best match their taste preferences. Beyond recommendations, the system provides users with relevant information about new beers, their breweries, and upcoming beer festivals. Additionally, the system allows users to rate beers, log consumed beers, and track reports over specific time periods.

Users have the ability to search for and rate beers, view a list of personalized beer recommendations, access a list of the most popular beers over a given period, and review previously rated beers.

Beer recommendations are generated based on the following data:

- Positively rated beers
- Negatively rated beers
- Currently trending beers
- The quantity of beer consumed by each user
- Specific characteristics of beers, such as type, brewery, IBU, and alcohol content

The following rules have been implemented to guide beer recommendations:
- If a user rates a beer highly, the category of that beer is considered preferred.
- If a user rates a beer highly, the brewery of that beer is also considered preferred.
- If a user rates a beer with high or low alcohol content highly, it is assumed the user favors such beers.
- If a user consumes two or more beers from the same brewery within the last five days, the most popular beer from that brewery is recommended.
- If a user has rated more than three beers from the same manufacturer within the last 30 days, the most popular beer from that manufacturer is recommended.
- If a user has rated beers with higher or lower alcohol content highly within the last seven days, similar beers with higher or lower alcohol content are recommended.
- If a user has rated beers with higher or lower bitterness highly within the last seven days, beers with similar bitterness levels are recommended.
- If a user has rated five or more beers from a specific manufacturer poorly within the last 30 days, beers from that manufacturer are not recommended.
- If a user has rated five or more beers from a particular category poorly within the last 30 days, beers from that category are not recommended.
Additional rules implemented within the system include:
- When an administrator creates a festival, the quantities of beers available at the festival that each user has consumed are accumulated, and the top N users with the highest beer consumption receive a coupon for free festival entry.
- Multi-criteria search results prioritize beers that meet all criteria, followed by those that satisfy only some of the criteria.
- Upon the creation of a festival, a promotional message is sent to all users in the vicinity who have previously consumed at least one of the beers featured at the festival.
- If a user consumes five or more beers within a six-hour period, a warning message is sent to them.


The system also includes a template mechanism that allows administrators to manage the rules for generating coupons. There are three types of coupons that can be configured:
- Loyalty Brewery Coupon: This coupon is generated when a user consumes a minimum of X beers from a specific brewery. The user receives a discount of Y% with a validity period of Z days. The administrator can also set the time range used to determine which users meet the criteria.
- Loyalty App Coupon: This coupon is generated when a user consumes a minimum of X beers across all breweries. The user receives a discount of Y% with a validity period of Z days. Similar to the brewery-specific coupon, the administrator can set the time range used to determine eligibility.
- Festival Coupon: When an administrator creates a festival, the system accumulates the quantities of beers available at the festival that each user has consumed. The top X users with the highest beer consumption receive a coupon for free festival entry.

## Backend
The server is implemented in Java, using the Spring Boot framework. For rapid development, an H2 database was used. Also, Drools rule engine is integrated into system.

## Client
The frontend is developed using Flutter. As the system revolves around beer recommendations and user interaction, a mobile application provides the most effective solution for reaching users on the go. The design of the application follows Material Design principles.

## Screenshots
| <img src="https://github.com/user-attachments/assets/68a68ed4-36de-42e3-a3e7-927e27cac577" alt="Screenshot_20240902_083449" width="200"/> |<img src="https://github.com/user-attachments/assets/5ab6070e-103d-4dc3-a8e0-311e1a27644f" alt="Screenshot_20240902_083703" width="200"/>| <img src="https://github.com/user-attachments/assets/a0dfcc77-3bb6-4b89-bb42-4954fb4ef185" alt="Screenshot_20240902_090949" width="200"/> | <img src="https://github.com/user-attachments/assets/a57b15b4-624a-45f2-a7bd-2e6b84584439" alt="Screenshot_20240902_083758" width="200"/>|
|:--:| :--:| :--:| :--:|
| *Login* | *Home page* | *Drunk alert*| *Popular Items*|

| <img src="https://github.com/user-attachments/assets/a7dedf12-9715-4350-898f-73f0734717c7" alt="Screenshot_20240902_083743" width="200"/>  |<img src="https://github.com/user-attachments/assets/415a7dbf-ceaa-4a8a-977a-f9a197f27d7c" alt="Screenshot_20240902_090825" width="200"/>  |<img src="https://github.com/user-attachments/assets/0d1ba47a-a83a-4051-baf3-46905984a6de" alt="Screenshot_20240902_090905" width="200"/>   | <img src="https://github.com/user-attachments/assets/d23892c6-0267-413d-8060-080b33ff4dae" alt="Screenshot_20240902_090925" width="200"/>|
|:--:| :--:| :--:| :--:|
| *Search* | *Beer page* | *Brewery page*| *Festival page*|

| <img src="https://github.com/user-attachments/assets/6142fc5e-a675-4243-a34e-32a44034f831" alt="Screenshot_20240902_083809" width="200"/>  |<img src="https://github.com/user-attachments/assets/00e42441-1e4b-4b0d-9706-9951a1f31127" alt="Screenshot_20240902_090526" width="200"/>  |<img src="https://github.com/user-attachments/assets/e10c132d-9c43-4f17-9106-a992890f84dc" alt="Screenshot_20240902_083824" width="200"/>    |
|:--:| :--:| :--:|
| *Coupon* | *Generate Coupon* | *Rate Beer*|

## Installation Guide

To set up and run the backend of the BrewBuddy project, follow these steps:

1. Maven install "model" project
2. Maven install "kjar" project
3. Maven install "service" project
4. Run Spring Application

To set up and run the frontend of the BrewBuddy project, follow these steps:

1. Set your IP address inside /lib/assets/constants.dart
2. Run main activity on emulator or your android device

## Authors

- [Jovan Jokić](https://github.com/jokicjovan)
- [Vukašin Bogdanović](https://github.com/vukasinb7)
