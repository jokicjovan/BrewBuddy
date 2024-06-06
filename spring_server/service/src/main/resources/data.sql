-- Cities
INSERT INTO Cities(id, name, postal_code) VALUES (1, 'Novi Sad', '21000');
INSERT INTO Cities(id, name, postal_code) VALUES (2, 'Beograd', '11000');
INSERT INTO Cities(id, name, postal_code) VALUES (3, 'Sremska Mitrovica', '22000');

-- Roles
INSERT INTO Roles (id, name) VALUES(1, 'ROLE_USER');
INSERT INTO Roles (id, name) VALUES(2, 'ROLE_ADMIN');

-- Users
INSERT INTO Users(id, name, surname, birth_date, is_account_non_expired, is_account_non_locked) VALUES (1, 'Vukasin', 'Bogdanovic', '2001-12-7', true, true);
INSERT INTO Users(id, name, surname, birth_date, is_account_non_expired, is_account_non_locked) VALUES (2, 'Jovan', 'Jokic', '2001-3-9', true, true);

-- Credentials
INSERT INTO Credentials(id, email, password, user_id, is_credentials_non_expired, is_enabled) VALUES (1, 'vukasin@example.com', '$2a$12$uBftIaKM3BrgSaXFQNtDPeVHbyW6MuJNgVjLACB/hVElB6xKkyssS', 1, true, true);
INSERT INTO Credentials(id, email, password, user_id, is_credentials_non_expired, is_enabled) VALUES (2, 'jovan@example.com', '$2a$12$HgYP3ud5pL7OXkDMhT1tmeUdDZBBXC9ZcBxnG/rixVEG.jPd.OTfq', 2, true, true);

INSERT INTO users_roles (credential_id, role_id) VALUES (1, 1);
INSERT INTO users_roles (credential_id, role_id) VALUES (2, 2);

-- Breweries
INSERT INTO Breweries(id, name, city_id, image_name) VALUES (1, '3Bir', 1, '9efb59f7-e6e6-4818-9ca3-56afb7a693be');
INSERT INTO Breweries(id, name, city_id, image_name) VALUES (2, 'Dogma', 2, '08dfc3e6-ce9f-41f3-b8a5-4a2143e0e31a');
INSERT INTO Breweries(id, name, city_id, image_name) VALUES (3, 'Manguliner', 3, 'b2db119a-4000-4886-ad04-9b15e0bcadbe');
-- INSERT INTO Breweries(id, name, city_id, image_name) VALUES (4, 'K and B', 2, 'dc4c64fa-dfcc-4f37-874e-6a14e72a5aa2');
-- INSERT INTO Breweries(id, name, city_id, image_name) VALUES (5, 'Salto', 2, '7b20669f-e393-428c-84a2-fe64e6c027df');
-- INSERT INTO Breweries(id, name, city_id, image_name) VALUES (6, 'Gvint', 2, '9f2f3c9d-8f88-49ff-bf18-b36f9dfb680a');

-- Beers
INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (1, 'Alpha Dog', '9.6', '60', '500', 'IPA', 1, 'a9ec73da-16af-4802-ab30-7eba85115b29');
INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (2, 'Wartburg', '4.1', '30', '350', 'PILSNER', 1, '1f49be15-d84b-442e-b8f1-dee9bd24e165');
INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (3, 'Hoptopod', '6.5', '14', '280', 'IPA', 2, 'd84a05ec-229e-442e-901e-dd2db24dbe56');
INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (4, 'Manguliner', '4.2', '25', '420', 'PALE_ALE', 3, 'a39e5942-4a19-4e9e-8a20-3af1698504e7');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (5, 'Gold Fever', '6', '40', '420', 'ALE', 4, '03147650-6b5f-4790-85f2-15f7d3822106');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (6, 'Red', '8', '70', '420', 'PILSNER', 4, '3064cce8-2559-42a6-9b17-dd3db3e0ff37');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (7, 'Stout', '5.5', '85', '420', 'STOUT', 4, 'd19c3e8f-532d-4ac6-a322-ebf9a4b04224');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (8, 'Pils', '5.5', '35', '420', 'PILSNER', 4, '6993ebdc-3eaa-43c7-b833-5d6624cb8d09');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (9, 'Trkac', '4.4', '20', '280', 'PALE_ALE', 2, '9080aaec-0076-4c97-aeea-bf1279206cd9');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (10, 'Age of Lamb', '5.0', '70', '280', 'STOUT', 2, 'd88297e0-af09-4d3a-94c0-8b38908c5ada');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (11, 'Albino', '6.5', '50', '280', 'IPA', 2, '866c7f5d-1065-4a05-9edf-bb44af160ab3');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (12, 'Pale Ale', '5.7', '35', '280', 'IPA', 5, 'aa05963e-f42e-49a7-8dea-b8b43f6f2bd2');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (13, 'Belgrade', '6.5', '45', '280', 'IPA', 5, '88f2def8-fd21-4c6c-b8b8-5340bf766dad');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (14, 'Stout', '5.5', '24', '280', 'STOUT', 5, 'f0e5c79f-32e0-4eca-ba90-47a275eef0e3');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (15, 'Lager', '4.8', '28', '280', 'LAGER', 5, '2fcb262f-3d1b-4e72-a852-6020982ad918');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (16, 'WIT', '4.9', '14', '280', 'PILSNER', 5, '04dd2a5e-7ab7-48a2-bc9d-8cb2670682bc');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (17, '5#', '5.5', '45', '280', 'IPL', 6, '2a6c5aaa-0b71-40da-ba67-b22ea5974997');
-- INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id, image_name) VALUES (18, 'Orthodox Celts', '4.8', '30', '280', 'PILSNER', 6, '0c869953-084f-46a8-a45a-74bad019cf30');

-- Festivals
INSERT INTO Festivals(id, name, event_date, city_id) VALUES (1, 'Dani piva', '2024-9-10', 1);
INSERT INTO Festivals(id, name, event_date, city_id) VALUES (2, 'Beer fest', '2024-10-10', 2);

INSERT INTO Festivals_Breweries(festival_id, brewery_id) VALUES (1, 1);
INSERT INTO Festivals_Breweries(festival_id, brewery_id) VALUES (1, 2);
INSERT INTO Festivals_Breweries(festival_id, brewery_id) VALUES (2, 3);
INSERT INTO Festivals_Breweries(festival_id, brewery_id) VALUES (2, 2);

-- Coupons
INSERT INTO Coupons(valid_until, discount_percentage, type, user_id) VALUES('2024-10-10', 10, 'APPLICATION', 1);
INSERT INTO Coupons(valid_until, discount_percentage, type, user_id) VALUES('2024-1-1', 80, 'APPLICATION', 1);
INSERT INTO Coupons(valid_until, discount_percentage, type, user_id, festival_id) VALUES('2024-10-1', 20, 'FESTIVAL', 1, 1);
INSERT INTO Coupons(valid_until, discount_percentage, type, user_id, brewery_id) VALUES('2024-10-1', 30, 'BREWERY', 1, 3);

-- Ratings
INSERT INTO Ratings(rate, comment, user_id, beer_id, timestamp) VALUES(5, 'nice', 1, 1, '2024-10-10');

INSERT INTO Coupon_Criterias(id,type,min_beers,percentage,expire_in,days_range) VALUES (1,'FESTIVAL',2,50,10,30);
INSERT INTO Coupon_Criterias(id,type,min_beers,percentage,expire_in,days_range) VALUES (2,'BREWERY',2,50,10,30);
INSERT INTO Coupon_Criterias(id,type,min_beers,percentage,expire_in,days_range) VALUES (3,'APPLICATION',2,50,10,30);

INSERT INTO Users_Beers_Logger(id,user_id,beer_id,timestamp) VALUES ( 1,1,1,'2024-06-02');
INSERT INTO Users_Beers_Logger(id,user_id,beer_id,timestamp) VALUES ( 2,1,2,'2024-06-02');
INSERT INTO Users_Beers_Logger(id,user_id,beer_id,timestamp) VALUES ( 3,1,3,'2024-06-02');
INSERT INTO Users_Beers_Logger(id,user_id,beer_id,timestamp) VALUES ( 4,1,4,'2024-06-02');


ALTER TABLE Cities ALTER COLUMN id RESTART WITH (SELECT MAX(id) + 1 FROM Cities);
ALTER TABLE Roles ALTER COLUMN id RESTART WITH (SELECT MAX(id) + 1 FROM ROLES);
ALTER TABLE Users ALTER COLUMN id RESTART WITH (SELECT MAX(id) + 1 FROM Users);
ALTER TABLE Credentials ALTER COLUMN id RESTART WITH (SELECT MAX(id) + 1 FROM Credentials);
ALTER TABLE Breweries ALTER COLUMN id RESTART WITH (SELECT MAX(id) + 1 FROM Breweries);
ALTER TABLE Festivals ALTER COLUMN id RESTART WITH (SELECT MAX(id) + 1 FROM Festivals);
ALTER TABLE Coupons ALTER COLUMN id RESTART WITH (SELECT MAX(id) + 1 FROM Coupons);
ALTER TABLE Ratings ALTER COLUMN id RESTART WITH (SELECT MAX(id) + 1 FROM Ratings);
ALTER TABLE Users_Beers_Logger ALTER COLUMN id RESTART WITH (SELECT MAX(id) + 1 FROM Users_Beers_Logger);
