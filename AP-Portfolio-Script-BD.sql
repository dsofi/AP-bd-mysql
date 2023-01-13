-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema AP-Portfolio-BD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema AP-Portfolio-BD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AP-Portfolio-BD` DEFAULT CHARACTER SET utf8 ;
USE `AP-Portfolio-BD` ;

-- -----------------------------------------------------
-- Table `AP-Portfolio-BD`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AP-Portfolio-BD`.`persona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `sobreMi` VARCHAR(255) NULL,
  `foto` VARCHAR(120) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AP-Portfolio-BD`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AP-Portfolio-BD`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(18) NOT NULL,
  `puedeEditar` TINYINT NOT NULL,
  `personaId` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`user` ASC) VISIBLE,
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE,
  INDEX `fk_usuario_persona1_idx` (`personaId` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_persona1`
    FOREIGN KEY (`personaId`)
    REFERENCES `AP-Portfolio-BD`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AP-Portfolio-BD`.`expLaboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AP-Portfolio-BD`.`expLaboral` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `empresa` VARCHAR(45) NOT NULL,
  `inicio` VARCHAR(45) NULL,
  `fin` VARCHAR(45) NULL,
  `descripcion` VARCHAR(255) NULL,
  `esActual` TINYINT NULL,
  `personaId` INT NOT NULL,
  PRIMARY KEY (`id`, `personaId`),
  INDEX `fk_exp_laboral_persona1_idx` (`personaId` ASC) VISIBLE,
  CONSTRAINT `fk_exp_laboral_persona1`
    FOREIGN KEY (`personaId`)
    REFERENCES `AP-Portfolio-BD`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AP-Portfolio-BD`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AP-Portfolio-BD`.`proyecto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha` DATE NULL,
  `descripcion` VARCHAR(255) NULL,
  `imagen` VARCHAR(120) NULL,
  `link` VARCHAR(120) NULL,
  `personaId` INT NOT NULL,
  PRIMARY KEY (`id`, `personaId`),
  UNIQUE INDEX `link_UNIQUE` (`link` ASC) VISIBLE,
  UNIQUE INDEX `imagen_UNIQUE` (`imagen` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_proyecto_persona1_idx` (`personaId` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`personaId`)
    REFERENCES `AP-Portfolio-BD`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AP-Portfolio-BD`.`tipoEstudio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AP-Portfolio-BD`.`tipoEstudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipoEstudio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipoEstudio_UNIQUE` (`tipoEstudio` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AP-Portfolio-BD`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AP-Portfolio-BD`.`educacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `institucion` VARCHAR(45) NOT NULL,
  `inicio` DATE NULL,
  `fin` DATE NULL,
  `descripcion` VARCHAR(255) NULL,
  `enCurso` TINYINT NULL,
  `nota1` VARCHAR(255) NULL,
  `nota2` VARCHAR(255) NULL,
  `personaId` INT NOT NULL,
  `tipoEstudioId` INT NOT NULL,
  PRIMARY KEY (`id`, `personaId`, `tipoEstudioId`),
  INDEX `fk_educacion_persona1_idx` (`personaId` ASC) VISIBLE,
  INDEX `fk_educacion_tipoEstudio1_idx` (`tipoEstudioId` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`personaId`)
    REFERENCES `AP-Portfolio-BD`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_educacion_tipoEstudio1`
    FOREIGN KEY (`tipoEstudioId`)
    REFERENCES `AP-Portfolio-BD`.`tipoEstudio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AP-Portfolio-BD`.`tipoSkill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AP-Portfolio-BD`.`tipoSkill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipoSkill` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tipoSkill_UNIQUE` (`tipoSkill` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AP-Portfolio-BD`.`skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AP-Portfolio-BD`.`skill` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NULL,
  `tiempoUso` VARCHAR(45) NULL,
  `porcentaje` INT NOT NULL,
  `personaId` INT NOT NULL,
  `tipoSkillId` INT NOT NULL,
  PRIMARY KEY (`id`, `personaId`, `tipoSkillId`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_skill_persona1_idx` (`personaId` ASC) VISIBLE,
  INDEX `fk_skill_tipoSkill1_idx` (`tipoSkillId` ASC) VISIBLE,
  CONSTRAINT `fk_skill_persona1`
    FOREIGN KEY (`personaId`)
    REFERENCES `AP-Portfolio-BD`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_skill_tipoSkill1`
    FOREIGN KEY (`tipoSkillId`)
    REFERENCES `AP-Portfolio-BD`.`tipoSkill` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
