CREATE DATABASE AIRLINE_MANAGEMENT_SYSTEM;
USE AIRLINE_MANAGEMENT_SYSTEM;

CREATE TABLE Airport (
    AirportID INTEGER PRIMARY KEY,
    AirportName TEXT NOT NULL,
    City TEXT NOT NULL,
    Country TEXT NOT NULL,
    AirportCode TEXT NOT NULL UNIQUE,
    Timezone TEXT NOT NULL
);

INSERT INTO Airport VALUES
(101, 'John F. Kennedy International Airport', 'New York', 'USA', 'JFK', 'EST'),
(102, 'Los Angeles International Airport', 'Los Angeles', 'USA', 'LAX', 'PST'),
(103, 'Heathrow Airport', 'London', 'UK', 'LHR', 'GMT'),
(104, 'Charles de Gaulle Airport', 'Paris', 'France', 'CDG', 'CET'),
(105, 'Tokyo Haneda Airport', 'Tokyo', 'Japan', 'HND', 'JST');


CREATE TABLE Airline (
    AirlineID SMALLINT UNSIGNED PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
);


INSERT INTO Airline (AirlineID, Name, Address) VALUES 
(1, 'American Airlines', '1 Skyview Dr, Fort Worth, TX 76155'),
(2, 'Delta Air Lines', '1030 Delta Blvd, Atlanta, GA 30354'),
(3, 'United Airlines', '233 S. Wacker Dr, Chicago, IL 60606'),
(4, 'Southwest Airlines', '2702 Love Field Dr, Dallas, TX 75235'),
(5, 'JetBlue Airways', '27-01 Queens Plaza N, Long Island City, NY 11101'),
(6, 'Alaska Airlines', '19300 International Blvd, Seattle, WA 98188'),
(7, 'Spirit Airlines', '2800 Executive Way, Miramar, FL 33025'),
(8, 'Frontier Airlines', '4545 Airport Way, Denver, CO 80239'),
(9, 'Allegiant Air', '1201 N Town Center Dr, Las Vegas, NV 89144'),
(10, 'Hawaiian Airlines', '3375 Koapaka St, Honolulu, HI 96819');




CREATE TABLE CrewMember (
    CrewMemberID INTEGER PRIMARY KEY,
    FullName TEXT NOT NULL,
    PhoneNumber TEXT NOT NULL,
    Email TEXT NOT NULL,
    HireDate TEXT NOT NULL,
    Salary REAL,
    Position TEXT NOT NULL
);

INSERT INTO CrewMember VALUES
(301, 'Captain James Mitchell', '555-123-4567', 'j.mitchell@airline.com', '2015-03-15', 125000.00, 'Captain'),
(302, 'First Officer Sarah Chen', '555-234-5678', 's.chen@airline.com', '2018-07-20', 85000.00, 'First Officer'),
(303, 'Flight Attendant Maria Rodriguez', '555-345-6789', 'm.rodriguez@airline.com', '2019-02-10', 45000.00, 'Senior Flight Attendant'),
(304, 'Captain Robert Wilson', '555-456-7890', 'r.wilson@airline.com', '2012-09-05', 130000.00, 'Captain'),
(305, 'Flight Attendant Kevin Park', '555-567-8901', 'k.park@airline.com', '2020-11-12', 42000.00, 'Flight Attendant');

CREATE TABLE Passenger (
    PassengerID INTEGER PRIMARY KEY,
    FullName TEXT NOT NULL,
    Email TEXT NOT NULL,
    PhoneNumber TEXT NOT NULL,
    DateOfBirth TEXT,
    PassportNumber TEXT,
    Nationality TEXT
);

INSERT INTO Passenger VALUES
(401, 'John Anderson', 'john.anderson@email.com', '555-111-2222', '1985-04-12', 'US123456789', 'American'),
(402, 'Lisa Wang', 'lisa.wang@email.com', '555-222-3333', '1990-08-25', 'CN987654321', 'Chinese'),
(403, 'Pierre Dubois', 'pierre.dubois@email.com', '555-333-4444', '1978-12-03', 'FR456789123', 'French'),
(404, 'Emma Thompson', 'emma.thompson@email.com', '555-444-5555', '1992-06-18', 'UK789123456', 'British'),
(405, 'Carlos Rivera', 'carlos.rivera@email.com', '555-555-6666', '1988-09-30', 'MX321654987', 'Mexican');

CREATE TABLE Pilot (
    CrewMemberID SMALLINT UNSIGNED PRIMARY KEY,
    LicenseNumber VARCHAR(20) NOT NULL UNIQUE,
    FlightHours INT UNSIGNED NOT NULL DEFAULT 0,
    AircraftTypeRating VARCHAR(100),
    MedicalCertificationDate DATE NOT NULL,
    FOREIGN KEY (CrewMemberID) REFERENCES CrewMember(CrewMemberID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Pilot VALUES
(301, 'ATP-123456789', 8500, 'Boeing 737, Boeing 777', '2024-06-15'),
(302, 'CPL-987654321', 3200, 'Airbus A320, Airbus A330', '2024-08-20'),
(304, 'ATP-456789123', 12000, 'Boeing 737, Boeing 777, Boeing 787', '2024-05-10');


CREATE TABLE Aircraft (
    AircraftID SMALLINT UNSIGNED PRIMARY KEY,
    Model VARCHAR(50) NOT NULL,
    Manufacturer VARCHAR(50) NOT NULL,
    Capacity SMALLINT UNSIGNED NOT NULL,
    Status VARCHAR(20) NOT NULL,
    LastMaintenanceDate DATE,
    YearManufactured YEAR NOT NULL
);

INSERT INTO Aircraft VALUES 
(201, 'Boeing 737-800', 'Boeing', 162, 'Active', '2024-11-15', 2018),
(202, 'Airbus A320', 'Airbus', 156, 'Active', '2024-12-01', 2019),
(203, 'Boeing 777-200', 'Boeing', 314, 'Maintenance', '2024-10-20', 2017),
(204, 'Airbus A330', 'Airbus', 277, 'Active', '2024-11-28', 2020),
(205, 'Boeing 787-9', 'Boeing', 290, 'Active', '2024-12-10', 2021);


CREATE TABLE FlightAttendant (
    CrewMemberID SMALLINT UNSIGNED PRIMARY KEY,
    CertificationLevel VARCHAR(20) NOT NULL,
    LanguagesSpoken VARCHAR(200),
    EmergencyTrainingDate DATE NOT NULL,
    FOREIGN KEY (CrewMemberID) REFERENCES CrewMember(CrewMemberID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO FlightAttendant VALUES
(303, 'Senior', 'English, Spanish, French', '2024-09-15'),
(305, 'Standard', 'English, Korean, Mandarin', '2024-10-22');


CREATE TABLE Route (
    RouteID SMALLINT UNSIGNED PRIMARY KEY,
    OriginAirportID SMALLINT UNSIGNED NOT NULL,
    DestinationAirportID SMALLINT UNSIGNED NOT NULL,
    Distance INT UNSIGNED NOT NULL,
    EstimatedDuration TIME NOT NULL,
    FOREIGN KEY (OriginAirportID) REFERENCES Airport(AirportID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (DestinationAirportID) REFERENCES Airport(AirportID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (OriginAirportID != DestinationAirportID)
);

INSERT INTO Route VALUES
(501, 101, 102, 2445, '06:00:00'),   -- JFK to LAX
(502, 102, 103, 5440, '11:30:00'),   -- LAX to LHR
(503, 103, 104, 214, '01:15:00'),    -- LHR to CDG
(504, 104, 105, 6053, '12:45:00'),   -- CDG to HND
(505, 101, 103, 3459, '07:30:00');   -- JFK to LHR



CREATE TABLE Flight (
    FlightID SMALLINT UNSIGNED PRIMARY KEY,
    FlightNumber VARCHAR(10) NOT NULL UNIQUE,
    AircraftID SMALLINT UNSIGNED NOT NULL,
    RouteID SMALLINT UNSIGNED NOT NULL,
    AirlineID SMALLINT UNSIGNED NOT NULL,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Scheduled',
    GateNumber VARCHAR(5),
    FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (ArrivalTime > DepartureTime)
);

INSERT INTO Flight VALUES 
(601, 'AA101', 201, 501, 1, '2024-12-20 08:00:00',
 '2024-12-20 14:00:00', 'Scheduled', 'A12'),
(602, 'DL202', 202, 502, 2, '2024-12-21 15:30:00',
 '2024-12-22 03:00:00', 'Scheduled', 'B7'),
(603, 'UA303', 204, 503, 3, '2024-12-22 09:15:00',
 '2024-12-22 10:30:00', 'Scheduled', 'C3'),
(604, 'SW404', 205, 504, 4, '2024-12-23 11:00:00',
 '2024-12-24 23:45:00', 'Scheduled', 'D15'),
(605, 'JB505', 203, 505, 5, '2024-12-24 20:30:00',
 '2024-12-25 04:00:00', 'Delayed', 'A8');

CREATE TABLE Booking (
    BookingID VARCHAR(10) PRIMARY KEY,
    PassengerID SMALLINT UNSIGNED NOT NULL,
    FlightID SMALLINT UNSIGNED NOT NULL,
    BookingDate DATETIME NOT NULL,
    SeatNumber VARCHAR(4) NOT NULL,
    Class VARCHAR(20) NOT NULL,
    Price DECIMAL(8,2) NOT NULL,
    BookingStatus VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE(FlightID, SeatNumber)
);

INSERT INTO Booking VALUES
('BK001', 401, 601, '2024-11-15 10:30:00', '12A', 'Economy', 450.00, 'Confirmed'),
('BK002', 402, 602, '2024-11-20 14:15:00', '3B', 'Business', 1200.00, 'Confirmed'),
('BK003', 403, 603, '2024-12-01 09:45:00', '15C', 'Economy', 180.00, 'Confirmed'),
('BK004', 404, 604, '2024-12-05 16:20:00', '1A', 'First', 2800.00, 'Confirmed'),
('BK005', 405, 605, '2024-12-10 11:10:00', '8D', 'Economy', 520.00, 'Confirmed');

CREATE TABLE Maintenance (
    MaintenanceID SMALLINT UNSIGNED AUTO_INCREMENT,
    AircraftID SMALLINT UNSIGNED NOT NULL,
    MaintenanceDate DATE NOT NULL,
    MaintenanceType VARCHAR(50) NOT NULL,
    Description TEXT,
    Cost DECIMAL(10,2) NOT NULL,
    TechnicianName VARCHAR(100) NOT NULL,
    NextMaintenanceDate DATE,
    PRIMARY KEY (MaintenanceID, AircraftID),
    FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Maintenance (AircraftID, MaintenanceDate, MaintenanceType, Description, Cost, TechnicianName, NextMaintenanceDate) VALUES
(201, '2024-11-15', 'Routine', 'Engine inspection and oil change', 5500.00, 'Mike Johnson', '2025-02-15'),
(202, '2024-12-01', 'Repair', 'Landing gear hydraulic system repair', 12000.00, 'Sarah Davis', '2025-03-01'),
(203, '2024-10-20', 'Major Overhaul', 'Complete engine overhaul', 85000.00, 'Robert Chen', '2025-04-20'),
(204, '2024-11-28', 'Routine', 'Avionics system check', 3200.00, 'Lisa Park', '2025-02-28'),
(205, '2024-12-10', 'Inspection', 'Annual safety inspection', 8500.00, 'David Wilson', '2025-12-10');

CREATE TABLE Luggage (
    BookingID VARCHAR(10) NOT NULL,
    PassengerID SMALLINT UNSIGNED NOT NULL,
    Weight DECIMAL(5,2) NOT NULL,
    LuggageType VARCHAR(20) NOT NULL,
    SpecialHandling VARCHAR(100),
    PRIMARY KEY (PassengerID, BookingID),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (Weight > 0)
);

INSERT INTO Luggage (BookingID, PassengerID, Weight, LuggageType, SpecialHandling) VALUES 
('BK001', 401, 23.5, 'Checked', NULL),
('BK001', 401, 7.2, 'Carry-on', NULL),
('BK002', 402, 18.3, 'Checked', 'Fragile Items'),
('BK003', 403, 25.1, 'Checked', NULL),
('BK004', 404, 15.8, 'Checked', 'Priority'),
('BK005', 405, 28.7, 'Checked', 'Heavy');

CREATE TABLE FlightCrew (
    FlightID SMALLINT UNSIGNED NOT NULL,
    CrewMemberID SMALLINT UNSIGNED NOT NULL,
    Role VARCHAR(30) NOT NULL,
    PRIMARY KEY (FlightID, CrewMemberID),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (CrewMemberID) REFERENCES CrewMember(CrewMemberID)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

INSERT INTO FlightCrew VALUES
(601, 301, 'Captain'),
(601, 302, 'First Officer'),
(601, 303, 'Senior Flight Attendant'),
(602, 304, 'Captain'),
(602, 305, 'Flight Attendant'),
(603, 301, 'Captain'),
(603, 303, 'Senior Flight Attendant'),
(604, 302, 'First Officer'),
(604, 305, 'Flight Attendant'),
(605, 304, 'Captain');