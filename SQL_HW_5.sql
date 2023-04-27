CREATE DATABASE IF NOT EXISTS `HW_5`;
USE HW_5;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars 
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE VIEW cars1 AS
SELECT *
FROM cars
WHERE cars.cost < 25000;

SELECT *
FROM cars1;

-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
ALTER VIEW cars1 AS
SELECT *
FROM cars
WHERE cars.cost < 30000;


-- либо сразу создать представление с возможностью изменения:
/*
CREATE OR REPLACE VIEW cars1 AS
SELECT *
FROM cars
WHERE cars.cost < 30000;
*/

SELECT *
FROM cars1;

-- Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE VIEW cars2 AS
SELECT *
FROM cars
WHERE cars.name = "Skoda" or cars.name = "Audi";

SELECT *
FROM cars2;

CREATE TABLE trains(
	train_id INT NOT NUll,
    station VARCHAR(20) NOT NUll,
    station_time TIME NOT NUll
);

INSERT INTO trains
VALUES
(110, "San Francisco", '10:00:00'),
(110, "Redwood City", '10:54:00'),
(110, "Palo Alto", '11:02:00'),
(110, "San Jose", '12:35:00'),
(120, "San Francisco", '11:00:00'),
(120, "Palo Alto", '12:49:00'),
(120, "San Jose", '13:30:00');

SELECT 
	trains.*,
	SUBTIME (LEAD(station_time) OVER (PARTITION BY train_id), station_time) AS test
FROM trains;
