-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bookWorlds
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bookWorlds` ;

-- -----------------------------------------------------
-- Schema bookWorlds
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bookWorlds` DEFAULT CHARACTER SET utf8 ;
USE `bookWorlds` ;

-- -----------------------------------------------------
-- Table `bookWorlds`.`account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bookWorlds`.`account` ;

CREATE TABLE IF NOT EXISTS `bookWorlds`.`account` (
  `code` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `role` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookWorlds`.`book_club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bookWorlds`.`book_club` ;

CREATE TABLE IF NOT EXISTS `bookWorlds`.`book_club` (
  `name` VARCHAR(30) NOT NULL,
  `owner` VARCHAR(45) NOT NULL,
  `numberOfSubscribers` INT NOT NULL DEFAULT 0,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `owner_account_idx` (`owner` ASC) VISIBLE,
  CONSTRAINT `owner_account`
    FOREIGN KEY (`owner`)
    REFERENCES `bookWorlds`.`account` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookWorlds`.`book_club_genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bookWorlds`.`book_club_genres` ;

CREATE TABLE IF NOT EXISTS `bookWorlds`.`book_club_genres` (
  `bookclub` VARCHAR(30) NOT NULL,
  `genre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`bookclub`, `genre`),
  CONSTRAINT `genre_bookclub`
    FOREIGN KEY (`bookclub`)
    REFERENCES `bookWorlds`.`book_club` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookWorlds`.`subscribers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bookWorlds`.`subscribers` ;

CREATE TABLE IF NOT EXISTS `bookWorlds`.`subscribers` (
  `bookclub` VARCHAR(30) NOT NULL,
  `reader` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`bookclub`, `reader`),
  INDEX `subscribers_reader_idx` (`reader` ASC) VISIBLE,
  CONSTRAINT `subscribers_reader`
    FOREIGN KEY (`reader`)
    REFERENCES `bookWorlds`.`account` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `bookclub_name`
    FOREIGN KEY (`bookclub`)
    REFERENCES `bookWorlds`.`book_club` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookWorlds`.`subscription_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bookWorlds`.`subscription_requests` ;

CREATE TABLE IF NOT EXISTS `bookWorlds`.`subscription_requests` (
  `bookclub` VARCHAR(30) NOT NULL,
  `reader` VARCHAR(30) NOT NULL,
  `state` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`bookclub`, `reader`),
  INDEX `subscription_reader_idx` (`reader` ASC) VISIBLE,
  CONSTRAINT `subscription_bookclub`
    FOREIGN KEY (`bookclub`)
    REFERENCES `bookWorlds`.`book_club` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `subscription_reader`
    FOREIGN KEY (`reader`)
    REFERENCES `bookWorlds`.`account` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS bookworlds_generic_user;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'bookworlds_generic_user' IDENTIFIED BY 'bookworlds';

GRANT ALL ON TABLE `bookWorlds`.`account` TO 'bookworlds_generic_user';
GRANT ALL ON TABLE `bookWorlds`.`book_club` TO 'bookworlds_generic_user';
GRANT ALL ON TABLE `bookWorlds`.`book_club_genres` TO 'bookworlds_generic_user';
GRANT ALL ON TABLE `bookWorlds`.`subscribers` TO 'bookworlds_generic_user';
GRANT ALL ON TABLE `bookWorlds`.`subscription_requests` TO 'bookworlds_generic_user';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `bookWorlds`.`account`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookWorlds`;
INSERT INTO `bookWorlds`.`account` (`code`, `username`, `password`, `email`, `role`) VALUES (1, 'elisaV', 'password', 'elisaverdi@gmail.com', 'Reader');
INSERT INTO `bookWorlds`.`account` (`code`, `username`, `password`, `email`, `role`) VALUES (2, 'bookLover', 'Password', 'rossiviola@gmail.com', 'Curator');
INSERT INTO `bookWorlds`.`account` (`code`, `username`, `password`, `email`, `role`) VALUES (3, 'lucaC', 'luca.c', 'luca.c@gmail.com', 'Curator');
INSERT INTO `bookWorlds`.`account` (`code`, `username`, `password`, `email`, `role`) VALUES (4, 'antoni', '12345', 'antoni@gmail.com', 'Reader');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bookWorlds`.`book_club`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookWorlds`;
INSERT INTO `bookWorlds`.`book_club` (`name`, `owner`, `numberOfSubscribers`, `capacity`) VALUES ('ReadingIsFun', 'bookLover', 3, 30);
INSERT INTO `bookWorlds`.`book_club` (`name`, `owner`, `numberOfSubscribers`, `capacity`) VALUES ('Club', 'bookLover', 45, 45);
INSERT INTO `bookWorlds`.`book_club` (`name`, `owner`, `numberOfSubscribers`, `capacity`) VALUES ('ActionReading', 'bookLover', 0, 10);
INSERT INTO `bookWorlds`.`book_club` (`name`, `owner`, `numberOfSubscribers`, `capacity`) VALUES ('NuovoClub', 'bookLover', 0, 30);
INSERT INTO `bookWorlds`.`book_club` (`name`, `owner`, `numberOfSubscribers`, `capacity`) VALUES ('MysteriousClub', 'lucaC', 1, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `bookWorlds`.`book_club_genres`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookWorlds`;
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('ReadingIsFun', 'FANTASY');
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('Club', 'TRAVEL');
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('Club', 'HISTORY');
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('Club', 'FANTASY');
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('ActionReading', 'SCI_FI');
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('ActionReading', 'ACTION');
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('NuovoClub', 'ROMANCE');
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('NuovoClub', 'DYSTOPIAN');
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('MysteriousClub', 'DYSTOPIAN');
INSERT INTO `bookWorlds`.`book_club_genres` (`bookClub`, `genre`) VALUES ('MysteriousClub', 'THRILLER');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bookWorlds`.`subscribers`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookWorlds`;
INSERT INTO `bookWorlds`.`subscribers` (`bookclub`, `reader`) VALUES ('ReadingIsFun', 'elisaV');
INSERT INTO `bookWorlds`.`subscribers` (`bookclub`, `reader`) VALUES ('ReadingIsFun', 'antoni');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bookWorlds`.`subscription_requests`
-- -----------------------------------------------------
START TRANSACTION;
USE `bookWorlds`;
INSERT INTO `bookWorlds`.`subscription_requests` (`bookclub`, `reader`, `state`) VALUES ('ReadingIsFun', 'elisaV', 'ACCEPTED');
INSERT INTO `bookWorlds`.`subscription_requests` (`bookclub`, `reader`, `state`) VALUES ('Club', 'elisaV', 'ACCEPTED');
INSERT INTO `bookWorlds`.`subscription_requests` (`bookclub`, `reader`, `state`) VALUES ('Club', 'antoni', 'REJECTED');
INSERT INTO `bookWorlds`.`subscription_requests` (`bookclub`, `reader`, `state`) VALUES ('ActionReading', 'elisaV', 'PENDING');

COMMIT;

