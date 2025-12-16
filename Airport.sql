-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`crew` (
  `CrewID` CHAR(11) NOT NULL,
  `FirstName` VARCHAR(50) NULL,
  `LastName` VARCHAR(50) NULL,
  `Role` VARCHAR(30) NULL,
  `LicenseNo` VARCHAR(50) NULL,
  `ContactPhone` VARCHAR(20) NULL,
  PRIMARY KEY (`CrewID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`passengers` (
  `PassengerID` CHAR(11) NOT NULL,
  `FirstName` VARCHAR(50) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `DateOfBirth` DATE NULL,
  `Gender` CHAR(1) NULL,
  `Email` VARCHAR(100) NULL,
  `Phone` VARCHAR(20) NULL,
  `PassportNo` VARCHAR(20) NULL,
  `Nationality` VARCHAR(50) NULL,
  PRIMARY KEY (`PassengerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bookings` (
  `BookingID` CHAR(11) NOT NULL,
  `BookingRef` VARCHAR(12) NOT NULL,
  `PassengerID` CHAR(11) NOT NULL,
  `BookingDate` DATETIME NULL,
  `TotalAmount` DECIMAL(10,2) NOT NULL,
  `BookingStatus` VARCHAR(20) NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `PassengerID_idx` (`PassengerID` ASC) VISIBLE,
  CONSTRAINT `PassengerID`
    FOREIGN KEY (`PassengerID`)
    REFERENCES `mydb`.`passengers` (`PassengerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payments` (
  `PaymentID` CHAR(11) NOT NULL,
  `BookingID` CHAR(11) NOT NULL,
  `PaidAmount` DECIMAL(10,2) NULL,
  `PaidOn` DATETIME NULL,
  `PaymentMethod` VARCHAR(30) NULL,
  `TransactionRef` VARCHAR(50) NULL,
  PRIMARY KEY (`PaymentID`),
  INDEX `BookingID_idx` (`BookingID` ASC) VISIBLE,
  CONSTRAINT `BookingID`
    FOREIGN KEY (`BookingID`)
    REFERENCES `mydb`.`bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`airlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`airlines` (
  `AirlineID` CHAR(11) NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `IATA_Code` CHAR(2) NOT NULL,
  PRIMARY KEY (`AirlineID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`airports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`airports` (
  `AirportID` CHAR(11) NOT NULL,
  `Name` VARCHAR(150) NOT NULL,
  `City` VARCHAR(100) NULL,
  `Country` VARCHAR(100) NULL,
  `IATA_Code` CHAR(3) NOT NULL,
  `ICAO_Code` CHAR(4) NULL,
  `Latitude` DOUBLE NULL,
  `Longitude` DOUBLE NULL,
  PRIMARY KEY (`AirportID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`routes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`routes` (
  `RouteID` CHAR(11) NOT NULL,
  `AirlineID` CHAR(11) NOT NULL,
  `OriginAirportID` CHAR(11) NOT NULL,
  `DestinationAirportID` CHAR(11) NOT NULL,
  `DistanceKM` INT NULL,
  `RouteCode` VARCHAR(10) NULL,
  PRIMARY KEY (`RouteID`),
  INDEX `AirlineID_idx` (`AirlineID` ASC) VISIBLE,
  INDEX `OriginAirportID_idx` (`OriginAirportID` ASC) VISIBLE,
  INDEX `DestinationAirportID_idx` (`DestinationAirportID` ASC) VISIBLE,
  CONSTRAINT `AirlineID`
    FOREIGN KEY (`AirlineID`)
    REFERENCES `mydb`.`airlines` (`AirlineID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `OriginAirportID`
    FOREIGN KEY (`OriginAirportID`)
    REFERENCES `mydb`.`airports` (`AirportID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DestinationAirportID`
    FOREIGN KEY (`DestinationAirportID`)
    REFERENCES `mydb`.`airports` (`AirportID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`aircrafts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aircrafts` (
  `AircraftID` CHAR(11) NOT NULL,
  `Model` VARCHAR(50) NOT NULL,
  `RegistrationNo` VARCHAR(100) NOT NULL,
  `Capacity` INT NOT NULL,
  `ManufactureYear` INT NULL,
  `airlines_AirlineID` CHAR(11) NOT NULL,
  PRIMARY KEY (`AircraftID`),
  INDEX `fk_aircrafts_airlines1_idx` (`airlines_AirlineID` ASC) VISIBLE,
  CONSTRAINT `fk_aircrafts_airlines1`
    FOREIGN KEY (`airlines_AirlineID`)
    REFERENCES `mydb`.`airlines` (`AirlineID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`flights` (
  `FlightID` CHAR(11) NOT NULL,
  `RouteID` CHAR(11) NOT NULL,
  `AircraftID` CHAR(11) NOT NULL,
  `FlightNumber` VARCHAR(45) NOT NULL,
  `DepartureUTC` DATETIME NOT NULL,
  `ArrivalUTC` DATETIME NOT NULL,
  `Status` VARCHAR(20) NULL,
  `Gate` VARCHAR(10) NULL,
  `BlockTimeMins` INT NULL,
  PRIMARY KEY (`FlightID`),
  INDEX `RouteID_idx` (`RouteID` ASC) VISIBLE,
  INDEX `AircraftID_idx` (`AircraftID` ASC) VISIBLE,
  CONSTRAINT `RouteID`
    FOREIGN KEY (`RouteID`)
    REFERENCES `mydb`.`routes` (`RouteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AircraftID`
    FOREIGN KEY (`AircraftID`)
    REFERENCES `mydb`.`aircrafts` (`AircraftID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`crewassignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`crewassignments` (
  `AssignmentID` CHAR(11) NOT NULL,
  `FlightID` CHAR(11) NOT NULL,
  `CrewID` CHAR(11) NOT NULL,
  PRIMARY KEY (`AssignmentID`),
  INDEX `CrewID_idx` (`CrewID` ASC) VISIBLE,
  INDEX `FlightID_idx` (`FlightID` ASC) VISIBLE,
  CONSTRAINT `CrewID`
    FOREIGN KEY (`CrewID`)
    REFERENCES `mydb`.`crew` (`CrewID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FlightID`
    FOREIGN KEY (`FlightID`)
    REFERENCES `mydb`.`flights` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fareclasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fareclasses` (
  `FareClassID` CHAR(11) NOT NULL,
  `Code` CHAR(2) NOT NULL,
  `Description` VARCHAR(50) NULL,
  `Multiplier` DOUBLE NOT NULL,
  PRIMARY KEY (`FareClassID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seats` (
  `SeatID` CHAR(11) NOT NULL,
  `SeatNumber` VARCHAR(45) NOT NULL,
  `FareClassID` CHAR(11) NOT NULL,
  `IsAvailable` TINYINT NULL,
  `flights_FlightID` CHAR(11) NOT NULL,
  PRIMARY KEY (`SeatID`, `SeatNumber`),
  INDEX `FareClassID_idx` (`FareClassID` ASC) VISIBLE,
  INDEX `fk_seats_flights1_idx` (`flights_FlightID` ASC) VISIBLE,
  CONSTRAINT `FareClassID`
    FOREIGN KEY (`FareClassID`)
    REFERENCES `mydb`.`fareclasses` (`FareClassID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seats_flights1`
    FOREIGN KEY (`flights_FlightID`)
    REFERENCES `mydb`.`flights` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tickets` (
  `TicketID` CHAR(11) NOT NULL,
  `SeatID` CHAR(11) NULL,
  `TicketNo` VARCHAR(20) NOT NULL,
  `FareAmount` DECIMAL(10,2) NOT NULL,
  `TicketStatus` VARCHAR(20) NULL,
  `bookings_BookingID` CHAR(11) NOT NULL,
  `flights_FlightID` CHAR(11) NOT NULL,
  PRIMARY KEY (`TicketID`),
  INDEX `SeatID_idx` (`SeatID` ASC) VISIBLE,
  INDEX `fk_tickets_bookings1_idx` (`bookings_BookingID` ASC) VISIBLE,
  INDEX `fk_tickets_flights1_idx` (`flights_FlightID` ASC) VISIBLE,
  CONSTRAINT `SeatID`
    FOREIGN KEY (`SeatID`)
    REFERENCES `mydb`.`seats` (`SeatID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_bookings1`
    FOREIGN KEY (`bookings_BookingID`)
    REFERENCES `mydb`.`bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_flights1`
    FOREIGN KEY (`flights_FlightID`)
    REFERENCES `mydb`.`flights` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
