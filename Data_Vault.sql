SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Клиенты`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Клиенты` (
  `idКлиенты` INT NOT NULL ,
  `Название` VARCHAR(45) NULL ,
  `Контактный телефон` INT NULL ,
  `Адрес` VARCHAR(45) NULL ,
  PRIMARY KEY (`idКлиенты`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Заявки`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Заявки` (
  `idЗаявки` INT NOT NULL ,
  `Дата создания` DATE NULL ,
  `Клиенты_idКлиенты` INT NOT NULL ,
  PRIMARY KEY (`idЗаявки`, `Клиенты_idКлиенты`) ,
  INDEX `fk_Заявки_Клиенты1_idx` (`Клиенты_idКлиенты` ASC) ,
  CONSTRAINT `fk_Заявки_Клиенты1`
    FOREIGN KEY (`Клиенты_idКлиенты` )
    REFERENCES `mydb`.`Клиенты` (`idКлиенты` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Позиции заявки`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Позиции заявки` (
  `idПозиции заявки` INT NOT NULL ,
  `Количество` INT NULL ,
  `Общая стоимость` FLOAT NULL ,
  `Заявки_idЗаявки` INT NOT NULL ,
  PRIMARY KEY (`idПозиции заявки`, `Заявки_idЗаявки`) ,
  INDEX `fk_Позиции заявки_Заявки1_idx` (`Заявки_idЗаявки` ASC) ,
  CONSTRAINT `fk_Позиции заявки_Заявки1`
    FOREIGN KEY (`Заявки_idЗаявки` )
    REFERENCES `mydb`.`Заявки` (`idЗаявки` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Продукция`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Продукция` (
  `idПродукта` INT NOT NULL ,
  `Название` VARCHAR(45) NULL ,
  `Описание` VARCHAR(45) NULL ,
  `Цена` FLOAT NULL ,
  `Позиции заявки_idПозиции заявки` INT NOT NULL ,
  `Позиции заявки_Заявки_idЗаявки` INT NOT NULL ,
  PRIMARY KEY (`idПродукта`, `Позиции заявки_idПозиции заявки`, `Позиции заявки_Заявки_idЗаявки`) ,
  INDEX `fk_Продукция_Позиции заявки1_idx` (`Позиции заявки_idПозиции заявки` ASC, `Позиции заявки_Заявки_idЗаявки` ASC) ,
  CONSTRAINT `fk_Продукция_Позиции заявки1`
    FOREIGN KEY (`Позиции заявки_idПозиции заявки` , `Позиции заявки_Заявки_idЗаявки` )
    REFERENCES `mydb`.`Позиции заявки` (`idПозиции заявки` , `Заявки_idЗаявки` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hub_Клиенты`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Hub_Клиенты` (
  `idHub_клиенты` INT NOT NULL ,
  `Дата записи` DATE NULL ,
  PRIMARY KEY (`idHub_клиенты`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hub_Продукция`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Hub_Продукция` (
  `idHub_Продукция` INT NOT NULL ,
  `Дата записи` DATE NULL ,
  PRIMARY KEY (`idHub_Продукция`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hub_Заявки`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Hub_Заявки` (
  `idHub_Заявки` INT NOT NULL ,
  `Дата записи` DATE NULL ,
  PRIMARY KEY (`idHub_Заявки`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Link_Заявки_Клиенты`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Link_Заявки_Клиенты` (
  `idLink` INT NOT NULL ,
  `Дата записи` DATE NULL ,
  `Hub_Клиенты_idHub_клиенты` INT NOT NULL ,
  `Hub_Заявки_idHub_Заявки` INT NOT NULL ,
  PRIMARY KEY (`idLink`) ,
  INDEX `fk_Link_Заявки_Клиенты_Hub_Клиенты1_idx` (`Hub_Клиенты_idHub_клиенты` ASC) ,
  INDEX `fk_Link_Заявки_Клиенты_Hub_Заявки1_idx` (`Hub_Заявки_idHub_Заявки` ASC) ,
  CONSTRAINT `fk_Link_Заявки_Клиенты_Hub_Клиенты1`
    FOREIGN KEY (`Hub_Клиенты_idHub_клиенты` )
    REFERENCES `mydb`.`Hub_Клиенты` (`idHub_клиенты` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Link_Заявки_Клиенты_Hub_Заявки1`
    FOREIGN KEY (`Hub_Заявки_idHub_Заявки` )
    REFERENCES `mydb`.`Hub_Заявки` (`idHub_Заявки` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Link_Заявки_Продукция`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Link_Заявки_Продукция` (
  `idLink` INT NOT NULL ,
  `Дата записи` DATE NULL ,
  `Hub_Заявки_idHub_Заявки` INT NOT NULL ,
  `Hub_Продукция_idHub_Продукция` INT NOT NULL ,
  PRIMARY KEY (`idLink`) ,
  INDEX `fk_Link_Заявки_Продукция_Hub_Заявки1_idx` (`Hub_Заявки_idHub_Заявки` ASC) ,
  INDEX `fk_Link_Заявки_Продукция_Hub_ПродукцПidx` (`Hub_Продукция_idHub_Продукция` ASC) ,
  CONSTRAINT `fk_Link_Заявки_Продукция_Hub_Заявки1`
    FOREIGN KEY (`Hub_Заявки_idHub_Заявки` )
    REFERENCES `mydb`.`Hub_Заявки` (`idHub_Заявки` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Link_Заявки_Продукция_Hub_Продукция1`
    FOREIGN KEY (`Hub_Продукция_idHub_Продукция` )
    REFERENCES `mydb`.`Hub_Продукция` (`idHub_Продукция` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sattelit_Клиенты`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Sattelit_Клиенты` (
  `idSattelit_Клиенты` INT NOT NULL ,
  `Название` VARCHAR(45) NULL ,
  `Контактный телефон` DECIMAL(10,0) NULL ,
  `Адрес` VARCHAR(45) NULL ,
  `Дата изменения` DATE NULL ,
  `Hub_Клиенты_idHub_клиенты` INT NOT NULL ,
  PRIMARY KEY (`idSattelit_Клиенты`) ,
  INDEX `fk_Sattelit_Клиенты_Hub_Клиенты1_idx` (`Hub_Клиенты_idHub_клиенты` ASC) ,
  CONSTRAINT `fk_Sattelit_Клиенты_Hub_Клиенты1`
    FOREIGN KEY (`Hub_Клиенты_idHub_клиенты` )
    REFERENCES `mydb`.`Hub_Клиенты` (`idHub_клиенты` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sattelit_Продукция`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Sattelit_Продукция` (
  `idSattelit_Продукция` INT NOT NULL ,
  `Название` VARCHAR(45) NULL ,
  `Описание` VARCHAR(45) NULL ,
  `Цена` FLOAT NULL ,
  `Дата изменения` DATE NULL ,
  `Hub_Продукция_idHub_Продукция` INT NOT NULL ,
  PRIMARY KEY (`idSattelit_Продукция`) ,
  INDEX `fk_Sattelit_Продукция_Hub_Продукция1_idx` (`Hub_Продукция_idHub_Продукция` ASC) ,
  CONSTRAINT `fk_Sattelit_Продукция_Hub_Продукция1`
    FOREIGN KEY (`Hub_Продукция_idHub_Продукция` )
    REFERENCES `mydb`.`Hub_Продукция` (`idHub_Продукция` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sattelit_Заявки`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Sattelit_Заявки` (
  `idSattelit_Заявки` INT NOT NULL ,
  `Дата создания` DATE NULL ,
  `Дата изменения` DATE NULL ,
  `Hub_Заявки_idHub_Заявки` INT NOT NULL ,
  PRIMARY KEY (`idSattelit_Заявки`) ,
  INDEX `fk_Sattelit_Заявки_Hub_Заявки1_idx` (`Hub_Заявки_idHub_Заявки` ASC) ,
  CONSTRAINT `fk_Sattelit_Заявки_Hub_Заявки1`
    FOREIGN KEY (`Hub_Заявки_idHub_Заявки` )
    REFERENCES `mydb`.`Hub_Заявки` (`idHub_Заявки` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
