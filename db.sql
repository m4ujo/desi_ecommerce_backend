-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema desidb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema desidb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `desidb` DEFAULT CHARACTER SET utf8 ;
USE `desidb` ;

-- -----------------------------------------------------
-- Table `desidb`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desidb`.`categories` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `desidb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desidb`.`users` (
  `userId` CHAR(36) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `token` VARCHAR(255) NULL DEFAULT NULL,
  `firstName` VARCHAR(255) NULL DEFAULT NULL,
  `lastName` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  `street` VARCHAR(255) NULL DEFAULT NULL,
  `role` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `desidb`.`shoppingCarts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desidb`.`shoppingCarts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  `userId` CHAR(36) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `shoppingCarts_ibfk_1`
    FOREIGN KEY (`userId`)
    REFERENCES `desidb`.`users` (`userId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `userId` ON `desidb`.`shoppingCarts` (`userId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `desidb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desidb`.`orders` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  `street` VARCHAR(255) NULL DEFAULT NULL,
  `deliveryDate` VARCHAR(255) NULL DEFAULT NULL,
  `creditCardNumber` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  `userId` CHAR(36) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `shoppingCartId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`userId`)
    REFERENCES `desidb`.`users` (`userId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`shoppingCartId`)
    REFERENCES `desidb`.`shoppingCarts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `orders_shoppingCartId_userId_unique` ON `desidb`.`orders` (`userId` ASC, `shoppingCartId` ASC) VISIBLE;

CREATE INDEX `shoppingCartId` ON `desidb`.`orders` (`shoppingCartId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `desidb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desidb`.`products` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `price` VARCHAR(255) NULL DEFAULT NULL,
  `img` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  `categoryId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `products_ibfk_1`
    FOREIGN KEY (`categoryId`)
    REFERENCES `desidb`.`categories` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `categoryId` ON `desidb`.`products` (`categoryId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `desidb`.`productCarts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desidb`.`productCarts` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `quantity` INT(11) NULL DEFAULT NULL,
  `price` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  `productId` INT(11) NULL DEFAULT NULL,
  `shoppingCartId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `productCarts_ibfk_1`
    FOREIGN KEY (`productId`)
    REFERENCES `desidb`.`products` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `productCarts_ibfk_2`
    FOREIGN KEY (`shoppingCartId`)
    REFERENCES `desidb`.`shoppingCarts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `productCarts_shoppingCartId_productId_unique` ON `desidb`.`productCarts` (`productId` ASC, `shoppingCartId` ASC) VISIBLE;

CREATE INDEX `shoppingCartId` ON `desidb`.`productCarts` (`shoppingCartId` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
