create database ola_project;
use ola_project;

CREATE TABLE Driver (
    driver_id INT PRIMARY KEY,          -- Unique driver ID
    driver_name VARCHAR(100),           -- Driver's name
    vehicle_id int, 
    age INT		,                        -- Driver's age
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE,
    license_number VARCHAR(50) UNIQUE,
    charger_per_km DECIMAL(5,2) NOT NULL DEFAULT 10.00,         -- Charge per km, with two decimal points
    availability ENUM('available', 'not available', 'reserved') -- Availability status
);

CREATE TABLE Passenger (
 passenger_id INT PRIMARY KEY,
 name varchar(100),
 email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE,
    password VARCHAR(255),
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_type VARCHAR(50),
    vehicle_model VARCHAR(100),
    registration_number VARCHAR(50) UNIQUE,
    driver_id INT,
    status ENUM('Available', 'In Use', 'Under Maintenance') DEFAULT 'Available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- add vehicle_id as foreign key in driver table--
ALTER TABLE `ola_project`.`driver` 
ADD CONSTRAINT `vehicle_id`
  FOREIGN KEY (`vehicle_id`)
  REFERENCES `ola_project`.`vehicles` (`vehicle_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  -- add age constraint in driver table 
ALTER TABLE Driver
ADD CONSTRAINT chk_age CHECK (age >= 18 AND age <= 69);

INSERT INTO `ola_project`.`passenger` (`passenger_id`, `name`, `email`, `phone`, `password`) VALUES ('1', 'siya', 'siya@gmail.com', '1234567', '1234567');
INSERT INTO `ola_project`.`passenger` (`passenger_id`, `name`, `email`, `phone`, `password`) VALUES ('2', 'mira', 'mira@gnail.co', '11111', '12345');
INSERT INTO `ola_project`.`passenger` (`passenger_id`, `name`, `email`, `phone`, `password`) VALUES ('3', 'krina', 'krina@gnail.co', '123456789', 'tops123');

CREATE TABLE rides (
    ride_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT,
    driver_id INT,
    pickup_point VARCHAR(255),
    dropoff_point VARCHAR(255),
    ride_status ENUM('Requested', 'In Progress', 'Completed', 'Cancelled') DEFAULT 'Requested',
    ride_start_time TIMESTAMP,
    ride_end_time TIMESTAMP,
    distance DECIMAL(10, 2),
    price DECIMAL(10, 2) ,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (driver_id) REFERENCES driver(driver_id)
);


-- create trigger for calculating price of the ride based on distance and charge per km of driver before insert in rides table
DELIMITER $$

CREATE TRIGGER calculate_ride_price_before_insert
BEFORE INSERT ON rides
FOR EACH ROW
BEGIN
    -- Calculate the price based on distance and the driver's charger per km
    DECLARE charger DECIMAL(10, 2);
    
    -- Get the charge per km from the driver assigned to the ride
    SELECT charger_per_km INTO charger
    FROM driver
    WHERE driver_id = NEW.driver_id;
    
    -- Set the fare by multiplying distance with the driver's charge per km
    SET NEW.price = NEW.distance * charger;
END$$

DELIMITER ;

-- insert into rides table
INSERT INTO `ola_project`.`rides` (`passenger_id`, `driver_id`, `pickup_point`, `dropoff_point`, `ride_start_time`, `ride_end_time`, `distance`, `price`) VALUES ('2', '2', 'queens palace', 'station-2', '2025-02-14 09:00:00', '2025-02-14 10:00:00', '10', '100');
INSERT INTO `ola_project`.`rides` (`ride_id`, `passenger_id`, `driver_id`, `pickup_point`, `dropoff_point`, `ride_start_time`, `ride_end_time`, `distance`) VALUES ('3', '3', '3', 'kings square', 'mall of fame', '2025-02-14 09:00:00', '2025-02-14 09:50:00', '22');

-- get all the driver details with the matching ride details
select * from driver left join rides on driver.driver_ID= rides.driver_ID;

-- get all in active rides
SELECT * FROM rides WHERE ride_status = 'In Progress';

-- To get all the rides for a particular user:
SELECT * FROM rides WHERE driver_id = 1;

-- To check if a driver is available:
SELECT * FROM driver WHERE availability = 'available' AND driver_id = 1;

-- To Count Available Bikes
SELECT * FROM vehicles
WHERE vehicle_type = 'Bike' AND status = 'Available';

-- how many bikes are available
SELECT COUNT(*) AS available_bikes_count
FROM vehicles
WHERE vehicle_type = 'Bike' AND status = 'Available';

-- name of driver with the passenger name ='siya' and vehicle_type ='bike'
SELECT d.driver_name AS driver_name
FROM Passenger p
JOIN rides r ON p.passenger_id = r.passenger_id
JOIN driver d ON r.driver_id = d.driver_id
JOIN vehicles v ON d.vehicle_id = v.vehicle_id
WHERE p.name = 'siya' and v.vehicle_type='bike';

-- get details of driver whose drop off point is airport
select d.driver_name , age , availability , dropoff_point, ride_end_time from driver d right join rides r on d.driver_id = r.driver_id where pickup_point like 't%';

-- compare the current time with the ride_end_time and if it's more than 1 hour, it will update the status.
UPDATE rides
    SET ride_status = 'Completed'
    WHERE ride_status = 'In Progress'
    AND ride_end_time < NOW() - INTERVAL 1 HOUR;
    
-- update ride status to in progress if the ride has already started 
    update rides 
    set ride_status ='In Progress'
    where ride_status='Requested' and ride_start_time  < Now();

