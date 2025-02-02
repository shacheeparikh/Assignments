create database ola_project;
use ola_project;
 
CREATE TABLE Driver (
    driver_id INT PRIMARY KEY,          -- Unique driver ID
    driver_name VARCHAR(100),           -- Driver's name
    vehicle_type ENUM('auto', 'bike', 'car'), -- Vehicle type (auto, bike, car)
    age INT,                            -- Driver's age
    charge_per_km DECIMAL(5,2),         -- Charge per km, with two decimal points
    availability ENUM('available', 'not available', 'reserved') -- Availability status
);

CREATE TABLE Passenger (
    pickup_point VARCHAR(255),         -- Pickup location (up to 255 characters)
    drop_point VARCHAR(255),           -- Drop-off location (up to 255 characters)
    km DECIMAL(5,2),                   -- Distance traveled (in kilometers)
    price DECIMAL(10,2),               -- Price for the journey (with 2 decimal places)
    driver_name VARCHAR(100),          -- Name of the driver
    driver_id INT primary key,                     -- ID of the driver (Foreign Key to the Driver table)
    journey_datetime DATETIME,         -- Date and time of the journey
	foreign key (driver_id) references Driver(driver_id)
);

ALTER TABLE Driver
ADD CONSTRAINT chk_age CHECK (age >= 18 AND age <= 69);

select * from driver left join passenger on driver.driver_ID= passenger.driver_ID;

select * from driver left join passenger on driver.driver_id = passenger.driver_id where vehicle_type='bike' and 
availability='available';

select * from driver right join passenger on driver.driver_id = passenger.driver_id where pickup_point='city center' and drop_point='mall';

select * from driver inner join passenger on driver.driver_id = passenger.driver_id where km='7.25' and vehicle_type='auto';

select * from driver inner join passenger on driver.driver_id = passenger.driver_id where charge_per_km='10.5' and drop_point like 'airport';

select * from driver inner join passenger on driver.driver_id = passenger.driver_id where age>32 and vehicle_type='car';

 



