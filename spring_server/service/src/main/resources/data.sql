-- Cities
INSERT INTO Cities(id, name, postal_code) VALUES (1, 'Novi Sad', '21000');
INSERT INTO Cities(id, name, postal_code) VALUES (2, 'Beograd', '11000');
INSERT INTO Cities(id, name, postal_code) VALUES (3, 'Sremska Mitrovica', '22000');

-- Roles
INSERT INTO ROLES (id, name) VALUES(1, 'ROLE_ADMIN');
INSERT INTO ROLES (id, name) VALUES(2, 'ROLE_USER');

-- Users
INSERT INTO Users(id, name, surname, birth_date, is_account_non_expired, is_account_non_locked) VALUES (1, 'Vukasin', 'Bogdanovic', '2001-12-7', true, true);
INSERT INTO Users(id, name, surname, birth_date, is_account_non_expired, is_account_non_locked) VALUES (2, 'Jovan', 'Jokic', '2001-3-9', true, true);

-- Credentials
INSERT INTO Credentials(email, password, user_id, is_credentials_non_expired, is_enabled) VALUES ('vukasin@example.com', '$2a$12$uBftIaKM3BrgSaXFQNtDPeVHbyW6MuJNgVjLACB/hVElB6xKkyssS', 1, true, true);
INSERT INTO Credentials(email, password, user_id, is_credentials_non_expired, is_enabled) VALUES ('jovan@example.com', '$2a$12$HgYP3ud5pL7OXkDMhT1tmeUdDZBBXC9ZcBxnG/rixVEG.jPd.OTfq', 2, true, true);

INSERT INTO users_roles (credential_id, role_id) VALUES (1, 2);
INSERT INTO users_roles (credential_id, role_id) VALUES (2, 1);

-- Breweries
INSERT INTO Breweries(id, name, city_id) VALUES (1, '3Bir', 1);
INSERT INTO Breweries(id, name, city_id) VALUES (2, 'Dogma', 2);
INSERT INTO Breweries(id, name, city_id) VALUES (3, 'Manguliner', 3);

-- Beers
INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id) VALUES (1, 'Alpha Dog', '9.6', '60', '500', 'IPA', 1);
INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id) VALUES (2, 'Wartburg', '4.1', '30', '350', 'PILSNER', 1);
INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id) VALUES (3, 'Hoptopod', '6.5', '14', '280', 'IPA', 2);
INSERT INTO Beers(id, name, percentage_of_alcohol, ibu, price, type, brewery_id) VALUES (4, 'Manguliner', '4.2', '25', '420', 'PALE_ALE', 3);

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
