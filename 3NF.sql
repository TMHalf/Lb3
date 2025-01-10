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



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
