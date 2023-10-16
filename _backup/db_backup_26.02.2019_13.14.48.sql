-- -------------------------------------------
SET AUTOCOMMIT=0;
START TRANSACTION;
SET SQL_QUOTE_SHOW_CREATE = 1;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- -------------------------------------------
-- -------------------------------------------
-- START BACKUP
-- -------------------------------------------
-- -------------------------------------------
-- TABLE `cliente`
-- -------------------------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `numeroDocumento` int(11) NOT NULL,
  `tipoDocumento_idtipoDocumento` int(11) DEFAULT NULL,
  `nombre` varchar(80) NOT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `provincia_idprovincia` int(11) NOT NULL,
  `localidad_idlocalidad` int(11) NOT NULL,
  `telefonoFijo` varchar(15) DEFAULT NULL,
  `telefonoCelular` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idcliente`),
  KEY `fk_cliente_tipoDocumento1_idx` (`tipoDocumento_idtipoDocumento`),
  KEY `fk_cliente_provincia1_idx` (`provincia_idprovincia`),
  KEY `fk_cliente_localidad1_idx` (`localidad_idlocalidad`),
  CONSTRAINT `fk_cliente_localidad1` FOREIGN KEY (`localidad_idlocalidad`) REFERENCES `localidad` (`idlocalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_provincia1` FOREIGN KEY (`provincia_idprovincia`) REFERENCES `provincia` (`idprovincia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_tipoDocumento1` FOREIGN KEY (`tipoDocumento_idtipoDocumento`) REFERENCES `tipodocumento` (`idtipoDocumento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `configprecio`
-- -------------------------------------------
DROP TABLE IF EXISTS `configprecio`;
CREATE TABLE IF NOT EXISTS `configprecio` (
  `idConfigPrecio` int(11) NOT NULL AUTO_INCREMENT,
  `incrementoPrecio2` float NOT NULL,
  `incrementoPrecio3` float NOT NULL,
  PRIMARY KEY (`idConfigPrecio`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `consulta`
-- -------------------------------------------
DROP TABLE IF EXISTS `consulta`;
CREATE TABLE IF NOT EXISTS `consulta` (
  `idconsulta` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `cliente_idcliente` int(11) NOT NULL,
  `paciente_idpaciente` int(11) NOT NULL,
  `tipoConsulta_idtipoConsulta` int(11) NOT NULL,
  `motivo` text NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idconsulta`),
  KEY `fk_consulta_paciente1_idx` (`paciente_idpaciente`),
  KEY `fk_consulta_tipoConsulta1_idx` (`tipoConsulta_idtipoConsulta`),
  KEY `fk_consulta_cliente1_idx` (`cliente_idcliente`),
  CONSTRAINT `fk_consulta_cliente1` FOREIGN KEY (`cliente_idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_paciente1` FOREIGN KEY (`paciente_idpaciente`) REFERENCES `paciente` (`idpaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_tipoConsulta1` FOREIGN KEY (`tipoConsulta_idtipoConsulta`) REFERENCES `tipoconsulta` (`idtipoConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1249 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `cruge_authassignment`
-- -------------------------------------------
DROP TABLE IF EXISTS `cruge_authassignment`;
CREATE TABLE IF NOT EXISTS `cruge_authassignment` (
  `userid` int(11) NOT NULL,
  `bizrule` text,
  `data` text,
  `itemname` varchar(64) NOT NULL,
  PRIMARY KEY (`userid`,`itemname`),
  KEY `fk_cruge_authassignment_cruge_authitem1` (`itemname`),
  KEY `fk_cruge_authassignment_user` (`userid`),
  CONSTRAINT `fk_cruge_authassignment_cruge_authitem1` FOREIGN KEY (`itemname`) REFERENCES `cruge_authitem` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cruge_authassignment_user` FOREIGN KEY (`userid`) REFERENCES `cruge_user` (`iduser`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `cruge_authitem`
-- -------------------------------------------
DROP TABLE IF EXISTS `cruge_authitem`;
CREATE TABLE IF NOT EXISTS `cruge_authitem` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `cruge_authitemchild`
-- -------------------------------------------
DROP TABLE IF EXISTS `cruge_authitemchild`;
CREATE TABLE IF NOT EXISTS `cruge_authitemchild` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `crugeauthitemchild_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `cruge_authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `crugeauthitemchild_ibfk_2` FOREIGN KEY (`child`) REFERENCES `cruge_authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `cruge_field`
-- -------------------------------------------
DROP TABLE IF EXISTS `cruge_field`;
CREATE TABLE IF NOT EXISTS `cruge_field` (
  `idfield` int(11) NOT NULL AUTO_INCREMENT,
  `fieldname` varchar(20) NOT NULL,
  `longname` varchar(50) DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `required` int(11) DEFAULT '0',
  `fieldtype` int(11) DEFAULT '0',
  `fieldsize` int(11) DEFAULT '20',
  `maxlength` int(11) DEFAULT '45',
  `showinreports` int(11) DEFAULT '0',
  `useregexp` varchar(512) DEFAULT NULL,
  `useregexpmsg` varchar(512) DEFAULT NULL,
  `predetvalue` mediumblob,
  PRIMARY KEY (`idfield`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `cruge_fieldvalue`
-- -------------------------------------------
DROP TABLE IF EXISTS `cruge_fieldvalue`;
CREATE TABLE IF NOT EXISTS `cruge_fieldvalue` (
  `idfieldvalue` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `idfield` int(11) NOT NULL,
  `value` blob,
  PRIMARY KEY (`idfieldvalue`),
  KEY `fk_cruge_fieldvalue_cruge_user1` (`iduser`),
  KEY `fk_cruge_fieldvalue_cruge_field1` (`idfield`),
  CONSTRAINT `fk_cruge_fieldvalue_cruge_field1` FOREIGN KEY (`idfield`) REFERENCES `cruge_field` (`idfield`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cruge_fieldvalue_cruge_user1` FOREIGN KEY (`iduser`) REFERENCES `cruge_user` (`iduser`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `cruge_session`
-- -------------------------------------------
DROP TABLE IF EXISTS `cruge_session`;
CREATE TABLE IF NOT EXISTS `cruge_session` (
  `idsession` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `created` bigint(30) DEFAULT NULL,
  `expire` bigint(30) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `ipaddress` varchar(45) DEFAULT NULL,
  `usagecount` int(11) DEFAULT '0',
  `lastusage` bigint(30) DEFAULT NULL,
  `logoutdate` bigint(30) DEFAULT NULL,
  `ipaddressout` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idsession`),
  KEY `crugesession_iduser` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=372 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `cruge_system`
-- -------------------------------------------
DROP TABLE IF EXISTS `cruge_system`;
CREATE TABLE IF NOT EXISTS `cruge_system` (
  `idsystem` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `largename` varchar(45) DEFAULT NULL,
  `sessionmaxdurationmins` int(11) DEFAULT '30',
  `sessionmaxsameipconnections` int(11) DEFAULT '10',
  `sessionreusesessions` int(11) DEFAULT '1' COMMENT '1yes 0no',
  `sessionmaxsessionsperday` int(11) DEFAULT '-1',
  `sessionmaxsessionsperuser` int(11) DEFAULT '-1',
  `systemnonewsessions` int(11) DEFAULT '0' COMMENT '1yes 0no',
  `systemdown` int(11) DEFAULT '0',
  `registerusingcaptcha` int(11) DEFAULT '0',
  `registerusingterms` int(11) DEFAULT '0',
  `terms` blob,
  `registerusingactivation` int(11) DEFAULT '1',
  `defaultroleforregistration` varchar(64) DEFAULT NULL,
  `registerusingtermslabel` varchar(100) DEFAULT NULL,
  `registrationonlogin` int(11) DEFAULT '1',
  PRIMARY KEY (`idsystem`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `cruge_user`
-- -------------------------------------------
DROP TABLE IF EXISTS `cruge_user`;
CREATE TABLE IF NOT EXISTS `cruge_user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `regdate` bigint(30) DEFAULT NULL,
  `actdate` bigint(30) DEFAULT NULL,
  `logondate` bigint(30) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL COMMENT 'Hashed password',
  `authkey` varchar(100) DEFAULT NULL COMMENT 'llave de autentificacion',
  `state` int(11) DEFAULT '0',
  `totalsessioncounter` int(11) DEFAULT '0',
  `currentsessioncounter` int(11) DEFAULT '0',
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `diagnosticocomplementario`
-- -------------------------------------------
DROP TABLE IF EXISTS `diagnosticocomplementario`;
CREATE TABLE IF NOT EXISTS `diagnosticocomplementario` (
  `iddiagnosticoComplementario` int(11) NOT NULL AUTO_INCREMENT,
  `consulta_idconsulta` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `archivo` longblob NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`iddiagnosticoComplementario`),
  KEY `fk_diagnosticoComplementario_consulta1_idx` (`consulta_idconsulta`),
  CONSTRAINT `fk_diagnosticoComplementario_consulta1` FOREIGN KEY (`consulta_idconsulta`) REFERENCES `consulta` (`idconsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `especie`
-- -------------------------------------------
DROP TABLE IF EXISTS `especie`;
CREATE TABLE IF NOT EXISTS `especie` (
  `idespecie` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idespecie`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `localidad`
-- -------------------------------------------
DROP TABLE IF EXISTS `localidad`;
CREATE TABLE IF NOT EXISTS `localidad` (
  `idlocalidad` int(11) NOT NULL AUTO_INCREMENT,
  `codigoPostal` int(11) NOT NULL,
  `provincia_idprovincia` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idlocalidad`),
  KEY `fk_localidad_provincia1_idx` (`provincia_idprovincia`),
  CONSTRAINT `fk_localidad_provincia1` FOREIGN KEY (`provincia_idprovincia`) REFERENCES `provincia` (`idprovincia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `marca`
-- -------------------------------------------
DROP TABLE IF EXISTS `marca`;
CREATE TABLE IF NOT EXISTS `marca` (
  `idmarca` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `rubro_idRubro` int(11) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idmarca`),
  KEY `fk_marca_rubro_idx` (`rubro_idRubro`),
  CONSTRAINT `fk_marca_rubro` FOREIGN KEY (`rubro_idRubro`) REFERENCES `rubro` (`idRubro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `paciente`
-- -------------------------------------------
DROP TABLE IF EXISTS `paciente`;
CREATE TABLE IF NOT EXISTS `paciente` (
  `idpaciente` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_idcliente` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `pacientecol` varchar(45) DEFAULT NULL,
  `especie_idespecie` int(11) NOT NULL,
  `raza_idraza` int(11) NOT NULL,
  `sexo` varchar(9) NOT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `observacion` text,
  `señaParticular` varchar(100) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idpaciente`),
  KEY `fk_paciente_especie1_idx` (`especie_idespecie`),
  KEY `fk_paciente_raza1_idx` (`raza_idraza`),
  KEY `fk_paciente_cliente1_idx` (`cliente_idcliente`),
  CONSTRAINT `fk_paciente_cliente1` FOREIGN KEY (`cliente_idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_especie1` FOREIGN KEY (`especie_idespecie`) REFERENCES `especie` (`idespecie`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_raza1` FOREIGN KEY (`raza_idraza`) REFERENCES `raza` (`idraza`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `producto`
-- -------------------------------------------
DROP TABLE IF EXISTS `producto`;
CREATE TABLE IF NOT EXISTS `producto` (
  `idproducto` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `rubro_idRubro` int(11) NOT NULL,
  `subRubro_idSubRubro` int(11) NOT NULL,
  `marca_idmarca` int(11) NOT NULL,
  `precioCosto` float DEFAULT NULL,
  `precioEfectivo` float NOT NULL,
  `precio2` float DEFAULT NULL,
  `precio3` float DEFAULT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idproducto`),
  KEY `fk_producto_rubro1_idx` (`rubro_idRubro`),
  KEY `fk_producto_subRubro1_idx` (`subRubro_idSubRubro`),
  KEY `fk_producto_marca1_idx` (`marca_idmarca`),
  CONSTRAINT `fk_producto_marca1` FOREIGN KEY (`marca_idmarca`) REFERENCES `marca` (`idmarca`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_rubro1` FOREIGN KEY (`rubro_idRubro`) REFERENCES `rubro` (`idRubro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_subRubro1` FOREIGN KEY (`subRubro_idSubRubro`) REFERENCES `subrubro` (`idSubRubro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=714 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `provincia`
-- -------------------------------------------
DROP TABLE IF EXISTS `provincia`;
CREATE TABLE IF NOT EXISTS `provincia` (
  `idprovincia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idprovincia`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `raza`
-- -------------------------------------------
DROP TABLE IF EXISTS `raza`;
CREATE TABLE IF NOT EXISTS `raza` (
  `idraza` int(11) NOT NULL AUTO_INCREMENT,
  `especie_idespecie` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idraza`),
  KEY `fk_raza_especie1_idx` (`especie_idespecie`),
  CONSTRAINT `fk_raza_especie1` FOREIGN KEY (`especie_idespecie`) REFERENCES `especie` (`idespecie`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `rubro`
-- -------------------------------------------
DROP TABLE IF EXISTS `rubro`;
CREATE TABLE IF NOT EXISTS `rubro` (
  `idRubro` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idRubro`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `subrubro`
-- -------------------------------------------
DROP TABLE IF EXISTS `subrubro`;
CREATE TABLE IF NOT EXISTS `subrubro` (
  `idSubRubro` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `rubro_idRubro` int(11) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idSubRubro`),
  KEY `fk_subRubro_rubro1_idx` (`rubro_idRubro`),
  CONSTRAINT `fk_subRubro_rubro1` FOREIGN KEY (`rubro_idRubro`) REFERENCES `rubro` (`idRubro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `tipoconsulta`
-- -------------------------------------------
DROP TABLE IF EXISTS `tipoconsulta`;
CREATE TABLE IF NOT EXISTS `tipoconsulta` (
  `idtipoConsulta` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idtipoConsulta`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE `tipodocumento`
-- -------------------------------------------
DROP TABLE IF EXISTS `tipodocumento`;
CREATE TABLE IF NOT EXISTS `tipodocumento` (
  `idtipoDocumento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(4) NOT NULL,
  `estado` int(1) NOT NULL,
  PRIMARY KEY (`idtipoDocumento`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- -------------------------------------------
-- TABLE DATA cliente
-- -------------------------------------------
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('1','18787877','4','DIEGO ARGENTI','GAUDARD 961','28','1','4627635','155489274','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('2','10275468','4','ESCUDERO OSVALDO','GENERAL PAZ 110 ','28','2','','154257132','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('3','39967814','4','AGUILAR AGUSTINA','ESTADO DE ISRAEL 1160','28','1','','0358-154384899','agustina96@hotmail.com','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('4','33814267','4','LEDESMA ROMINA','LINIERS 39','28','1','','0358-154171934','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('5','32495777','4','ESCUDERO SEBASTIÁN','LAGO TRAFUL 2115','28','1','','0358-154256481','carospinella@hotmail.com','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('6','24705616','4','SALINAS JORGE','TREJO Y SANABRIA 1153','28','1','','0358-154329525','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('7','37489354','4','ROMERO MARÍA BELEN','9 DE JULIO 1579','28','1','','0358-155481343','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('8','38731335','4','ANGEL MAYRA','URQUIZA 1850','28','1','','0358-155166300','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('9','14624472','4','ZIZZI RITA','GAUDARD 1033','28','1','','154285124','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('10','13268304','4','CRENA SUSANA','DINKENLEIN 935','28','1','4650129','154171149','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('11','29908775','4','AMAYA GISELA','PEREZ BULNES 1673','28','1','','154834059','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('12','35279804','4','ORTIZ FLAVIA','PEREZ BULNES 1798','28','1','','155171995','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('13','14132649','4','BUFARINI MARI','ESTADO DE ISRAEL 1285','28','1','4634519','154841291','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('14','25267849','4','BORDONI VALERIA','MUGNAINI 1126','28','1','','155040469','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('15','0','4','Ricardo Zerbato','GAUDARD 957','28','1','','','','0');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('16','0','4','Soledad Pichetti','GAUDARD 957','28','1','','','','0');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('17','1','4','REY PAOLA','PASAJE ALMIRON 1265','28','1','','154399571','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('18','14132621','4','GIACCONE MARIA ANGELICA','ITUZAINGO 922','28','1','4620047','154826439','angigiaccone@hotmail.com','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('19','33233282','4','MOLIVA MELINA','MAIPU 465','28','1','','154328777','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('20','13548510','4','PIRETRO NORMA','CAMINO 3 ACEQUIAS, B° LAS QUINTAS','28','1','','03582-15407389','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('21','34771187','4','CAPPELLARI MARIA VICTORIA','LUIS RINAUDI 1557','28','1','','154373677','cappellarimv@gmail.com','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('22','30730790','4','MOLINA MARTIN','MANUEL PRADO 1453','28','1','','155625762','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('23','24783715','4','ARZAUTE BELEN','ROMA 1627','28','1','4653377','154372580','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('24','40417224','4','BUSTOS CAROLINA','RIO NIHUIL 840','28','1','4652766','154221818','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('25','33384956','4','ACTIS FABIOLA','MUGNAINI 259 4 C','28','1','','154321655','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('26','4752110','4','LUNA ELBA','MENDOZA 657','28','1','4625984','154194891','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('27','41595465','4','ARGUELLO BILBAO ANDONI EMANUEL','RIOJA 1144','28','1','154356241','154356358','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('28','42861436','4','QUEVEDO MAGALI','ANDAN QUIROGA 685','28','1','','154299764','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('29','23226194','4','BRACAMONTE MARIO PAULO','SAN LORENZO 469','28','1','','155062818','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('30','40419016','4','PICOTTO NARELA','9 DE JULIO 1885','28','1','','156028834','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('31','31840540','4','MATTIO MARTIN','ESTADO DE ISRAEL 1836','28','1','','154384009','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('32','35544223','4','BARRIONUEVO PAMELA','ESTADO DE ISRAEL 1077','28','1','','156545986','lulu.pame.kp@gmail.com','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('33','28173638','4','DIAZ VANINA','ESTADO DE ISRAEL 1127','28','1','','156021076','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('34','21130128','4','ZABALO GRACIELA','SAN ESTEBAN LOTE 258','28','1','','154207716','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('35','37422065','4','PEREYRA NAHUEL','ACHALAY 890','28','1','','156017557','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('36','11689797','4','DE LELLIS JOSE LUIS ','SADI CARNOT 1572','28','1','4624668','155484410','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('37','18388138','4','PASTOR SILVIA','RIO NIGUIL 840','28','1','4652766','','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('38','33814992','4','FURLAN FLORENCIA','PASAJE IMPOSTI 950','28','1','','154868555','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('39','3','4','SAYAL MONICA','RIOJA 1476','28','1','','154857383','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('40','38730926','4','PAGLIARICCI LUCAS','SARMIENTO 2751','28','1','4651318','154180809','lucaspagliaricci1005@gmail.com','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('41','30971427','4','ROMERO DAMARIS','PASAJE DE LA CONCEPCION 1129','28','1','','156024526','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('42','17105746','4','CORDOBA ALEJANDRO','ANTONIO SAENZ 2178','28','1','','154030875','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('43','21694407','4','IRENE MARIA GABRIELA','PJE MEGNAGINI 1245','28','1','','154168983','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('44','30766779','4','ESCUDERO CRISTIAN','ZONA RURAL LAS TAPIAS','28','1','','1162310531','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('45','16991641','4','REINAUDO EDUARDO','ESTRADA NORTE 2','28','1','4700788','155063532','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('46','36426108','4','GOMEZ GONZALO','BUENOS AIRES 1202 DPTO 2','28','1','4625460','154224358','gonzaaj77@gmail.com','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('47','20083116','4','CASTAGNO JUAN','JULIO REINA 1131','28','1','','154909976','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('48','29463521','4','MIRANDA ALEJANDRA','CESAR MILSTEIN 1417','28','1','','154360693','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('49','10585862','4','GONZALEZ PEDRO','GENERAL BUSTOS 2950','28','1','','154128921','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('50','27337391','4','ROVERES EDGARDO','OCAMPO 2771','28','1','','154310220','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('51','12657034','4','DIEZ ALCIDES','SUCRE 81','28','1','','155011604','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('52','25584677','4','ESCUDERO EVANGELINA','MARIANO LOPEZ COBOS 1262','28','1','','154017658','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('53','38281127','4','BRAGA KATERINNE','ZONA RURAL','28','1','','154201744','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('54','22843741','4','MIÑO NADINA','ESTADO DE ISRAEL 1223','28','1','4645985','155078314','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('55','38730758','4','ORTIZ BELEN','PEREZ BULNES 1798','28','1','','154309870','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('56','27570770','4','GARELLO ROMINA','GAUDARD 732','28','1','','155096049','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('57','34434268','4','PERREN EZEQUIEL','PASAJE SAN CAYETANO 2736','28','1','','155145030','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('58','25313572','4','LAUGA VALERIA','JUAN B JUSTO 486, LAS HIGUERAS','28','3','','154832237','VALERIALAUGA@GMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('59','28446242','4','ACEVEDO MARTIN','SADI CARNOT 1329','28','1','','155484077','JOACOALEANA@HOTMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('60','17325359','4','NOVELLI LAURA','MARCOS LLOVERAS 1352','28','1','','155130401','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('61','33359222','4','CALZOLARI NICOLAS','PASAJE BACH 1021','28','1','','358154204690','CALZOLARINICOLASG@GMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('62','36426197','4','TIVANO DIEGO','ROMA 1335','28','1','','154027617','DIEGO.TIVANO@GMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('63','11347904','4','GONZALEZ ADRIANA','MORENO 1035','28','1','','156549382','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('64','12382029','4','BUENO OSCAR','LINCOLN 1254','28','1','','154110000','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('65','12762250','4','CASSANO MABEL','9 DE JULIO 970','28','1','4636584','154113777','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('66','16329081','4','NICOLINO ADRIANA','ITUZAINGO 951','28','1','4634643','154163817','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('67','38418011','4','OLIVA FRANCO','PASAJE ACONCAGUA 123','28','1','','154192233','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('68','14478792','4','FELICIANI GRACIELA','25 DE MAYO 830','28','1','','154384002','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('69','31104391','4','HARO CECILIA','GUARDIAS NACIONALES 1164','28','1','','154285384','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('70','17921664','4','GONZALEZ CHAVELA','GAUDARD 731','28','1','','155046026','PILI.SCHOSSOWG@HOTMAIL.ES','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('71','30645194','4','MATTANA JACOBO','BUENA VISTA 1086','28','1','','2615630972','JACOBO.MATTANA@GMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('72','31716168','4','D\'ALESSANDRO PAOLA','BUENA VISTA 1086','28','1','','03582593808','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('73','27349015','4','CARRIZO DELIA','ESTADO DE ISRAEL 1077 3 B','28','1','','154265474','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('74','35929087','4','PALMA CARLOS GASTON','GUARDAIAS NACIONALES 1215','28','1','','154202944','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('75','26915265','4','BIDONE MARIO','CALLE 3 591 GOLF','28','1','','154831819','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('76','39968142','4','WENDEL NATHALIE','ESTRADA 783','28','1','4648508','155092758','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('77','32012991','4','BOVO FRANCO','MARIA OLGUIN 1835','28','1','4642570','154840394','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('78','17798049','4','MAGRIS CLAUDIA','GOUDARD 884 ¨2B¨','28','1','','154851803','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('79','13268045','4','SALDAÑO JORGE','CERRO FITZ ROY 1246','28','1','','154252211','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('80','6173560','4','FERRERO MIRTHA','ESTRADA 1122','28','1','4634814','156009257','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('81','4874195','4','FOGLIATTO NORMA','MORENO 1072','28','1','4621264','154118973','NORMABERRINO@HOTMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('82','14624648','4','GORDON RODOLFO','ROQUE SQAENZ PEÑA 1057','28','1','','154189014','GORDONANAMELINA@GMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('83','16731620','4','TELLO JOSE','JOSE MARMOL NORTE 796','28','1','','154244462','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('84','10585011','4','IRUSTA MARIO','MARCOS LLOVERAS 1420','28','1','','154123021','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('85','16650859','4','QUIROGA OSMAR OSCAR','RIOJA 2653','28','1','4659914','154267130','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('86','27360064','4','GAUNA MILAGROS ','SAN JUAN 1452','28','1','4650292','154876290','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('87','12993100','4','ECHANIZ MIGUEL','GAUDARD 284','28','1','4645394','155611921','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('88','26369586','4','CARRIZO CYNTHIA','GERONIMO DEL BARCO 2078','28','1','','154014844','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('89','35915946','4','MARTINI ROCIO','PASAJE BACH 1021','28','1','','154251614','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('90','13955357','4','DERAMO PATRICIA','PASAJE 12 DE OCTUBRE 1214','28','1','4645343','154284790','patderamo@yahoo.com.ar','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('91','35279830','4','TOSTO JULIO','GAUDARD 864','28','1','4642343','156000564','JULIOTOSTO@HOTMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('92','29347823','4','BALAGA GASTON','FONTANA ROSA 1734','28','1','','156029785','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('93','36985653','4','CARRILLO MARIA EUGENIA','PASAJE ATENAS 676','28','1','','155409985','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('94','35259946','4','PARIS JOHANA','SAN LORENZO 2233','28','1','','154248833','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('95','12382134','4','RABINO DANIEL','SANTIAGO DEL ESTERO 570','28','1','4630089','154263424','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('96','26006399','4','GOMEZ SERGIO','PEDRO GOYENA 302','28','1','','154022853','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('97','27448982','4','GUEVARA JOSE LUIS','BLAS PARERA 713','28','1','','156023616','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('98','31744807','4','DARUVICH JULIANA','ESTRADA 980','28','1','','3512285677','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('99','16530220','4','PEANO SANDRA','CALLE 5 N° 718 VILLA GOLF','28','1','','154323047','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('100','41964697','4','BAGGINI AGUSTIN','CARLOS RODRIGUEZ 1227','28','1','4643843','155074704','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('101','42386193','4','TAZZIOLI MARIA LUZ','SANTIAGO DEL ESTERO 245','28','1','4629990','3586546676','MARIALUZTAZZIOLI@GMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('102','24783501','4','CORDOBA HUGO','BLAS PARERA 1574','28','1','','154866044','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('103','33814986','4','ENRICO JUAN','PERON 1241 (O)','28','1','','156547922','JUANFRA_89_@HOTMAIL.COM','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('104','17679467','4','MOLEKEL GLADY','ESTADOS DE ISRAEL 1737','28','1','','154220058','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('105','33006327','4','DALLO VICTORIA ','GUATEMALA 247','28','1','','155073547','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('106','37177508','4','LUCERO JULIETA','RIO DE LA PLATA 200','28','1','','156001343','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('107','2793874','4','PINNA EFIDIO ALBERTO','DINKENLEIN 942','28','1','4644831','','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('108','35676347','4','GIORDANINO PIA','PRINGLES 43','28','1','','156026087','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('109','38731356','4','GORDON AGUSTIN','ROQUE SQAENZ PEÑA 1055','28','1','','154844426','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('110','12630948','4','MARAZZI VIVIANA','GAUDARD 1138','28','1','4632762','155613951','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('111','14132277','4','PALLARONI MIRIAM','GAUDARD 681','28','1','','154373586','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('112','30665039','4','IRUSTA FABRICIO','GAUDARD 998','28','1','','154361991','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('113','6659480','4','ORELLANO JORGE','RIOJA 1055','28','1','4648600','3571691585','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('114','32245387','4','PORTA VIRGINIA','ESQUIU 295','28','3','','3516233520','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('115','36426348','4','GOMEZ ERIKA','GAUDARD 1583 DPTO 12','28','1','','154264653','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('116','32495527','4','ESPINO NOELIA','PJE FLORIL 1370','28','1','','154011416','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('117','26485976','4','CONTRERAS MARCOS','JAMAICA 254','28','1','','154300931','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('118','24521357','4','PEREYRA ADELA','ROMA 1080','28','1','','155073012','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('119','6645697','4','CANCELLI BENJAMIN','MORENO 1048','28','1','4642772','','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('120','8556321','4','AYALA RICARDO','PUENTE DEL INCA 952','28','1','4638561','','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('121','17921914','4','NIEVAS ANALIA','PERU 424','28','1','4751153','154122552','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('122','26417303','4','LOPEZ NOELIA','GOUDARD 2743','28','1','','154016826','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('123','28579724','4','VERGARA CAROLINA','ZORZIN 2814','28','1','','156004187','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('124','37177593','4','SPECIOSO FATIMA','GAUDARD964','28','1','4639455','155147208','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('125','37127677','4','MORENO FABIOLA','ALBERDI 1627','28','1','','155168792','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('126','28207479','4','CASTAGNO ALBERTO','LOPEZ DE VEGA 453','28','1','4655195','154221934','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('127','21670790','4','TORRES CARINA','DINKELDEIN 105','28','1','4634548','154384732','abril_leocar@hotmail.com','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('128','29463520','4','MENSEGUEZ MELINA ','ESTRADA 942','28','1','','15423746','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('129','22338166','4','GONZALEZ GRACIELA','ROMA 1185','28','1','4645919','156542858','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('130','23520645','4','ALVAREZ GABRIELA','LAGO TRAFUL 2373','28','1','','154322134','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('131','14132225','4','GONZALEZ ANA','BLAS PARERA 1329','28','1','','154125797','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('132','21013361','4','GIACCONE PATRICIA','DINKELDEIN 934','28','1','','155062892','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('133','10585663','4','MAGALLANEZ BEATRIZ','PJE EMILIO JAUTZ 469','28','1','4210509','154355394','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('134','14132708','4','ALTURRIA MONICA ','ESTADO DE ISRAEL 1017','28','1','4797808','154205458','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('135','35176522','4','DIAZ JONATHAN','MANUEL PUEBLA 1108','28','1','','155134549','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('136','27185314','4','DOMINGUEZ NATALIA','MARIA OLGUIN 340','28','1','','154262109','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('137','20080135','4','ACEVEDO FABIAN','DINKELDEIN ESQU. SAINT REMI','28','1','','154383378','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('138','11347798','4','SORELLO HECTOR','SAN LORENZO 1673','28','1','4633664','154311896','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('139','40773144','4','HAYES MILAGROS','CORONEL VIDELA 1016','28','1','','155601852','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('140','34884152','4','IRUSTA ROMINA','PASAJE 12 DE OCTUBRE 932','28','1','','154238937','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('141','6166157','4','FIERRO SILVIA RAQUEL','LEOPOLDO LUGONES 1441','28','1','4625722','154301340','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('142','34426437','4','MALDONADO JUAN','SAN MARTIN 1144','28','1','4640743','154602898','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('143','11377700','4','MENOCHIO MARTA','ESTADO DE ISRAEL 1261','28','1','','03583-15416984','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('144','21999138','4','MANSILLA ANA GABRIELA','ESTRADA 748','28','1','','154281203','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('145','16530273','4','ECEIZA PATRICIA','MORENO 1071','28','1','4625460','155095823','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('146','30538402','4','LOPEZ LUCIANA ','JUAN BRANDINO 837','28','1','4680270','154258189','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('147','24407065','4','CEJAS SANDRA','CORONEL VIDELA 845','28','1','4755997','154908327','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('148','25698146','4','CONSTANTINO HORACIO','ISLAS DE LOS ESTADOS 556','28','1','4637155','154855344','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('149','12144130','4','PEANO LUIS ENRIQUE','ESTRADA 1027','28','1','','154227978','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('150','21694094','4','DE ANGELO LEONARDO','ARTURO M BASS 2007','28','1','4642050','154262120','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('151','3034675','4','NAVARRO PABLO','FOTHERINGAN 875','28','1','','154800162','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('152','33359410','4','BILDOZA CESAR','ESTADO DE ISRAEL 1431','28','1','4641216','154300560','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('153','37490049','4','AGUILERA MARIA PIA','25 DE MAYO 259','28','1','','156544205','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('154','22843977','4','GREGORAT ALEJANDRO','ESTADO DE ISRAEL 1252','28','1','','154028702','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('155','25643649','4','MASCANFRONI OMAR','CASTELLI TERMNACION','28','1','','154281129','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('156','38731249','4','ZABALA ROCIO','RIO QUINTO 813','28','1','','154019635','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('157','25471618','4','DOMINGUEZ PAMELA','COLOMBIA 700','28','1','','155070949','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('158','14206775','4','PRESTIFILIPO SERGIO','ITUZAINGO 328','28','1','','154117854','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('159','37177485','4','TORLETTI MATIAS ','BLAS PARERA 1375','28','1','4626139','154827903','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('160','33814737','4','CARBALLO JEREMIAS','BELGRANO 452 6 A','28','1','4631803','154399689','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('161','33359071','4','AGUILAR MIRCO','11 DE NOVIEMBRE 1181','28','1','','154329480','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('162','34884406','4','CALDERON NADIA','ALEJANDRO AGUADO 1310','28','1','4623641','155482080','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('163','23378185','4','ABASCAL ARIEL','GAUDARD 975','28','1','4627542','154260080','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('164','11917340','4','FLORES OSCAR','ITUZAINGO 67','28','1','','0346215613889','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('165','32208219','4','PALAVECINO KAREN','MORENO 1388 DPTO 23','28','1','4621191','154377266','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('166','34574544','4','BRUZA JIMENA','BUENOS AIRES 1126 6B','28','1','','154821540','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('167','26462253','4','ESCUDERO GABRIELA','PASAJE MAIPU 1020 1 D','28','1','','154320149','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('168','33359746','4','SPERNANZONI ROMINA','GAUDARD 910','28','1','4650642','154309030','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('169','32495936','4','FALCONE IVAN','MAIPU 1240','28','1','4651965','154296949','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('170','52111286','4','CORIA FRANCISCO','PASAJE POTRERILLO 635','28','1','4637295','155489538','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('171','22843077','4','CEBALLES ALICIA','GAUDARD 2751','28','1','','154395027','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('172','16530202','4','CARBALLO JORGE','MORENO 1130','28','1','4631512','154156586','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('173','18204290','4','GODOY FLAVIA ','ALBERDI 3025','28','1','4647496','154117529','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('174','30990263','4','GUERRERO FACUNDO','GAUDARD 970','28','1','','154197018','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('175','28579864','4','ALVAREZ JUAN CRUZ','ARTURO M BAS 2066','28','1','','156547050','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('176','27933706','4','ASTUDILLO DIEGO','RUTA 9 KM 690','28','4','','0351-152426803','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('177','38018323','4','BOCCO MELISA','LORENZO DE FIGUEROA 1754','28','1','','3517690419','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('178','31855512','4','TESTA EMANUEL','PASAJE MANUEL CORONEL 553','28','1','','155136367','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('179','33136416','4','MERCAU SERGIO','PASAJE LA FORGUE','28','1','','358157292800','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('180','40503862','4','FUNES TANIA','BLAS PARERA 750','28','1','','155016364','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('181','43284337','4','CACERES FERNANDA','ROQUE SARN PEÑA 767','28','1','','154019505','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('182','40562597','4','HERRERA PAULINA','BUENOS AIRES 1162','28','1','','154245710','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('183','7680302','4','CARRANZA CARLOS','ROMA 1882','28','1','4623100','156003486','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('184','42638019','4','GRAMAGLIA LUCIANO','SAN MARTIN 1141','28','1','4623445','154186613','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('185','35134403','5','MANZOTTI ANTONELA','SAN MARTIN 513','28','1','','155604515','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('186','30310495','4','CAFFARO SEBASTIAN','COLON 860','28','1','','154317944','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('187','12630731','4','MARTINI MELISA','MORENO 1095','28','1','4644257','154180865','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('188','17781904','4','GARCIA SANDRA','SAN JUAN 630','28','1','156542892','154202565','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('189','4870433','4','LEROUX ROSA','RIOJA 1050','28','1','4640508','154379863','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('190','25858010','4','HORROCKS GABRIELA','GUARDIAS NACIONALES 2188','28','1','','038515646446','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('191','27369891','4','BUSTOS SILVINA','MORENO 1148','28','1','','154024782','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('192','42109149','4','FUNES LEANDRO','RIOJA 1440','28','1','','154230791','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('193','6652459','4','CARBONELL PABLO','MAIPU 875','28','1','4629771','','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('194','42638050','4','CELUCI CELINA','ANTONIO LUCERO 1156','28','1','4645381','154334271','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('195','11865774','4','GARCÍA CRISTINA','ESTADO DE ISRAEL 897','28','1','','154178040','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('196','41483281','4','GIROTTI BRUNA','SANJUAN 1085','28','1','','154819084','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('197','40417334','4','SERENO MICAELA','QUENON 1148','28','1','','154375200','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('198','0','4','BACINO MIGUEL ','INTENDENTE DAGUERRE 554','28','1','4665486','156000189','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('199','41360853','4','PAGLIERO ALEJANDRO','ESTADO DE ISRAEL 1070','28','1','','154327028','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('200','38415244','4','SOLORZA IVAN','SEBASTIAN VERA 150','28','1','','2604519320','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('201','12382102','4','ROCHA ESTELA','ESTADO DE ISRAEL 1127','28','1','4641436','154329410','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('202','31123800','4','GOMEZ FERNANDO','AMADEO MOZART 619','28','1','','154904769','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('203','14458201','4','COSTABELLA SHIRLEY DE','GAUDARD 1061','28','1','4643917','154124366','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('204','29833777','4','SERRAVALLE CAROLINA','LAVALLE 778','28','1','4629217','156003083 ','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('205','24882727','4','FOTI MARCELO','ARTURO M BAS 1130','28','1','4633990','156006747','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('206','30030059','4','FABER VALERIA','ESTADO DE ISRAEL 1077 PB G','28','1','4651990','154366219','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('207','32000301','4','VIDELA FRANCO','ALSINA 333','28','1','154012324','154842818','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('208','16529898','4','LOPEZ FABIO','CALLE 5 N 718. VILLA GOLF','28','1','','156012371','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('209','40772874','4','SIMONI NICOLAS','MORENO 1263','28','1','4638827','154392309','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('210','28446098','4','CARRANZA CAROLINA','MORENO 1323','28','1','','154356690','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('211','3322842','4','AMAYA CHICHI','BUENOS AIRES 1073','28','1','4622744','156021118','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('212','18061302','4','QUIROGA JAVIER','RIO GALLEGOS 381','28','1','','155101302','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('213','30849418','4','SOSA LUIS','RIOJA 921','28','1','','154256374','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('214','24464986','4','FUNES ANA GUADALUPE','CALLE 5 727 VILLA GOLF','28','1','4754555','156540381','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('215','30536316','4','BELMONTE GUARIENTO MARIA JOSE','LOS ROBLES 2513','28','1','','0358155080751','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('216','39422504','4','ECHANIZ SEBASTIAN','GOUDARD 284','28','1','','155130542','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('217','35544568','4','LEGA MICAELA','PASAJE ABILENE 1180','28','1','4628195','154111258','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('218','11347348','4','BRESSAN SUSANA','ESTRADA 1060','28','1','4627282','154016545','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('219','23436153','4','FUENTES ANA','CALLE 5 110 VILLA GOLF','28','1','','154111708','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('220','16991750','4','CELI ADRIANA','MARTIRES  RIOCUARTENSES 1565','28','1','4626438','154283000','','1');
INSERT INTO `cliente` (`idcliente`,`numeroDocumento`,`tipoDocumento_idtipoDocumento`,`nombre`,`direccion`,`provincia_idprovincia`,`localidad_idlocalidad`,`telefonoFijo`,`telefonoCelular`,`email`,`estado`) VALUES
('221','17733557','4','ZABALA FERNANDO','RIO QUINTO 813','28','1','','156001674','','1');



-- -------------------------------------------
-- TABLE DATA configprecio
-- -------------------------------------------
INSERT INTO `configprecio` (`idConfigPrecio`,`incrementoPrecio2`,`incrementoPrecio3`) VALUES
('1','7','20');



-- -------------------------------------------
-- TABLE DATA consulta
-- -------------------------------------------
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1','2018-10-03','1','1','1','DDDDD','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('2','2018-10-08','2','2','2','Hipertermia, cuadro alergico respiratorio. Tribiotic + dexa. Enrro 100mg x10 dias + dipirona x2 dias','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('3','2016-05-10','3','3','2','PSEUDOGESTACION. MASTITIS. AYUNO MAS MANEJO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('4','2016-12-14','3','3','2','REACCION ALERGICA. DERMIL 1/4 C/12 HS X 3 DIAS- 1/4 C/24 HS X 7 DIAS- 1/4 C/48 HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('5','2017-05-29','3','3','2','PSEUDOGESTACION. AYUNO MAS MANEJO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('6','2018-08-08','3','3','4','APRAX 5.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('7','2018-10-10','4','4','2','06/10/2018 Derivado de veterinaria de barrio Alberdi. Vomitos, decaimiento. Se aplica cerenia, amino. vit. Consume huesos.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('8','2018-10-10','4','4','5','12/10/2018 Diarrea hemorragica, deshidratacion. Internacion y extracción de sangre. Insuficiencia renal, posible cuadro viral. No se encuentra vacunado. Alta el mismo día, con alimentación especial.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('9','2018-09-27','5','5','6','Traumatismo por accidente transito. Enucleacion ocular. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('10','2018-09-25','6','6','2','Decaimiento, no puede orinar ni defecar, dolor abdominal. Deshidratacion. Come alimento balanceado y comida casera. Dexa y amino. vit. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('11','2018-09-26','6','6','6','Ecografia. Obstrucción uretral grave por cristales. Orquiectomía con amputación de pene. Enrofloxacina x 13 días, prednisolona, propantelina cada 12 hs. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('12','2018-08-24','7','7','3','1 Vacuna quintuple + aprax 2 kg','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('13','2018-10-09','7','7','3','2 Vacuna quintuple + aprax 5.200 kg','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('14','2018-10-10','8','8','2','TEMPERATURA 39.4 VOMITOS, MATERIA FECAL PASTOSA. COME RESTOS DE COMIDA. NO SE ENCUENTRA VACUNADA. TRIBIOTIC+VIT.  2KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('15','2017-10-10','9','9','3','5° + ATR + APRAX 2.440KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('16','2018-09-18','9','9','4','APRAX 2.440 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('17','2018-10-10','9','9','3','5° + ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('18','2017-01-16','10','10','3','1° VACUNA QUINTUPLE + FENTEL SUSP 0.890 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('19','2017-02-07','10','10','3','2° VACUNA QUINTUPLE + APRAX 1.320 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('20','2017-02-28','10','10','3','3° VACUNA QUINTUPLE + APRAX 1.640 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('21','2017-02-28','10','10','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('22','2018-03-03','10','10','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('23','2018-05-21','10','10','2','GASTROENTERITIS. VOMITO + FEBRICULA. DIPIRONA + CERENIA + VIT. AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('24','2018-06-02','10','10','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('25','2013-10-19','10','11','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('26','2013-10-31','10','11','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('27','2014-01-03','10','11','4','BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('28','2014-05-14','10','11','2','6.700 KG BASKEN PLUS. DOLOR ABDOMINAL + VOMITOS + GL. PERIANALES INFECT. CONSUMIO BONDIOLA DE CERDO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('29','2014-05-29','10','11','2','ECOGRAFIA ABDOMINAL POR FUERTE DOLOR (SUGERIDO POR GRITOS). TODO NORMAL. MAYOR ECOGENICIDAD SUGERENTE DE ALGUN TRASTORNO RENAL. ESA ECOGENICIDAD ES NORMAL EN CANICHES PERO IGUAL EVALUAR UREA Y CREATININA SI ES NECESARIO. TAMBIEN SE SOSPECHA DE DOLOR LUMBAR (PINZAMIENTO). 
TRATAMIENTO: ALIMENTE MV RENAL + ARROZ + QUESO + POLLO. PREDNISOLONA 20MG 1/4 CADA 12 HS X 48 HS. LUEGO ALGEN 1/4 CADA 12 X 48 HS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('30','2015-10-22','10','11','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('31','2016-10-21','10','11','3','VACUNA QUINTUPLE + ART + ATP 5.400KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('32','2017-02-28','10','11','4','BASKEN ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('33','2017-10-28','10','11','3','VACUNA QUINTUPLE + ATR + ATP APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('34','2018-10-01','12','12','2','LESION EN PARPADO POR MORDEDURA. FLUORESCEINA NEGATIVA. TAU SIN ESTEROIDES CADA 12 HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('35','2018-10-03','10','13','4','TOTAL FULL 0.370 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('36','2018-10-12','10','13','4','TOTAL FULL 0.600 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('37','2018-09-19','11','14','2','Presencia de lesiones micoticas en cabeza, patas y cola. por su forma semi redondeada correspondería, sin analisis previo a Trichophyton mentagrophytes, transmitida por roedores, ya que pocas lesiones son circulares y tienden a extenderse sin bordes definidos, afectando la cola y el miembro en éste caso.  Comienza con kualcovit B 2.5 ml y baños con shampoo ketoconazol mas pervinox en lesiones. Puede existir enfermedad de base.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('38','2018-10-12','11','14','7','Las lesiones comienzan a curar. Por el momento no se instaura tratamiento sistemico.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('39','2016-12-07','13','15','2','Alopecia en cola, orejas y cabeza, cola de rata. Demodex?DHongos?Malazezzia?Hipotiroidismo?no se realiza analisis. Crema 6 A c/12 hs. 
Peso 7.570 kg.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('40','2016-08-08','13','15','2','Traqueobronquitis infecciosa. Enrofloxacina 50 mg x 10 dias. Prednisolona 10 mg 1/4 c 12 hs x 4 dias.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('41','2018-03-12','13','15','2','Prurito y alopecia por pulgas. Shampoo queratitis seca mas prednisolona mas pipeta.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('42','2018-08-30','14','16','2','DIARREA ( SOBRECARGA GASTRICA). CONJUNTIVITIS OJO IZQUIERDO, ENTROPÍON INFERIOR. FLUORESCEINA NEGATIVA. TOTAL FULL POR 2 DIAS (1,350 KG). COMIENZO CON KUALCOVIT B 0.5 ML/DÍA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('43','2018-09-11','14','16','3','1ER VACUNA QUINTUPLE + TOTAL FULL 1,490 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('44','2018-10-01','14','16','3','2DA VACUNA QUINTUPLE + APRAX 2,400 KG. COMFORTIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('45','2015-11-28','17','17','2','ALOPECIA - PELO HIRUSTO- SEBORREA. HORMONAL? ATOPIA? DEMODEX? PULGAS? NUTRICIONAL? MALASSEZIA? NO SE REALIZA ANALISIS. CUALCO VIT B 1ML POR DIA. DERMIL 1 CADA 12X4- 1/2 CADA 12X4-1/2 CADA 24X7-BAÑO CON JABON BLANCO + ANTISEBORREICO + CLOREXIDINA-PIPETA OSSPET','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('46','2017-06-09','17','17','4','APRAX 20KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('47','2018-09-21','17','17','3','VACUNA QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('48','2017-03-06','17','18','4','CACHORRO ENCONTRADO EN LA VÍA PUBLICA. SE DESPARASITA, NO SE VACUNA. SE RECOMIENDA OBSERVACIÓN HASTA EL DÍA DE SU VACUNA. PESO: 1.700KG APROX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('49','2017-03-13','17','18','3','1° DOSIS QUINTUPLE + ATP APRAX 2.440KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('50','2017-04-10','17','18','3','2° DOSIS QUINTUPLE + ATP APRAX 4.880KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('51','2017-06-09','17','18','3','QUINTUPLE + APRAX ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('52','2017-09-05','17','18','6','ORQUIECTOMIA - ENROFLOXACINAX10 + PREDNISOLONA 10MG 1/2 CADA 12X3','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('53','2018-09-20','17','19','2','DIARREA CON ESTRIAS DE SANGRE. APRAX X 3 DIAS (11.400KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('54','2018-09-21','17','19','3','1° DOSIS QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('55','2015-04-24','17','20','3','1° DOSIS QUINTUPLE + ATP 1.300KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('56','2015-05-18','17','20','3','2° DOSIS QUINTUPLE + ATP 2.070KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('57','2018-10-13','17','20','3','3° DOSIS VACUNACION + ATP 2.670KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('58','2018-10-13','17','20','3','VACUNA ANTIRRABICA + ATP 4.150KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('59','2016-06-09','17','20','3','QUINTUPLE + APRAX 4.300KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('60','2017-03-06','17','20','3','ANTIRRABICA + APRAX 4.800KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('61','2017-06-09','17','20','3','QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('62','2018-09-29','17','20','2','PSEUDOPREÑEZ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('63','2017-02-08','18','21','2','TRAQUEOBRONQUITIS INFECCIOSA. TRIBIOTIC - DEXA 
ENROFLOXACINA 50MG 1 COMPRIMIDO C/ 24HS X 10DIAS + PREDNISOLONA 20MG 1/2 COMPRIMIDO C/ 12HS X 3DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('64','2017-03-15','18','21','2','OBSTRUCCION DE GLANDULAS PERIANALES','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('65','2017-04-20','18','21','2','DIARREA- OBSTRUCCION DE GLANDULAS PERIANALES. CANEX ATP 9.300KG. ALIMENTO EXCELLENT + ARROZ X 3 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('66','2018-08-31','18','21','2','CANEX - CUALCOVIT B 1ML C/24HS (CAIDA PELO)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('67','2018-03-07','18','21','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('68','2018-10-13','18','21','2','APRAX.  OBSTRUCCION GLANDULAS PERIANALES. DIARREA: MV GASTROINTESTINAL + ARROZ + MOTILSEC 1 COMPRIMIDO C/24HS POR 3 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('69','2018-09-17','19','22','3','1° DOSIS QUINTUPLE + APRAX 8.600','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('70','2018-10-13','19','22','3','2° DOSIS QUINTUPLE- SEBORREA, BAÑO CON JABON BLANCO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('71','2017-05-26','20','23','2','REACCION  ALERGICA- POSIBLE ATOPIA- DERMIL 1/4 C/12X 5 DIAS- 1/4 C/24X5 DIAS- 1/4 C/48HS-72HSX30DIAS- APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('72','2017-06-14','20','23','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('73','2017-08-14','20','23','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('74','2017-10-18','20','23','2','MATERIA FECAL CON SANGRE- UNICO ANTECEDENTE: COMIO HUESO. TRIBIOTIC + DEXA- AYUNO- VASELINA- SI NO MEJORA-> ECOGRAFIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('75','2017-04-17','20','23','2','POSIBLE REACCION ALERGICA- DEXA. PREDNISOLONA POR UNA SEMANA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('76','2018-06-21','20','23','3','ANTIRRABICA (ZOETIS - SERIE 254969B - N° SERIE SENASA 103684951M)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('77','2018-06-27','20','23','2','COMIENZO APOQUEL 5.4MG 1/2 C/12HS POR 14 DIAS - 1/2 C/24HS X 60 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('78','2018-08-21','20','23','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('79','2018-08-24','20','23','2','DERMATITIS POR PULGAS- NEXGARD + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('80','2018-09-29','20','23','2','NEXGARD + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('81','2018-10-13','20','23','4','ATP (APRAX) Y COMIENZO DERMIL 1/4 C/12 POR UNA SEMANA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('82','2015-10-30','21','24','3','VACUNA QUINTUPLE + ANTIRRABICA +  ATP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('83','2016-11-08','21','24','3','VACUNA QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('84','2016-12-27','21','24','4','APRAX 5 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('85','2018-01-29','21','24','3','VACUNA QUINTUPLE + ATR + ATP APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('86','2018-10-13','21','24','2','EMERGENCIA POR MORDIDA EN CUELLO. ENROFLOXACINA + PREDNISOLONA. COMIENZO INYECTABLE CON TRIBIOTIC Y DEXA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('87','2018-10-12','5','5','2','RADIOGRAFIA DE CADERA. FRACTURA EN CADERA. NO SE OPERA. TRAMADOL  60 MG 1/4 C/ 12 HS. RIMADYL 25 MG 1/2 COMPRIMIDO CADA 12 HS. OSTEOCART PLUS 1 COMPRIMIDO/DIA POR 6 MESES.  ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('88','2018-08-25','24','26','2','DIARREA POR REPLECION GASTRICA. AYUNO. MODIFICACION DE DIETA. ATP TOTAL FULL 3.250 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('89','2018-08-28','24','26','2','COMIENZO CON IVERMECTINA POR SARNA SARCOPTICA. 5 APLICACIONES SEPARADAS POR UNA SEMANA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('90','2018-08-31','24','26','3','1 VACUNA QUINTUPLE ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('91','2018-09-25','24','26','3','2 VACUNA QUINTUPLE + APRAX 7.890 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('92','2018-10-17','24','26','3','3 VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('93','2015-02-27','23','27','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('94','2015-11-28','23','27','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('95','2016-03-05','23','27','3','ANTIRRABICA + BASKEN PLUS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('96','2016-08-03','23','27','4','APRAX COMP. 12 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('97','2016-12-27','23','27','3','VACUNA QUINTUPLE + APRAX 12.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('98','2017-03-06','23','27','3','VACUNA ANTIRRABICA + APRAX 12 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('99','2017-12-21','23','27','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('100','2018-03-26','23','27','3','ANTIRRABICA + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('101','2018-10-16','23','27','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('102','2015-02-03','25','28','2','TOS DE LAS PERRERAS. PREDNISOLONA. APRAX 10.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('103','2015-10-26','25','28','2','TOMA DE MUESTRA PARA DETERMINAR MOMENTO DEL CICLO ESTRAL. CELO ANTERIOR JULIO 2015','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('104','2015-11-15','25','28','8','1 ANOVULATORIO ELMER','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('105','2016-04-02','25','28','8','2 ANOVULATORIO ELMER','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('106','2016-05-21','25','28','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('107','2016-10-22','25','28','8','3 ANOVULATORIO + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('108','2017-03-08','25','28','8','4 ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('109','2017-05-10','25','28','3','VACUNA QUINTUPLE + ANTIRRABICA + APRAX 12 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('110','2018-01-12','25','28','8','5 ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('111','2018-05-13','25','28','3','VACUNA QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('112','2018-01-12','25','28','8','5 ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('113','2018-07-17','25','28','2','COMIENZO DE CELO. DECAIMIENTO. TRIBIOTIC + VIT. OJO CON PIOMETRA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('114','2018-10-16','25','28','2','MASTITIS. DECAIMIENTO. POLIDIPSIA. TEMPERATURA 40 GRADOS. TRIBIOTIC + VIT + DIPIRONA. ENRO 100 MG X 10 DIAS + DIPIRONA 500 1/4 CADA 12. SOLICITO ECOGRAFIA UTERINA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('115','2015-08-05','26','29','3','3 VACUNA QUINTUPLE + FENTEL SUSP. 1.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('116','2015-10-05','26','29','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('117','2016-01-13','26','29','2','INFLAMACION GLANDULAS PERIANALES. DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('118','2016-08-08','26','29','3','VACUNA QUINTUPLE + BASKEN 3.030 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('119','2016-10-08','26','29','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('120','2017-08-12','26','29','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('121','2017-08-25','26','29','2','VOMITOS ESPORADICOS, NORMALMENTE POR LA MAÑANA. MANEJO: 70 GR ROYAL CANIN DIVIDIDO EN TRES COMIDAS. AGUA DE LA CANILLA, NUNCA DE LA HELADERA. RANITIDINA 500 1/4 C/ 24 HS X 7 DIAS. PREDNISOLONA 10 MG 1/4 C/ 12 HS X 5 DIAS. PROTECTOR HEPATICO 1 C 12 HS X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('122','2017-10-11','26','29','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('123','2018-08-17','26','29','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('124','2018-10-17','26','29','3','ANTIRRABICA. PROVIDEAN . SENASA 131274651 M. SERIE 087','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('125','2018-10-17','27','30','2','ACCIDENTE DE TRANSITO A LA ALTURA DE MIEMBRO ANTERIOR. EXAMEN NORMAL. DOLOR MIEMBRO IZQ. TRAMADOL + DEXA + TRIBIOTIC + VIT. 1/2 COMP TRAMAVIER 80 CADA 12HS POR 5 DIAS + 1 COMP PRED 20 CADA 24HS POR 5 DIAS. POSIBLE COMPLICACION HERNIA DIAFRAGMATICA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('126','2018-10-17','28','32','2','HERIDA EN LA PUNTA DE LA OREJA. PERVINOX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('127','2018-10-17','29','33','2','SE LE APLICA IVERMECTINA (SEBORREA, POSIBLE DEMODEX). SHAMPOO CON AMITRAZ 1 VEZ POR SEM. VIT B Y APRAX 7 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('128','2018-10-17','30','34','7','2° DOSIS IVERMECTINA. 2.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('129','2018-10-17','10','13','4','TOTAL FULL 0.600 KG. REGRESA EN 15 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('130','2018-03-22','31','35','2','NO TIENE VACUNAS. PROCESO INFECCIOSO EN LABIO. DEXA + TRIBIOTIC. PREDNISOLONA X 4 DIAS + ENRO X 12 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('131','2018-10-18','31','35','2','DOLOR EN MIEMBRO ANTERIOR IZQUIERDO. ABDOMEN TENSO. PREDNISOLONA X DOS DIAS. SOLICITO ECOGRAFIA ABDOMINAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('132','2018-10-18','32','36','2','PATA POSTERIOR IZQUIERDA CON EDEMA. DEXA. ATE TOTAL FULL 0.220 KG. REGRESA EN 15 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('133','2018-09-26','33','37','2','ALOPECIA + DERMATITIS EN CUELLO. BILATERAL SIMÉTRICA. PREDNISOLONA + COMFORTIS. CONTROL 15 DÍAS POR ENFERMEDAD METABÓLICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('134','2018-10-18','33','37','7','COMIENZO DE CRECIMIENTO DE PELO, SIN AREAS ALOPECICAS. CONTROL EN 20 DÍAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('135','2017-09-16','34','38','3','2DA VACUNA 5° + BASKEN SUSPENSIÓN (1, 550 KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('136','2017-10-07','34','38','3','3ER VACUNA 5° + APRAX ( 1,920 KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('137','2018-02-03','34','38','3','ANTIRRÁBICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('138','2018-08-18','34','38','2','OBSTRUCCION GL. PERIANALES. PRURITO EN CUELLO Y COLA. PULGAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('139','2018-08-31','34','38','2','CREMA 6 A. LESIÓN ANAL. LAMIDO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('140','2018-10-18','34','38','3','REFUERZO 5° + APRAX (4,800 KG). POSIBLE PREÑEZ ( POCO PROBABLE) POR UN LABRADOR HACE 15 DIAS. CONTROL EN 20 DÍAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('141','2018-10-18','35','39','2','MALESTAR GASTRICO. COMIO CEMENTO DURANTE UNOS DIAS. T NORMAL. SE APLICA GASTRINE CON DEXA. AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('142','2018-10-19','32','36','2','VENDAJE POR FRACTURA EN METATARSO. CAMBIOS SEMANALES. FISTULA CON ABSCESO. CEFALEXINA SUSP. 0.3 ML C/ 12 HS. X 10 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('143','2018-10-20','33','37','2','COMIENZO CON PROAGE 1/4 POR DIA + APRAX+ CREMA 6A POR TIÑA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('144','2018-05-12','37','42','2','DECAIMIENTO - MICCION SANGUINOLENTA.  SE LE ADMINISTRO PREDNISOLONA X 4 DIAS + ENRO X 10. SE APLICA TRIBIOTIC + DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('145','2017-09-01','38','43','3','1° VACUNA QUINTUPLE. NO SE DESPARASITA, PESO: 1.070KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('146','2017-09-22','38','43','3','2° DOSIS QUINTUPLE. APRAX SUSPENCION PESO: 1.670KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('147','2017-10-13','38','43','3','3° DOSIS QUINTUPLE. APRAX COMPRIMIDO PES: 2.300KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('148','2018-01-11','38','43','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('149','2018-07-11','38','43','2','TRAQUOBRONQUITIS - FEBRICULA/ DIPIRONA + TRIBIOTIC + DEXA (INYECTABLE). ENRO + PREDNISOLONA + DIPIRONA (COMPRIMIDO)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('150','2017-08-08','36','40','2','DEMODEX - PYODERMX24DIAS + CUALCOVIT B X 60. SINO MEJORA --> EQVALAN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('151','2017-09-14','36','40','2','COMIENZO CON EQVLAAN (PESO 12,600KG) DILUIDO EN 25ML, 1.2-1.3ML C/24HS. OJO CON LEISHMANIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('152','2016-05-03','36','41','2','TRAQUOBRONQUITIS INFECCIOSA CANINA. T° NORMAL ENRO 100MG DURANTE 10 DIAS, PREDNISOLONA 20MG 1/2 COMPRIMIDO C/ 12HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('153','2016-10-14','36','41','2','REACCION ALERGICA POSIBLEMNTE POR RESTOS DE JABON. DERMIL - BAÑO CON AGUA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('154','2017-09-06','37','44','2','DERMATITIS ALERGICA EN ZONAS VENTRALES (POLAR, LANA, LAVANDINA, PASTO, ETC) DERMIL 1/4 C/ 12HSX 3 DIAS- 1/4 C/48X 30DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('155','2017-11-06','37','44','2','40°- DECAIMIENTO- ALERGIA RESPIRATORIA - RUMICLAMOX 1/4 C/12HS X 10DIAS- DIPIRONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('156','2017-11-10','37','44','7','39.7° AMOXI + DIPIRONA + SRE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('157','2018-02-15','37','44','2','CUADRO ALERGICO RESPIRATORIO. ENRO X 10 DIAS + DIPIRONA 1/4 C/8HS X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('158','2018-05-26','37','44','2','PRURITO GENERALIZADO - PREDNISOLNA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('159','2018-06-02','37','44','7','FIEBRE - DIPIRONA + TRIBIOTIC - NOVALGINA C/8HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('160','2018-10-20','28','32','2','TRAUMATISMO EN ZONA IZQUIERDA DEL CUERPO, ESCORIACION Y HEMATOMA EN MIEMBRO ANTERIOR IZQUIERDO A LA ALTURA DEL CODO. SE LE ADMINISTRO DEXA, RIMADIL 25MG C/12HS X 4 DIAS, ALGEN 60 1/4 C/ 8HS X 3 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('161','2016-08-16','39','46','2','BRONQUITIS - DIPIRONA - RUMICLAMOX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('162','2016-10-26','39','46','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('163','2017-04-21','39','46','2','TOS - FLEMA. ENRO 50MG 1/2 C/24HSX 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('164','2017-12-05','39','46','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('165','2016-10-26','39','48','3','QUINTUPLE + ATP (BASKEN) PESO: 1.900KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('166','2016-12-12','39','48','2','MALESTAR GASTROINTESTINAL, POSIBLE CONSUMO DE DURAZNO. VIT + DEXA + AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('167','2017-12-05','39','48','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('168','2015-09-27','39','47','2','SERVICIO 7 MESES - PARTO 28/09','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('169','2016-01-02','39','47','2','SERVICIO. POSIBLEB FECHA DE PARTO: 28-02/09-03. PARTO: 4-5/03','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('170','2016-07-20','39','47','2','VOMITO. GASTRINE + PROTECTOR HEPATICO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('171','2016-08-16','39','47','2','BRONQUITIS. TRIBIOTIC + VIT','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('172','2016-10-26','39','47','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('173','2016-12-22','39','47','2','DECAIMIENTO. T° NORMAL, VASELINA 1ML 3 O 4 VECES POR DIA A EFECTO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('174','2017-05-09','39','47','2','T° NORMAL, TRAQUEBRONQUITIS INFECCIOSA. PREDNISOLONA 10MG 1/2 COMP C/ 12HS. SI CONTINUA REGRESA EL VIERNES PARA CONTINUAR CON ANTIBIOTICOS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('175','2017-12-05','39','47','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('176','2016-10-26','39','45','3','QUINTUPLE + ATP (BASILEN) PESO: 2.400KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('177','2016-12-20','39','45','2','FECHA DE SERVICIO: 20/12/16. FECHA POSIBLE DE PARTO: 20/02 AL 2/03. PROMEDIO: 26/02','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('178','2017-04-21','39','45','2','TOS - PREDNISOLONA 10MG 1/4 C/12HS X 3DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('179','2017-08-22','39','45','2','ECO GESTACIONAL 3+ -1. 40 DIAS APROX. FECHA POSIBLE DE PARTO --> 8/09 - 18/9. PROMEDIO: 14/09','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('180','2017-12-05','39','45','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('181','2018-10-19','39','45','2','SERVICIO 48HS ANTES. DESPIDE SECRECION CON FUERTE OLOR. POSIBLE VAGINITIS - PIOMETRA. SE LE ADMINISTRO TRIBIOTIC + DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('182','2017-10-20','40','49','3','3° DOSIS QUINTUPLE- APRAX (PESO 8.360)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('183','2018-03-20','40','49','2','CONTROL DE PESO (27.300KG). REGRESA EN UNA SEMANA A CONTROL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('184','2018-10-20','40','49','3','DOSIS ANUAL QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('185','2018-10-19','8','50','2','PRURITO, DERMATITIS, ALOPECIA, PIEL NEGRA CON HIPERQUERATOSIS EN SECTORES. DIFICULTAD PARA CICATRIZA.  RASPADO DE PIEL. DEMODEX.  SE APLICA IVERMECTINA + TRIBIOTIC+ DIFENILHIDRAMINA+ DEXA. VIA ORAL: ENRO + PREDNISOLONA. RETORNO EN 7 DIAS. POSIBLE CONTAMINACION CON MALASSEZIA. (SE COMIENZA CON DECTOMAX 0.4 MG/KG/SEMANA/SC)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('186','2017-06-06','41','51','3','1 VACUNA TRIPLE + BASKEN SUSP. 1.280 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('187','2017-07-08','41','51','3','2 VACUNA TRIPLE + BASKEN SUSP. 1.720 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('188','2017-09-12','41','51','3','3 VACUNA TRIPLE + APRAX 2.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('189','2017-09-16','41','51','2','DIARREA LUEGO  DE SU CASTRACION. POSIBLE DISBACTERIOSIS. ACTIMEL + ENTEROSEPT CADA 8 HS + EXCELLENT.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('190','2018-02-22','41','51','2','HIPERTERMIA 40.5 GR. TRIBIOTIC + VIT+ ENRO X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('191','2018-09-21','41','51','2','DRENAJE ABSCESO DE CABEZA. ENRO X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('192','2018-10-05','41','51','3','TRIPLE FELINA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('193','2018-10-21','41','51','2','HIPERTERMIA 39.8 GR. DESHIDRATACION. VOMITOS ABUNDANTES. TRIBIOTIC+ VIT+ GASTRINE+ DEXA. AYUNO + BAÑOS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('194','2015-11-09','42','52','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('195','2016-01-20','42','52','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('196','2016-02-04','42','52','4','BASKEN PLUS 1.910 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('197','2016-05-24','42','52','2','OTITIS. OTOVIER NF 4 GOTAS C 12 HS X 1 SEMANA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('198','2016-11-07','42','52','3','VACUNA QUINTUPLE + BASKEN 2.080 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('199','2017-01-23','42','52','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('200','2017-10-25','42','52','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('201','2018-03-19','42','52','2','ADENOMA PERIANAL. ABSCESO. PREDNISOLONA CADA 12 HS + ENRO X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('202','2018-10-22','42','52','2','NUEVO ABSCESO PERIANAL. TRIBIOTIC + DEXA. PREDNISOLONA X 4 DIAS + ENRO X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('203','2014-06-25','41','53','2','DEMODEX. COMIENZO CON IVERMECTINA EN POLVO ORAL(VETANCO) DURANTE 3 MESES. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('204','2017-02-03','41','53','3','VACUNA QUINTUPLE + APRAX 19.500 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('205','2018-02-07','41','53','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('206','2013-07-27','7','54','2','MESTIZO CRUZA MINIATURA. VACUNADO ANTERIORMENTE EN OTRA VETERINARIA. BASKEN PLUS 2.550 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('207','2018-08-24','7','54','3','VACUNAS QUINTUPLE Y ANTIRRABICA. S:084 SENASA: 130917625 M. PROVIDEAN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('208','2018-06-28','41','55','3','1 VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('209','2018-07-19','41','55','3','2 VACUNA QUINTUPLE + APRAX 1.990 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('210','2018-08-11','41','55','3','3 VACUNA QUINTUPLE ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('211','2016-02-01','21','56','2','PARCHE CALIENTE EN CABEZA , OREJA Y CUELLO. ENROFLOXACINA 100 MG X 10 DIAS + PREDNISOLONA X 4 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('212','2016-02-22','21','56','2','RECAIDA EN SU CABEZA. CREMA 6 A . DERMIL 1/2 C/ 12 X 3 - 1/2 C/ 24 X 3 - 1/2 C/48. APRAX 32 KG ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('213','2016-08-04','21','56','4','APRAX 35 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('214','2016-12-27','21','56','4','APRAX 32 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('215','2018-02-07','21','56','2','PARCHE CALIENTE EN HOCICO. PYO DERM 500 X 20 DIAS + PREDNISOLONA X 7 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('216','2017-03-15','44','58','2','DOLOR EN MIEMBRO POSTERIOR IZQ. POSIBLE LUXACION. NO SE HACE PLACA (LESION DE 25 DIAS). PREDNISOLONA 1/2 COMP C/12 HS X 4 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('217','2017-03-17','44','58','3','5° + ATR + ATP (APRAX) 6.060KG. SE DERIVA A CONSULTA TRAUMATOLOGICA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('218','2017-03-20','44','58','2','RX. LUXACION COXOFEMORAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('219','2017-03-31','44','58','6','EXCERESIS DE LA CABEZA FEMORAL. RIMADIL 75MG 1/4 C/24HS X 4 DIAS + TRAMADOL 20MG 1/2 C/12HS X 5 DIAS + ENRRO 50MG 1COMP C/24HS X 10 DIAS + POLADIN 15 1/2 X DIA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('220','2017-04-07','44','58','4','ATP 6.300 KG APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('221','2018-04-13','44','58','3','5° + ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('222','2018-10-03','44','58','2','PSEUDOPREÑEZ. MANEJO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('223','2018-04-13','44','59','3','2° VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('224','2018-05-04','44','59','3','3° VACUNA QUINTUPLE ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('225','2018-06-05','44','59','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('226','2018-10-22','43','57','2','DERMATITIS MULTIFOCAL. PRURITO + ALOPESIA. ANTECEDENTES: EN UNIVERSIDAD TRATADO CONTRA SARNA, HONGOS, PIODERMIAS. SIN RESULTADOS +. CONSUME DOG CHOW. BAÑO CRONICO CON FORMULA MACDONALD. SE REALIZA TRATAMIENTO PALEATIVO CON DERMIL 1 COMP C/12 X 4 DIAS - 1/2 C/12 X 7 DIAS - 1/2 C/24 X 7 DIAS - 1/2 C/48 X 1 MES. SE APLICA TRIBIOTIC + DEXA. SE SUGIERE CAMBIO DE DIETA A HIPOALERGENICO, OLD PRINCE O CASERO, BAÑO CON JABON BLANCO + SHAMPOO HIPOALERGENICO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('227','2018-10-23','14','16','3','3° DOSIS VACUNA QUINTUPLE + APRAX 3.690KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('228','2018-10-24','30','34','7','3° DOSIS IVERMECTINA 3.200KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('229','2018-10-25','46','61','2','ATP TOTAL FULL SUSP. 0.380 KG. REGRESA EN 15 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('230','2018-09-28','45','60','4','TOTAL FULL SUSP. 0.780 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('231','2018-10-24','45','60','3','1 VACUNA TRIPLE . PESO 1.220 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('232','2015-05-13','47','63','3','3° DOSIS  VACUNA QUINTUPLE + APRAX 3KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('233','2016-08-25','47','63','3','QUINTUPLE + DERMIL POR PARCHE CALIENTE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('234','2016-10-06','47','63','2','PARCHE CALIENTE. CREMA 6A','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('235','2017-02-01','47','63','2','PARCHES CALIENTES EN CUELLO - OREJAS - MIEMBROS. PYODERM 500 1/4 C/12 X 20-30 DIAS + PREDNISOLONA 10MG 1/4 C/12 X4.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('236','2017-05-30','47','63','2','PARCHE CALIENTE ZONA DE LA CRUZ. PREDNISOLONA 10MG 1/2 C/12 X4 DIAS. PYODERM 1/4 C/12 X 15 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('237','2018-10-05','47','63','2','DOLOR ARTICULAR LUMBAR. PREDNISOLONA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('238','2016-01-05','48','64','2','FISTULA CON INFECCION PERIANAL (GL. PERIANAL? - ADENOMA?). ENRRO X 15 DIAS + PREDNISOLONA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('239','2017-03-25','48','64','2','ADENOMA O ADENOSARCOMA PERIANAL DERECHO. PREDNISOLONA 10MG 1/4 C/12HS X 4 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('240','2018-10-25','48','64','2','INFLAMACION PERIANAL. CONGESTION EN ZONA. DEXA. PREDNISOLONA X 2 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('241','2018-09-03','49','65','2','DOLOR EN MANO. PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('242','2018-10-25','49','65','2','POSIBLE SARCOPTES. IVERMECTINA 0.3 + DEXA + DIFENILHIDRAMINA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('243','2018-10-25','49','66','2','POSIBLE SARCOPTE O DERMATITIS POR PULGAS. IVERMECTINA 0.35 + DEXA + DIFENHIDRAMINA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('244','2016-02-18','52','69','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('245','2017-03-18','52','69','2','DERMATITIS POR PULGAS. NEXGARD. PREDNISOLONA. CREMA 6 AEN HOCICO POE PICADURA O ESPINA DE CACTUS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('246','2018-10-26','50','67','2','DECAIMIENTO. ANOEXIA. TEMPERATURA NORMAL. GLANDULAS PERIANALES CON MUCHO CONTENIDO. VIT + DEXA+ GASTRINE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('247','2018-10-26','51','68','2','POLIDIPSIA-POLIURIA. SANGRE EN ORINA, EN ESTRIAS. TEMPERATURA NORMAL. FUE CASTRADA POR PIOMETRA 7 AÑOS ATRAS. APARENTEMENTE LE DEJAN LOS OVARIOS. SE APLICA CLAMOXIL + TRIBIOTIC + VIT + DEXA. ENRO POR 10 DIAS. SOLICITO ANALISIS SANGRE, CON PERFIL RENAL Y ECOGRAFIA. HACE AÑO TUVO ACCIDENTE, DESDE ESE MOMENTO TIENE DIFICULTAD EN SUS PATAS Y NO RETIENE ORINA, POSIBLE INCONTINENCIA POST CASTRACION.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('248','2017-05-10','52','70','2','HERIDA EN CABEZA-PUS-ANOREXIA-T 39.9 °C. TRIBIOTIC + DEXA+ VIT+ BAÑOS. ENRO 50 1/2 COMP CADA 12 HS X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('249','2015-11-12','52','71','2','MOSCA DE LA PUNTA DE LA OREJA. CREMA PUNTOREJA. ATP BASKEN.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('250','2017-06-24','52','71','2','MICOSIS. KETOCONAZOL 1/2 C/24 X 20-40 + KUALCOHEPAT 1 C /24 + PREDNISOLONA 10 MG 1/2 C /12 X 2 + KUALCOVIT B 1 ML C/24 X 60 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('251','2017-07-21','52','71','2','AUMENTO DE PESO, 12.250 KG. AUMENTAMOS DOSIS DE KETOCONAZOL 3/4 CADA 24 HS 20 DIAS MAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('252','2018-10-28','52','71','2','TRAQUEOBRONQUITIS. T 40|C. TRIBIOTIC + DEXA+ DIPIRONA. CONTINUA CON ENRO + PREDNISOLONA + DIPIRONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('253','2018-10-29','53','72','2','ANESTESIA GENERAL POR FUS. PROPANTELINA, DEXAMETASONA + TRIBIOTIC. ALIMENTO URINARIO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('254','2017-08-26','54','73','3','1 VACUNA QUINTUPLE + APRAX SUSP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('255','2017-09-19','54','73','3','2 VACUNA QUINTUPLE + APRAX SUSP. 1.620 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('256','2017-10-10','54','73','3','3 VACUNA QUINTUPLE + APRAX 2 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('257','2018-01-21','54','73','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('258','2018-10-29','54','73','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('259','2016-03-08','54','74','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('260','2017-02-02','54','74','3','VACUNA QUINTUPLE + VACUNA ANTIRRABICA + APRAX 24.500 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('261','2018-10-29','48','64','4','APRAX COMP. 10 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('262','2018-02-07','54','74','3','VACUNA QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('263','2018-02-22','55','75','2','Infeccion cronica recurrente con hipertermia. Viene de otra veterinaria. Enrofloxacina 50 1/2 c /24 x 15 dias+ prednisolona c/12 x 4+ kualcovit b 1 ml c/ 24 hs. Positivo a leucemia. Baños para controlar la temperatura.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('264','2018-02-28','55','75','2','Hisopado nasal. Cultivo. Antibiograma.Citologia','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('265','2018-03-06','55','75','2','Comienzo con amoxi-clavulanico 250 1/2 c/12 x 12','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('266','2018-03-21','55','75','2','Comienzo con ketoconazol 200 1/4 c/24 hs x 40 dias + protector hepatico','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('267','2018-04-09','55','75','2','Fluoresceina negativa. Uveitis. Tau con esteroides + prednisolona x 8 dias.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('268','2018-04-24','55','75','2','Preñez avanzada. Comienzo con enrofloxacina x 10 dias por infeccion','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('269','2018-06-22','55','75','6','ovariohisterectomia','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('270','2018-08-03','55','75','2','Comienzo con taurina x dia. + prednisolona x 3 dias','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('271','2018-08-15','55','75','2','enrofloxacina x 20 dias + ivermectina oral 1/8 c / 7 dias x 1 mes','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('272','2018-10-30','55','75','2','Comienzo con doxiciclina x 10 dias + prednisolona + taurina. Por infeccion respiratoria','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('273','2013-05-24','56','76','6','HISTIOCITOMA. SE REALIZA HISTOPATOLOGIA. EN ZONA DORSAL DEL CUELLO. CIRUGIA. TRIBIOTIC + PYO DERM X 4 DIAS MAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('274','2013-11-22','56','76','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('275','2014-05-02','56','76','2','AUMENTO DE TAMAÑO DE PAROTIDA IZQUIERDA. CRIPTORQUIDEA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('276','2014-10-07','56','76','3','VACUNA ANTIRRABICA + APRAX 5.750','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('277','2015-07-18','56','76','4','BASKEN 6.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('278','2015-10-08','56','76','3','VACUNA ANTIRRABICA + QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('279','2015-12-21','56','76','2','VOMITO SIN CORTE. ECOGRAFIA. OBSTRUCCION EN ESTOMAGO E INTESTINO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('280','2015-12-22','56','76','6','GASTROTOMIA-ENTEROTOMIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('281','2016-04-30','56','76','4','APRAX ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('282','2016-08-20','56','76','4','APRAX 5.900 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('283','2016-10-14','56','76','3','VACUNAS QUINTUPLE Y ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('284','2017-01-21','56','76','2','REACCION ALERGICA EN INGLE Y ESCROTO. TRIBIOTIC + DEXA. PREDNISOLONA 1/4 C/12 X 4 + CREMA 6A','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('285','2017-03-17','56','76','2','reaccion alergica. dermil 1/4 c /12 x 3- 1/4 c/24 x 3- 1/4 c/48 x 20','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('286','2017-10-28','56','76','3','VACUNAS QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('287','2018-10-31','56','76','3','VACUNAS QUINTUPLE + ANTIRRABICA PROVIDEAN SERIE 13089415114 S 084','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('288','2018-11-01','57','77','2','PARTO 7 CACHORROS VIVOS. OJO ECLAMPSIA. CONSUME SABROSITOS, SE CAMBIA POR KEN L CACHORRO. SE APLIVA AMINOACIDOS VIT.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('289','2018-11-01','51','68','2','EXTRACCION DE SANGRE.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('290','2018-11-01','58','78','2','VÓMITOS, SOBRECARGA GASTRICA, CONSUMO DE PASTO. PESO: 0.920KG. T° 38.2 °C. SE LE ADMINISTRO GASTRINE, AA VIT, DEXA Y SUERO SUBCUTÁNEO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('291','2015-05-08','58','80','2','DOLOR EN PERINE- POSIBLE TRAUMATISMO (HEMATOMA) - T: 40° C. PACIENTE MONORQUIDO - DEXA - DIPIRONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('292','2016-02-05','58','80','2','TRAQUEOBRONQUITIS (OJO TIENE 12 AÑOS). AMOXI + CLAVULANICO 1/8 C/12 X 8 + PREDNISOLONA 1/4 C/8 X 1 - 1/4 C/12 X 4','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('293','2016-10-18','58','80','4','COMFORTIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('294','2016-10-19','58','80','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('295','2016-12-13','58','80','4','CANEX 3.400KG X 3 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('296','2017-01-27','58','80','2','BRONQUITIS. RUMICLAMOX 1/2 C/12 X 10 (250MG) + PREDNISOLONA 10 1/2 C/12 X 4- TRIBIOTIC + DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('297','2018-03-22','58','80','3','QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('298','2016-10-15','58','79','2','VOMITOS. GASTRINE + TRIBIOTIC + VIT. AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('299','2016-10-17','58','79','7','CONTINUA CON VOMITOS. SIN DIARREA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('300','2016-10-18','58','79','5','INTERNACION. EXTRACCION SANGRE. PARVOVIRUS. ECOGRAFIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('301','2016-12-13','58','79','4','CANEX X 3DIAS. PESO: 3.600KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('302','2018-03-22','58','79','3','QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('303','2017-07-06','59','83','3','3° DOSIS QUINTUPLE + APRAX (PESO: 7.160KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('304','2017-09-12','59','83','2','DERMATITIS EN DORSAL POR PULGAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('305','2017-09-18','59','83','4','APRAX. COMIENZO CON POLADIN CACH 1/DIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('306','2017-02-14','59','84','2','MICOSIS CUTANEA. TRATAMIENTO: KETOCONAZOL 1/4 COMPRIMIDO A 1/2 COMP C/24HS DURANTE 30 A 40 DIAS + KUALCOVIT B 1ML/DIA. SI NO MEJORA EN 15 DIAS DESCARTAR DEMODEX. ACTUALMENTE CUENTA CON UNA SOLA VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('307','2017-02-01','59','84','3','2° DOSIS QUINTUPLE + ATP (APRAX) PESO: 7.100KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('308','2017-03-30','59','84','3','3° DOSIS QUINTUPLE + ATP (APRAX) PESO: 11.250KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('309','2017-05-30','59','84','2','VOMITOS. TEMP: 39.5°C (LIMITE). GASTRINE + VIT + DEXA + TRIBIOTIC','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('310','2018-01-24','59','85','3','1° DOSIS QUINTUPLE + APRAX (PESO: 3.360KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('311','2018-02-14','59','85','3','2° DOSIS QUINTUPLE + APRAX (PESO: 4.920KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('312','2018-03-07','59','85','3','3° DOSIS QUINTUPLE + APRAX (PESO: 7.350KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('313','2017-08-26','59','81','3','2° DOSIS QUINTUPLE + APRAX (PESO: 7.140KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('314','2018-11-02','59','81','3','3° DOSIS QUINTUPLE + APRAX (PESO: 9.070KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('315','2018-11-02','59','81','2','PIODERMIA, POSIBLE MICOSIS. SE LE ADMINISTRO TRIBIOTIC + DEXA. ENRO 200MG 3/4 DURANTE 10 DIAS + PRENDISOLONA X 6 DIAS + PERVINOX C/12HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('316','2018-11-02','60','82','2','GINGIVITIS - PIEZAS DENTARIAS FLOJAS. ODONTOBIOTIC C/12HS X 10 DIAS + PREDNISOLONA C/12HS X 6 DIAS. REGRESA A CONTROL EN 15 DIAS POR POSIBLE CIRUGIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('317','2018-11-02','49','66','7','9.850 KG. 2 IVERMECTINA 0.45 ML.+ PREDNISOLONA 10 MG 1/2 COMP C /12 HS X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('318','2018-11-02','49','65','7','4.850 KG  2 IVERMECTINA 0.35 + PREDNISOLONA 10 MG 1/2 COMP C/ 12 HS X 4 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('319','2018-11-02','61','87','2','HERIDA POR MORDEDURA EN CUELLO Y CABEZA. TRIBIOTIC Y DEXA. PREDNISOLONA X 4 DIAS + PYODERM X 20 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('320','2018-04-27','61','89','3','TRIPLE FELINA + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('321','2018-08-14','61','89','2','FUS - PROPANTELINA + ENRO + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('322','2016-10-03','61','88','3','ANTIRRABICA + ATP (PESO: 5.800KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('323','2017-03-06','61','88','4','ATP BASKEN (PESO: 6 KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('324','2018-04-26','61','88','2','DECAIMIENTO, HIPERTERMIA, ICTERICIA, ANOREXIA, MATERIA FECAL, PULGAS, POSIBLE HAEMOBARTONELOSIS - PUNCION OREJA. TRIBIOTIC + VIT + DEXA, 25MG DOXICICLINA C/12HS X 15 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('325','2016-04-07','62','90','3','TRIPLE FELINA + ATP BASKEN (PESO: 4.280KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('326','2016-06-24','62','90','3','ANTIRRABICA (PESO: 4.400KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('327','2017-04-08','62','90','3','TRIPLE FELINA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('328','2017-08-25','62','90','3','ANTIRRABICA + APRAX (PESO:4.700KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('329','2018-06-29','62','90','3','TRIPLE FELINA + APRAX (PESO: 4.840KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('330','2018-11-02','62','90','3','ANTIRRABICA (N° SERIE: 087/1DS - SENASA: 131274647M, MARCA PROVIDEN) + APRAX (PESO: 4.920KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('331','2018-11-03','58','78','3','1 VACUNA 1 QUINTUPLE + TOTAL FULL SUSP. 0.880 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('332','2018-11-03','31','35','2','DECAIMIENTO, HIPERTERMIA (40.5°C) PRESUNTIVO: LEPTOSPIROSIS. SE LE ADMINISTRO TRIBIOTIC + AA VIT + DEXA + DIPIRONA.  DOXICICLINA 50MG C/12HS POR 20 DIAS, DIPIRONA. DEBE VOLVER A LAS 72HS PARA REALIZAR EXTRACCION DE SANGRE Y POSTERIORMENTE UN ANALISIS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('333','2018-11-04','64','91','2','POLIURIA E INCONTINENCIA. ATENDIDA ANTERIORMENTE POR GASTROENTERITIS (AÑO 2017). CONSUME ENROFLOXACINA Y PREDNISOLONA POR TRAQUEOBRONQUITIS. POSIBLE INCONTINENCIA POR PREDNISOLONA. SI NO CORTA, SE SUGIERE ANALISIS SANGUINEO. PENSAR EN INCONTINENCIA POST CASTRACION.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('334','2017-11-11','63','92','2','PRURITO. PELO APELMAZADO. PREDNISOLONA.DERMIL. SE SUGIERE PIPETA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('335','2018-07-27','63','92','2','DOLOR ABDOMINAL-LUMBAR. GL.PERIANALES. SEGUIERO ECOGRAFIA. TRATO CON PREDNISOLONA. MEJORA. ALIMENTO MV GASTROINTESTINAL.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('336','2018-11-04','63','92','2','TRAQUEOBRONQUITIS. T°40. CLAMOXIL X 6 DIAS + PREDNISOLONA + DIPIRONA. COMIENZO CON CLAMOXIL INYECTABLE + TRIBITIC CON VIT+ DIPIRONA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('337','2018-11-05','10','11','3','VACUNAS QUINTUPLE Y ANTIRRABICA PROVIDEAN SERIE 043. SENASA 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('338','2018-11-05','10','13','3','PRIMER VACUNA TRIPLE + TOTAL FULL 0.990 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('339','2018-11-05','10','10','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('340','2018-11-05','10','11','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('341','2013-06-10','65','93','2','CASTRADA (OVARIECTOMIA). GOTEA SANGRE POR VULVA. DIAGNOSTICO POSIBLE: VAGINITIS - INFECCION RENAL - PIOMETRA. TRATAMIENTO: TRIBIOTIC - NOVALGINA 1/2 COMP C/ 12 HS. ENRROFLOXACINA 150 MG 1 COMP C/ 24HS X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('342','2013-07-15','65','93','2','DECAIMIENTO. T° 39.3. DOLOR EN ZONA ABDOMINAL. SE SOLICITA ECOGRAFIA. TRIBIOTIC + VIT. NOVALGINA 1/2 COMP C/ 12HS X 48HS. EN CASO DE VOMITO REDUCIR A MITAD DE DOSIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('343','2013-07-16','65','93','2','INFLAMACION Y ENGROSAMIENTO DE UNA PARTE DE LA VEJIGA. COMPATIBLE CON CISTITIS - EL RESTO DE LOS ORGANOS SE ENCUENTRAN NORMALES.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('344','2017-11-02','65','93','3','5° + QUISTE ENTREDIGITOS. PREDNISOLONA X 3 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('345','2018-11-05','65','94','2','CASTRADA. LESIONES POR MORDEDURA. PUNTOS. ENRRO X 10 DIAS + PREDNISOLONA X 5 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('346','2018-11-05','65','93','2','LESIONES POR PELEA. PUNTOS. ENRRO X 10 DIAS + PREDNISOLONA X 5 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('347','2016-12-16','66','95','4','APRAX 5.900. ANIKIL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('348','2017-01-14','66','95','3','VACUNAS QUINTUPLE Y ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('349','2017-03-23','66','95','4','ANIKIL. POSIBLE ATOPISMO. REGRESA EN 15 DIAS A CONTROL.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('350','2017-04-21','66','95','4','APRAX. 5.930 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('351','2017-08-26','66','95','4','APRAX. 6 KG + ANIKIL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('352','2017-12-27','66','95','4','APRAX 5.300 KG + PROTECH','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('353','2018-01-21','66','95','3','VACUNAS QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('354','2018-03-31','66','95','4','APRAX 6.080 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('355','2018-08-07','66','95','4','APRAX 6.100 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('356','2018-11-06','66','95','4','NEXGARD ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('357','2018-04-13','67','96','2','POSIBLE DISPLASIA 2° (PRESENTA PLACA). PREDNISOLONA 20MG C/12 X 5 DIAS, OSTEOCART PLUS 2 X DIA DURANTE 1 MES, DESPUES 1 X DIA, GELATINA SIN SABOR 2 VECES X SEMANA  Y 1//2 CASCARA DE HUEVO X SEMANA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('358','2018-04-24','67','96','2','VET.   VILLA DALCAR, CONTROL TRAUMATOLOGICO POR DOLOR ARTICULAR, 120MG RIMADIL/DIA X 10 DIAS. POLADIN 1 1/2 X DIA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('359','2018-05-28','67','96','2','CONTROL DE PESO 35KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('360','2018-11-07','67','96','2','REACCION ALERGICA EN ROSTRO. PIODERMIA EN FRENTE Y FLANCO. PREDNISOLONA 20MG 1/2 COMP C/12HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('361','2018-11-08','68','98','2','SIN VACUNAS NI ANTIPARASITARIOS. TRAQUEOBRONQUITIS. TRIBIOTIC + DEXA. PREDNISOLONA + ENRO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('362','2018-11-08','68','97','2','SIN VACUNAS NI ANTIPARASITARIOS. PELO IRSUTO. ALOPECIA. SEBORREA. KUALCOVIT B 1 ML X DIA X 60 DIAS. PREDNISOLONA POR 4 DIAS. BAÑO CON JABÓN BLANCO O SHAMPOO ANTISEBORREICO. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('363','2018-11-08','18','99','4','0.360 KG TOTAL FULL SUSP.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('364','2018-11-08','70','101','5','ACCIDENTE DE TRANSITO. HEMORRAGIA POR VIA ORAL. SHOCK. SE LE HIZO DEXA + COAGULANTE + SUERO. ALGEN X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('365','2018-11-08','69','100','2','SOPLO AUSCULTABLE. TOS CARDIACA. POSIBLE CARDIOMIOPATIA DILATADA. GINGIVITIS CRONICA. SOLICITO ELECTRO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('366','2018-11-08','49','65','7','3 IVERMECTINA. ATP (APRAX, PESO: 5KG) SE LO DEBEN ADMINISTRAR EL DIA 11/11/18.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('367','2018-11-08','49','66','7','3 IVERMECTINA. ATP (APRAX, PESO: 10.300KG) SE LO DEBEN ADMINISTRAR EL DIA 11/11/18.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('368','2018-11-09','31','35','2','COMIENZO CON DERM CAPS OMEGA 3 Y 6. 0.2 ML POR DIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('369','2017-02-01','72','103','3','1° DOSIS QUINTUPLE + ATP (APRAX) PESO: 2.600KG. T° NORMAL. CONSUME EUKANUBA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('370','2017-02-20','72','103','3','2° DOSIS QUINTUPLE + APRAX 4KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('371','2017-02-25','72','103','2','VOMITO. COMIO GRILLOS POSIBLEMENTE. AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('372','2017-03-16','72','103','3','3° DOSIS QUINTUPLE + APRAX, PESO: 6.400KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('373','2017-05-12','72','103','3','ATR. PESO: 14.960KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('374','2018-07-24','72','103','3','QUINTUPLE + ATR. OTITIS (PYODERM + PREDNISOLONA)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('375','2018-11-09','71','102','2','HERIDA POR PRETAL EN AREA AXILAR. SE LE ADMINISTRO TRIBIOTIC + DEXA.  ENRO 50MG C/24HS X 10 DIAS + PREDNISOLONA 10MG C/12HS POR 5 DIAS ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('376','2018-11-10','58','80','2','REACCION INFLAMATORIA EN ZONA DE PROYECCION DE GL. SALIVAL. PICADURA O CIALOCELE. TRIBIOTIC + DEXA. ENRO + PREDNISOLONA CADA 24 HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('377','2016-08-30','73','104','3','SEGUNDA VACUNA QUINTUPLE + BASKEN 0.970 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('378','2016-09-21','73','104','3','TERCER VACUNA QUINTUPLE + BASKEN 1.730 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('379','2016-11-21','73','104','3','VACUNA ANTIRRABICA. PERSO 4.070 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('380','2017-02-13','73','104','4','APRAX 5.850 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('381','2017-04-08','73','104','2','NAUSEAS, HIPERSALIVACION. GASTRINE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('382','2017-10-03','73','104','3','VACUNA QUINTUPLE + APRAX 5.530 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('383','2017-12-02','73','104','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('384','2018-05-05','73','104','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('385','2018-11-10','73','104','3','VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('386','2018-11-12','74','105','2','ATP TOTAL FULL 1.930 KG. VIENE CON 30 DIAS DE VIDA. REGRESA ENTRE LOS 10-15 DIAS A VACUNAR. POSIBLE PARVO EN DOMICILIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('387','2018-11-12','75','106','2','DESHIDRATACION, ICTERICIA, INFECCION RESPIRATORIA, CAQUEXIA. VIT + TRIBIOTIC+ DEXA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('388','2016-08-19','75','107','2','INFECCION RESPIRATORIA. TRIBIOTIC + DEXA+ VIT. AMOXI-CLAVULANICO 1/2 ML C/12 HS X 10.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('389','2018-05-12','75','107','2','infeccion respiratoria-ulceras orales. Herpes-sida. Tribiotic + dexa. amoxi-clavulanico 250 mg 1/4 c/ 12 hs x 12 dias. Prednisolona x 3 dias. Kualcovit b x 40 dias','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('390','2012-11-03','75','108','2','PESO 0.400 KG CON ALOPECIA MUY MARCADA EN PATA POSTERIOR IZQ. COMPATIBLE CON SARNA NOTOEDRICA Y GRAN CONTAMINACION CON PULGAS PULGAS. TRATAMIENTO: SE DESPARASITA (SE DEBE REPETIR A LOS 15 - 20 DIAS). SE COLOCA 0.2 ML TRIBIOTIC + 02. VIT. LIMPIEZA 1 - 2 VECES POR DIA CON PERVINOX, LUEGO CREMA 6A POR 30 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('391','2012-11-19','75','108','2','NO SE NOTA MEJORIA. ALOPECIA EN PATA, OREJA DERECHA Y COMIENZO EN OREJA IZQ. SE DA IVERMECTINA 1/8 DIVIDIDO EN 2 TOMAS SEPARADAS X 14 DIAS. STARVIT POR BOCA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('392','2018-11-13','51','68','2','INSUFICIENCIA HEPATICA. DERM CAPS 0.3 ML POR DIA + KUALCOHEPAT 1/4 C/12 HS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('393','2018-11-14','68','97','2','Traqueobronquitis. Tribiotic + dexa. Dipirona. enro x 10 dias','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('394','2018-11-14','20','23','4','NEXGARD + SHAMPOO ANTISEBORREICO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('395','2015-09-25','76','110','3','1° VACUNA QUINTUPLE SIN ATP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('396','2015-10-26','76','110','3','2° VACUNA QUINTUPLE + ATP (BASKEN PLUS)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('397','2016-03-17','76','110','2','PRIVAPROL + ENRRO 100 X 10 DIAS - 17KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('398','2018-04-17','76','110','2','PRIVAPROL + ENRRO 100 X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('399','2018-11-14','76','110','2','PRIVAPROL + ENRO 100MG X 10 DIAS. 20 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('400','2016-12-19','77','112','4','ENCONTRADA - ATP APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('401','2017-01-03','77','112','3','1° VACUNA QUINTUPLE + ATP (APRAX) PESO 2.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('402','2017-01-24','77','112','3','2° VACUNA QUINTUPLE + ATP APRAX 3.450KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('403','2017-02-14','77','112','3','3° VACUNA QUINTUPLE + ATP APRAX 4.850KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('404','2017-11-08','77','112','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('405','2018-11-14','77','112','3','5° + ATR + APRAX 15KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('406','2014-06-18','77','111','3','SE COLOCA VACUNA 5° (SEGUNDA DOSIS). IVERMECTINA 1 ML POR POSIBLE SARNA. RECUPERADA DE MOQUILLO. POSIBLE SECUELA: EPILEPSIA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('407','2014-06-25','77','111','2','IVERMECTINA ORAL POLVO- IVERVET (VETANCO). 9.900KG - 600MCG/KG/DIA ORAL - 6GR/DIA/3MESES','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('408','2014-07-02','77','111','2','1/4 FENOBARBITAL (CONTAL 60) C/24HS POR AHORA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('409','2014-09-01','77','111','2','MIDRIASIS - BORRACHERA. SE CORTA IVERMECTINA - PESO: 14.500KG. FENOBARBITAL 60MG 1/2 C/12HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('410','2014-11-07','77','111','2','PESO 20KG. A LA FECHA PRESENTA ZONAS ALOPESICAS DETRAS DE LAS OREJAS  (+ DERECHA). SE RECOMIENDA KUALCODERM 2 VECES POR DIA HASTA VER MEJORA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('411','2014-12-06','77','111','4','20.800KG ATP BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('412','2014-12-29','77','111','2','PRESENCIA DE PERIODOS PREICTALES. ALGUNAS CONVULSIONES. BRO-K 300 1/2 C/24HS X 1 SEMANA. LUEGO 1/2 C /48 X 20 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('413','2015-07-27','77','111','2','CONTAL 150MG 1/4 C/12HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('414','2015-08-25','77','111','2','PERSISTEN LAS CONVULCIONES. CONTAL 150MG 1/2 C/12HS X 10-15 DIAS Y SE SOLICITA ANALISIS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('415','2015-09-07','77','111','3','VACUNA 5° + BARREDOR. 23.550KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('416','2015-12-27','77','111','2','EXTRACCION DE SANGRE: FENOBARBITAL, ALT, AST, FA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('417','2016-08-29','77','111','2','FIEBRE 39.7°C. CONVULSIONES: CONTAL C/10HS (NO LLEGA A LAS 12). DIPIRONA + AMOXI 500 C/12 X 10 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('418','2016-10-17','77','111','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('419','2017-02-14','77','111','4','APRAX X 25KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('420','2017-11-08','77','111','3','5° + ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('421','2013-05-06','78','113','2','NORMALMENTE TIENE CELO CADA 6 MESES. EN ESTA OCASION OCURRIO CADA 4 MESES. EDEMA VULVAR EXAGERADO, COMIENZO PROTRUSION VULVAR (VULVA PARTIDA EN 4). LAMIDO VULVAR CONSTANTE GENERADO POR DOLOR. TRATAMIENTO: PREDNISOLONA 20MG 1/4 C/12HS X 13 DIAS CON LAS COMIDAS. SI NO REMITE: REPETIR TRATAMIENTO, TRANSOVULATORIO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('422','2015-12-04','78','113','2','DOLOR LUMBAR? PREDNISOLONA 1/4 C/12HS. INFLAMACION DE GLANDULAS PERIANALES. NUEVO CELO. POSIBLE PROLAPSO VULVAR? HIPERPLASIA ENDOMETRIAL?','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('423','2016-02-09','78','113','2','ZONAS ALOPESICAS EN LOMO (CIRCULARES). RASPADO: DERMAROFITOSIS. POSIBLE ALTERACION HORMONAL. CREMA 6A + PYODERM. DERMATOFITOSIS POR MICROSPORUM CANIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('424','2016-03-04','78','113','3','VACUNA 5° + ATR + ATP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('425','2016-11-29','78','113','2','CITOLOGIA VAGINA. ESTRO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('426','2017-01-27','78','113','4','APRAX 4KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('427','2017-02-02','78','113','2','PARCHE CALIENTE. PREDNISOLONA 10MG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('428','2017-03-08','78','113','3','VACUNA 5° + ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('429','2018-01-25','78','113','4','APRAX 4KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('430','2018-03-13','78','113','3','VACUNA 5° + ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('431','2018-11-14','78','113','2','SOLICITO ANALISIS DE SANGRE, POSIBLE CUSHING - HIPOTIROIDISMO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('432','2016-11-24','79','114','3','PRIMER VACUNA TRIPLE + ATP FENTEL SUSP. 1.430 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('433','2016-12-29','79','114','3','SEGUNDA VACUNA TRIPLE + BASKEN 1.900 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('434','2017-02-06','79','114','3','TERCER VACUNA TRIPLE + APRAX 2.400 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('435','2015-03-25','79','116','2','40 DIAS DE VIDA. COMPLEJO RESPIRATORIO. CONJUNTIVITIS MUCOPURULENTA. NO PRESENTA AFTAS ORALES. AMOXI+ VIT+COLIRIO+ ATP FENTEL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('436','2015-03-27','79','116','2','REFUERZO AMOXICILINA. SE TERMINA EL PLAN DE TRES DIAS CON FENTEL.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('437','2015-09-21','79','116','4','ATP BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('438','2017-02-06','79','116','3','VACUNA TRIPLE + APRAX 3.500 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('439','2018-11-16','20','23','7','REACCION . PREDNISOLONA 1/4 C/12 HS X 3 DIAS. ALIMENTO OLD PRINCE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('440','2015-09-21','79','115','4','ATP BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('441','2018-01-29','79','115','2','ECOGRAFIA UTERINA. CANCER MAMARIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('442','2018-11-16','79','115','2','DECAIMIENTO. MUCOSAS CONGESTIVAS-SEMI ICTERICAS. LECHE EN MAMAS-PUS. EDEMA MAMARIO. TRIBIOTIC+ DEXA + VIT. SOLICITO ANALISIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('443','2017-02-14','80','117','3','VACUNA QUINTUPLE + ANTIRRABICA + APRAX 7.400 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('444','2017-09-08','80','117','2','VOMITOS. DOLOR ABDOMINAL. COME PAPEL. GASTRINE + TRIBIOTIC + VIT. MANEJO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('445','2018-02-15','80','117','3','VACUNAS QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('446','2018-06-14','80','117','4','PIPETA ANIKIL + PREDNISOLONA X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('447','2018-11-16','80','117','4','PIPETA OSSPRET','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('448','2018-11-16','81','118','2','PARCHE CALIENTE EN CUELLO. CEFALEXINA 1000MG 1/2 COMPRIMIDO C/12HS DURANTE 10 DIAS. PREDNISOLONA 1/2 COMPRIMIDO C/12HS DURANTE 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('449','2018-11-16','81','118','2','PARCHE CALIENTE. SE LE ADMINISTRO TRIBIOTIC + DEXA. PYODERM X 10 DIAS + PREDNISOLONA X 4','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('450','2014-02-01','82','119','3','QUINTUPLE + ATP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('451','2015-12-19','82','119','4','ATP BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('452','2016-02-09','82','119','2','DERMIL (PRURITO GENERALIZADO) + PIPETA ANIKIL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('453','2016-04-02','82','119','3','QUINTUPLE + ATP APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('454','2016-05-13','82','119','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('455','2016-08-06','82','119','4','BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('456','2016-08-16','82','119','2','PRURITO INTENSO LUEGO DEL BAÑO - RECOMIENDO USAR SHAMPOO HIPOALERGENICO, ENJUAGAR BIEN - DERMIL 1/4 C/12HS - 1/4 C/24 - 1/4 C/48HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('457','2017-03-04','82','119','4','APRAX 5KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('458','2017-04-06','82','119','2','DOLOR LUMBAR (RENAL?) PREDNISOLONA 10MG 1/4 C/12HS X 4 DIAS. DIETA ARROZ BLANCO, POLLO Y ANQUITO POR 1 SEMANA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('459','2017-06-02','82','119','3','VACUNA QUINTUPLE. PESO: 6.110KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('460','2017-09-16','82','119','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('461','2017-11-10','82','119','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('462','2018-07-21','82','119','2','DECAIMIENTO - T° NORMAL - TRIBIOTIC + VIT','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('463','2018-11-17','82','119','3','ANTIRRABICA. LABORATORIO PROVIDEAN. N° SERIE: 043/25DS. N° SENASA: 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('464','2018-11-18','83','120','2','MORDEDURA. HERIDA PENETRANTE EN TORAX. HEMOTORAX. INTERNACION.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('465','2018-07-17','84','121','2','OTITIS. PREDNISOLONA. OTOVIER','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('466','2018-08-24','84','121','2','DERMATITIS POR PULGAS. PREDNISOLONA. APRAX. NEXGARD 10 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('467','2018-11-18','84','121','2','HERIDAS POR MORDEDURA. DEXA + TRIBIOTIC. PREDNISOLONA + ENROFLOXACINA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('468','2018-11-19','85','122','2','FUS.  SONDAJE URETRAL. ENROFLOXACINA+ PREDNISOLONA+ PROPANTELINA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('469','2018-11-19','79','115','2','LEUCOCITOSIS. ALT AUMENTADA. KUALCOHEPAT + ENRO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('470','2018-11-19','51','123','2','TRAQUEOBRONQUITIS. TRIBIOTIC + DEXA. ENRO + PREDNISOLONA X 6 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('471','2018-11-20','86','124','2','TOTAL FULL SUSP. 0.630 KG. REGRESA EN 1 SEMANA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('472','2018-11-20','87','125','2','REACCION ALERGICA EN DORSO-LOMO-NALGAS-VIENTRE-OJOS. PULGAS. ATOPIA. DERMIL 1/2 C/ 12 X 7- 1/2 C/24 X 7- 1/2 C/ 48 X 30. CONFORTIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('473','2018-11-20','68','97','2','BONQUITIS CRONICA. PREDNISOLONA 10MG 1/4 CADA 12 X 5 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('474','2018-11-20','88','127','3','1° VACUNA QUINTUPLE + APRAX (4KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('475','2018-11-20','88','126','3','VACUNA 5° + ATR + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('476','2018-11-20','41','51','2','HIPERTERMIA 40.2°C. VOMITOS. GASTRIN + TIBIOTIC + VIT. BAÑO. EXTRACCION DE SANGRE.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('477','2015-11-09','89','128','2','OBSTRUCCION URINARIA. COMIENZO CON PROPANTELINA + FIELOXACINA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('478','2016-12-13','89','128','4','APRAX 4.100KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('479','2017-07-25','89','128','4','APRAX 4.250KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('480','2018-04-27','89','128','3','ATR + APRAX 4.210KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('481','2018-11-21','89','128','4','APRAX 4.430KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('482','2018-11-22','18','99','4','0.620 KG. TOTAL FULL SUSP.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('483','2018-11-22','46','61','4','0.650 KG. TOTAL FULL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('484','2018-11-22','41','51','2','POSITIVO A HEMOBARTONELOSIS. NEGATIVO VIF Y VILEF. TRATAMIENTO: DOXICICLINA C/12 HS X 20 DIAS. COMFORTIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('485','2018-03-12','90','129','3','1° DOSIS QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('486','2018-04-06','90','129','3','2° DOSIS QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('487','2018-06-11','90','129','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('488','2018-11-23','90','129','2','DECAIMIENTO, POSIBLE GOLPE DE CALOR. PESO: 5.500KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('489','2016-08-02','91','130','3','1° DOSIS QUINTUPLE + ATP (APRAX, PESO: 12.250KG) TIENE UNA VACUNA CONTRA PARVOVIRUS COLOCADA EN OTRA VETE)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('490','2010-08-31','91','130','3','2° DOSIS QUINTUPLE + ATP (APRAX, PESO: 15,000KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('491','2018-09-22','91','130','3','3° DOSIS QUINTUPLE + ATP (APRAX, PESO: 16.000KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('492','2016-11-15','91','130','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('493','2017-09-30','91','130','3','QUINTUPLE + ATP (APRAX, PESO: 28KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('494','2017-11-15','91','130','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('495','2018-11-24','91','130','3','ATR. PROVIDEAN MULTIDOSIS SERIE 043. SENASA:134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('496','2018-05-04','90','129','3','TERCER VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('497','2018-11-26','93','132','4','350 GR. TOTAL FULL. SECRECION OCULAR GOTAS OFTALMICAS TOBRAMICINA + DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('498','2018-07-16','94','133','2','CONVULSIÓN AISLADA (C/6 MESES). NO SE MEDICA. CONTAL 60 1/4 C/12HS FRENTE A UNA NUEVA CONVULSIÓN.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('499','2018-07-30','94','133','2','CONVULSION 1/4 CONTAL 60 C/12 X 7DIAS - 1/4 C/24 (POR LA MAÑANA). SI PRESENTA A LA NOCHE EL CUARTO SERA 21HS O C/12HS NUEVAMENTE.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('500','2018-11-26','94','133','2','CONJUNTIVITIS ALERGICA, RINITIS, OTITIS Y TOS. PREDNISOLONA 10MG 1/4 C/12 X 4 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('501','2018-11-27','95','134','5','HIPOTERMIA 36.2. SEMICOMATOSA, DESHIDRATACION. EXTRACCION DE SANGRE. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('502','2017-09-09','96','135','2','6.100 KG. CONVULSIONES. CONTAL 1.5, COMIENZO CON 1 COMP. LUEGO 1/2 C/12 HS X 5 DIAS. LUEGO 1 COMP C/24HS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('503','2017-09-30','96','135','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('504','2018-06-12','96','135','3','QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('505','2018-11-27','96','135','2','TRAQUEOBRONQUITIS. TRIBIOTIC + DEXA. PREDNISOLONA 10 MG 1/2 C/12HS X 3 DIAS + ENRO 1 COMP X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('506','2018-11-27','25','28','8','6 ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('507','2018-11-12','97','136','3','1 VACUNA QUINTUPLE + ATP TOTAL FULL  1.700','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('508','2018-11-28','97','136','4','total full 2.200 kg. diarrea con un poco de sangre','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('509','2018-11-28','86','124','4','total full 0.930 kg','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('510','2017-01-24','98','137','3','1° VACUNA TRIPLE FELINA+ ATP(FENTEL SUSPENCION) PESO 1.610 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('511','2018-11-28','98','138','4','ANTIPARASITARIO  TOTAL FULL, PESO 0,610 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('512','2016-10-31','99','139','2','RECAIDA. COMIENZO CON PYODERM 35KG 1 1/4 C/12HS X 20 + ADVOCATE X 3 MESES. SI REAPARECE EQUALAM O BRAVECTO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('513','2015-05-07','99','140','2','INFLAMACION GL. PERIANALES. DOLOR DE CADERA Y LUMBAR. POSIBLE ARTROSIS. SOLICITO PLACA. PREDNISOLONA 20MG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('514','2015-07-17','99','140','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('515','2017-07-03','99','140','2','DEMENCIA SENIL. ARTROSIS. PREDNISOLONA 20MG 1/4 C/12 X 4 DIAS + KUALCOVIT B 1/2ML C/24 X 60 DIAS + GERIOX 1/2 C/24. MEJORAR ALIMENTACION.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('516','2017-04-01','99','141','2','ARTROSIS. PREDNISOLONA 20MG 1/2 C/12 X 4 DIAS + OVIMIN 1 CAPS/24HS DE POR VIDA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('517','2017-04-11','99','141','2','FIEBRE 40.3° C. PEQUEÑA HERIDA DE PIEL EN ZONA DORSO LUMBAR. TIBIOTIC + DEXA + DIPIRONA. NOVALGINA 1/4 C/8HS X 1 O 2 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('518','2018-02-27','99','141','2','ECOGRAFIA (HERNIA EN DORSAL DEL PENE). CONTENIDO TEJIDO GRASO. HAY DOLOR. PREDNISOLONA 20MG C/12HS. RECOMIENDO CIRUGIA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('519','2013-04-13','99','142','2','CEGUERA TOTAL GENETICA, SU MAMA TAMBIEN. HAY RETRO CRUZA. INFLAMACION DE VULVA, CASI AL BORDE DE LA PROTRUSION. DOLOR, POR CELO. NUNCA SE COLOCARON ANTICONCEPTIVOS. NO HAY RELACION CON LA CEGUERA. TRATAMIENTO: PIROXICAM 1/2 C/12HS X 1 DIA. LUEGO 1/2 C/24HS X 2 DIAS. SE SUGIERE CASTRACION.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('520','2014-06-30','99','142','2','DECAIMIENTO INFLAMACION DE GL. PERIANALES. VULVA CON ASPECTO DE MANGUERA. OVARIECTOMIA EN OTRA VETERINARIA EN ABRIL DE 2014. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('521','2015-01-06','99','142','2','DEMODICOSIS: PYODERM 1/4 C/12 X 20 + SHAMPOO CLORHEXIDINA + KETOCONAZOL 1/4 C/12HS + PIPETA ADVOCATE. 1°PIPETA 09/12/14','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('522','2015-02-09','99','142','2','SE REDUCE LA DOSIS DE KETOCONAZOL A 1/2 COMP C/48HS HASTA TERMINAR. SE VUELVE EL PRURITO SE CONTINUA CON LA MEDICACION.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('523','2015-07-17','99','142','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('524','2015-08-08','99','142','2','OJO DERECHO INFLAMADO CON DOLOR Y MOCO. NO HAY ULCERA (FLUORESCEINA NEGATIVA). SE COLOCA 1 GOTA DE TAU. CONTINUA CON SOFTAL C/8 HS X 4 DIAS. CARPROBAY 1/4 C/24 X 4 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('525','2015-11-12','99','142','2','PARCHE CALIENTE. DERMOCEF X 10 DIAS + COLLAR ISABELINO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('526','2016-10-06','99','142','2','BROTE DEMODEX + MALAZZEZZIA. ECUALAN 0.43ML C/24 X 3 MESES. BASKEN X 3 DIAS (DIPILIDIUM).','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('527','2017-08-17','99','142','2','REACTIVAVION POSIBLE DEMODEX EN PECHO Y PATA DELANTERA. DOLOR. PREDNISOLONA 20 1/4 C/12 X 3 DIAS. PERVINOX.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('528','2018-02-22','99','142','2','BICHERA EN LABIO. BRONQUITIS. RUMICLAMOX + DIPIRONA (40°C).','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('529','2018-06-12','99','142','2','BROTE DEMODEX. EQUALAN POR TIEMPO INDETERMINADO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('530','2018-09-10','99','142','2','SE CAE A LA PILETA. INCONCIENCIA. REANIMACION. DEXA + FURO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('531','2018-09-13','99','142','2','SE REALIZA ELECTROCARDIOGRAMA PORQUE LA PACIENTE SE ENCUENTRA CON JADEO CONSTANTE. SE SOLICITA PLACA DE TORAX: CANCER. TEST FLUORESCEINA (OI) + TAU.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('532','2018-09-19','99','142','2','PLACA DE TORAX: NEOPLASIA TORÁCICA CON POSIBLE CONTAMINACION MICOTICA. PREDNISOLONA ( X OJO IZQ). ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('533','2018-11-29','99','142','2','CAQUEXIA Y DIFICULTAD PARA CAMINAR. DAVITAN-C + POLADIN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('534','2018-11-30','100','143','3','PRIMER VACUNA QUINTUPLE + APRAX 4.090 KG. SIMPARICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('535','2018-11-30','101','144','3','1° DOSIS QUINTUPLE + ATP (TOTAL FULL) PESO: 1.190KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('536','2017-06-25','102','145','2','3 KG. GASTROENTERITIS. CERENIA+VIT+SOLUCION FISIOLOGICA SC. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('537','2017-10-03','102','145','3','4,140 KG. 2°VACUNA 5°+ APRAX.  ATR( MUNICIPALIDAD)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('538','2017-10-24','102','145','3','3° VACUNA 5° + APRAX  4KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('539','2018-11-30','102','145','3','ATR PROVIDEAN SERIE:043 SENASA: 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('540','2015-09-29','103','147','3','PUPPY DP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('541','2015-10-01','103','147','4','PESO: 2.400KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('542','2015-10-19','103','147','3','1° DOSIS QUINTUPLE + ATP (PESO: 4KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('543','2015-11-09','103','147','3','2° DOSIS QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('544','2017-03-15','103','147','3','QUINTUPLE + ATR + VACUNA CON BACTERINA BORDETELLA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('545','2018-05-14','103','147','3','QUINTUPLE + ATR (N° SERIE L446412, SENASA: 119089456M), EXTRACCION DE SANGRE PARA LEPTO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('546','2018-07-16','103','147','4','APRAX, PESO: 25KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('547','2017-12-12','103','146','2','OJO IZQUIERDO CON INFECCION POR ENTROPION. SE ESPERA EL CRECIMIENTO YA QUE TIENE 20 DIAS. TAU CON Y SIN ESTEROIDES X 10 DIAS INTERCALADOS. SOLUCION FISIOLOGICA X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('548','2017-12-18','103','146','2','FENTEL SUSPENCION, PESO: 1.090KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('549','2018-01-04','103','146','3','1° DOSIS QUINTUPLE + APRAX 5.310KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('550','2018-01-25','103','146','3','2° DOSIS QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('551','2018-02-09','103','146','3','3° DOSIS QUINTUPLE + APRAX (PES: 6.600KG)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('552','2018-02-17','103','146','2','HIPERTERMIA, DIPIRONA IM + TRIBIOTIC. AMOXI + CLAVULANICO X 7DIAS + DIPIRONA SUSP 1.5ML C/ 8-12HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('553','2018-03-07','103','146','2','ANALISIS DE SANGRE Y ECG PREQUIRUGICO (BLOQUE A-V  1° GRADO)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('554','2018-04-28','103','146','3','ATR + DOXICICLINA X 20 DIAS POR CONVIVENCIA DE SU MAMA CON LEPTO. PESO: 13.250KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('555','2018-07-16','103','146','2','CUADRO RESPIRATORIO- FIEBRE- ENRO + PREDNISOLONA + DIPIRONA. ANTECEDENTE: SE COMIO UNA MEDIA. POSIBLE ECO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('556','2018-12-01','103','146','2','DERMATITIS INFLAMATORIA, ALOPECIA. APRAX (PESO: 18KG) Y NEXGARD.  PREDNISOLONA 1/2 COMPRIMIDO C/12HS + KUALCOVIT B 2ML X DIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('557','2018-08-04','103','147','8','ANOVULATORIO 1ML','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('558','2017-10-07','104','149','2','FARINGITIS. T° NORMAL. DEXA + TRIBIOTIC + PREDNISOLONA 10MG 1/4 C/12 X 4DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('559','2018-01-19','105','151','2','CASTRADAS EL 14/11/17. DISBACTERIOSIS--> DIARREA. CAMBIO DE ALIMENTO AL EXCELLENT. FLORATIL O  YOGURT','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('560','2018-02-26','105','151','3','1° VACUNA TRIPLE + APRAX 2.600KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('561','2018-03-26','105','151','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('562','2018-03-26','105','150','3','ATR + TRIPLE FELINA. CRIPTORQUIDO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('563','2018-08-08','105','150','3','2° DOSIS TRIPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('564','2016-01-29','105','152','3','QUINTUPLE + APRAX (36KG). SE LE CAE MUCHO EL PELO Y TIENE LOS DIENTES MUY FEOS, POSIBLE AFECCION POR DESBALANCE MINERAL. SE RECOMIENDA SPRAY BUCAL, SINO MEJORA--> ODONTOBIOTIC','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('565','2017-02-14','105','152','4','APRAX PESO: 40KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('566','2018-12-01','103','147','4','APRAX + NEXGARD','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('567','2018-12-01','104','148','2','FUS. SE LE ADMINISTRO DEXA+ TRIBIOTIC + AA VIT. PREDNISOLONA + ENRO + PROPANTELINA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('568','2018-12-03','106','153','2','SOBREPESO 3,400 KG. DIETA+ EJERCICIO. QUEDA PENDIENTE ANÁLISIS DE SANGRE.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('569','2016-07-26','107','154','2','ATROPELLADO. DOLOR PATA TRASERA DERECHA. DEXA + PREDNISOLONA 20MG 1/2 C/12 X 2 DIAS + TRAMADOL 75 1/4 C/12 X 4 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('570','2016-07-27','107','154','2','VOMITOS. VIT + CERENIA. CORTAMOS PREDNISOLONA, CONTINUAMOS CON TRAMADOL.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('571','2016-08-12','107','154','4','BASKEN 20KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('572','2016-09-22','107','154','4','FRONTLINE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('573','2017-05-06','107','154','2','POSIBLE TRUMATISMO EN MIEMBRO POSTERIOR IZQ. HEMATOMA EN ZONA ABDOMINAL IZQ. DEXA + PREDNISOLONA 20MG 1/2 C/12 X 4 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('574','2017-05-23','107','154','3','VACUNA ANTIRRABICA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('575','2017-09-14','107','154','2','EXTRACCION QUIRURGICA DE VERRUGA EN CABEZA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('576','2017-12-11','107','154','2','DIARREA CON SANGRE - ENRRO + DEXA. AYUNO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('577','2018-08-08','107','154','2','DIARREA HEMORRAGICA. CERENIA + DEXA + VIT. AYUNO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('578','2018-12-03','107','154','2','OTITIS OIDO IZQ. LIMPIEZA + OTOVIER NF','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('579','2018-11-12','108','155','3','PRIMER VACUNA QUINTUPLE + TOTAL FULL ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('580','2018-12-04','108','155','3','SEGUNDA VAVUNA QUINTUPLE + APRAX 2.210 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('581','2018-12-03','109','156','3','1°VACUNA QUINTUPLE + APRAX 3KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('582','2018-12-04','49','65','7','4 DOSIS CON IVERMECTINA. SE DEMORA 20 DIAS. COMIENZO CON ODONTOBIOTIC 1/4 C/12 HS X 10 DIAS + ODONTOLIMPO CADA 24 HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('583','2017-08-18','110','157','2','DECAIMIENTO 40,5°C. INFECCIÓN RESPIRATORIA. TRIBIOTIC+ VIT+ SUERO SC. ENROFLOXACINA POR 10 DÍAS. HAY OBESIDAD 9,280 KG. GLUCOSA 145 (OJO). REQUIERE ANÁLISIS. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('584','2018-12-04','110','157','2','CUADRO ALÉRGICO RESPIRATORIO. TRIBIOTIC+ DEXA. PREDNISOLONA 2 DÍAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('585','2016-05-07','110','158','2','DERMATITIS POR PULGAS. FRONTLINE. DERMIL.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('586','2016-05-26','110','158','2','VOMITO. DIARREA. CERENIA+ VIT. AYUNO+ PROTECTOR HEPÁTICO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('587','2015-04-07','111','159','2','TRAQUEOBRONQUITIS INFECCIOSA CANINA. FIELOXACINA 1/2 COMPRIMIDO C/ 24 HS x 10 DÍAS  + PREDNISOLONA 1/4 COMPRIMIDO C/ 24 HS x 4 DÍAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('588','2015-10-13','111','159','2','VÓMITOS, DECAIMIENTO, HIPOTERMIA. CERENIA+VIT+PROTECTOR HEPÁTICO COMPRIMIDO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('589','2016-05-16','111','159','2','TRAQUEOBRONQUITIS INFECCIOSA. INYECTABLES.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('590','2016-08-21','111','159','2','ADENOMA PERIANAL. ENROFLOXACINA+ PREDNISOLONA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('591','2017-06-15','111','159','2','EMERGENCIA. POSIBLE GOLPE LUMBAR. CONVULSIÓN. DIAZEPAM. CONTAL.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('592','2017-06-16','111','159','2','PREDNISOLONA 10 MG. 1/4 COMPRIMIDO C/ 12 HS. POR 4 DÍAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('593','2017-06-30','111','159','2','ELECTRO CONTROL. BLOQUEO AURICULO- VENTRICULAR 1° GRADO. SE SUGIEREN NUEVOS ELECTROS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('594','2018-09-13','111','159','2','FISTULA PERIANAL. ENROFLOXACINA+ PREDNISOLONA. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('595','2018-12-05','111','159','2','DOLOR MUSCULAR.  PREDNISOLONA POR 4 DÍAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('596','2018-11-30','112','160','3','PRIMER VACUNA QUINTUPLE + TOTAL FULL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('597','2013-10-31','113','161','2','PIPETA FRONTLINE PLUS 4,750KG. SE DESPARASITA  CON BASKEN. SE COLOCA ATR.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('598','2015-03-27','113','161','2','MIEMBRO POSTERIOR IZQUIERDO. DOLOR EN ARTICULACIÓN FEMORO-TIBIO- ROTULIANA EN ARTICULACIÓN COXOFEMORAL. SE SOLICITA DOS PLACAS. VER: INTERIOR DEL FEMUR. TRAMADOL+ PREDNISOLONA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('599','2015-04-10','113','161','2','COMIENZO CON OVIMIN 1 C/ 24 HS. + MAGNETOTERAPIA. CAMBIO POR ARTROGLICAN 1 C/ 24 HS. ALIMENTO KEN-L CACHORRO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('600','2015-08-24','113','161','2','INFLAMACIÓN- INFECCIÓN AL COSTADO DEL ANO( POSIBLE GL. PERIANAL) PYODERM POR 10 DIAS + PREDNISOLONA POR DOS DÍAS. ATP APRAX 15,600 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('601','2015-09-11','113','161','3','REFUERZO VACUNA 5°+ ATR.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('602','2016-03-19','113','161','2','LIMPIEZA DE GLÁNDULAS. ATP BASKEN.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('603','2016-03-31','113','161','2','DRENAJE DE GLÁNDULAS PERIANALES.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('604','2016-10-03','113','161','3','5°+ ATR+ APRAX 15,500 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('605','2017-09-28','113','161','3','5°+ ATR+ APRAX 16 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('606','2018-12-05','113','161','3','5°+ APRAX + ATR SERIE: 043 SENASA: 134713073M PROVIDEAN MULTIDOSIS ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('607','2018-12-05','19','22','3','3° DOSIS QUINTUPLE +  ATP APRAX .','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('608','2018-12-06','20','23','7','COMIENZO CON PREDNISOLONA CADA 12 HS X 4-5 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('609','2018-12-06','46','61','4','0.850 KG TOTAL FULL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('610','2018-11-16','114','162','3','1° DOSIS QUINTUPLE+ FENTEL MAX SUSPENSIÓN 1,500 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('611','2018-12-06','114','162','3','2° DOSIS QUINTUPLE +  TOTAL FULL  1,810 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('612','2018-12-07','86','124','3','PRIMER VACUNA QUINTUPLE . COMIENZO CON KUALCOVIT B POR MICOSIS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('613','2018-12-07','115','163','2','PLAN SANITARIO VENCIDO HACE VARIOS AÑOS. GASTROENTERITIS HEMORRAGICA. CERENIA+TRIBIOTIC+VIT+DEXA. ENRO X 10 DIAS. DOLOR RENAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('614','2018-12-07','116','164','3','1° DOSIS QUINTUPLE + ATP APRAX 3,770 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('615','2015-12-18','117','166','3','VACUNA 5°+ ATP APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('616','2015-12-19','117','166','3','ATR.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('617','2016-03-05','117','166','4','ATP APRAX.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('618','2016-12-19','117','166','3','ATR.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('619','2017-01-02','117','166','3','VACUNA QUINTUPLE.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('620','2017-03-06','117','166','4','ATP APRAX. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('621','2017-12-20','117','166','3','QUINTUPLE + ATR.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('622','2018-09-05','117','166','4','ATP APRAX. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('623','2015-10-02','117','165','4','ATP+ PIPETA FRONTLINE PLUS 38 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('624','2016-03-05','117','165','3','5 °+ ATR + ATP APRAX. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('625','2016-03-15','117','165','2','TOS DE LAS PERRERAS. INYECTABLE + ENRO 200 MG POR 10 DÍAS + PREDNISOLONA 20 MG 1/2 COMPRIMIDO C/ 12 HS. POR 4 DÍAS. SI TIENE FIEBRE DIPIRONA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('626','2017-03-06','117','165','3','QUINTUPLE + ANTIRRABICA + APRAX. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('627','2018-03-07','117','165','3',' QUINTUPLE + ATR. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('628','2018-09-05','117','165','4','ATP APRAX. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('629','2018-12-08','117','165','2','EMERGENCIA POR ACCIDENTE DE TRANSITO. TRAMADOL + PREDNISOLONA. CONTROLAR DIAFRAGMA. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('630','2018-12-11','118','167','2','tos. dexa + tribiotic. prednisolona x 4 dias. Aprax. Simparica','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('631','2014-08-29','119','168','3','SEGUNDA IVERMECTINA + PRIMER VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('632','2015-09-29','119','168','7','BASKEN PLUS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('633','2015-11-30','119','168','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('634','2016-11-30','119','168','3','ANTIRRABICA + APRAX 40 KG. NO HACE VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('635','2017-12-06','119','168','3','ANTIRRABICA. NO HACE QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('636','2018-12-11','119','168','3','VACUNA ANTIRRABICA PROVIDEAN MULTIDOSIS. SERIE 043 SENASA 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('637','2017-10-23','120','169','2','ADENOMA PERIANAL. ENRO POR 20 DÍAS. PREDNISOLONA 10 MG. 1/2 COMPRIMIDO C/12 POR 4 DÍAS. PERVINOX. SUGIERO ISABELINO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('638','2018-12-11','120','169','2','MUCOSAS AMARILLENTAS. DOLOR RENAL A LA PALPACIÓN. INSUFICIENCIA  HEPÁTICA. DIFERENCIAL: LEPTOSPIROSIS. VIT+ TRIBIOTIC+ DEXA + HEPATOPROTECTOR. PROTECTOR HEPÁTICO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('639','2018-12-12','66','95','4','ATP APRAX 6KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('640','2016-12-23','121','170','2','SE TRAGO UN HUESO. AL CONTROL SE ENCUENTRA NORMAL. SE COLOCA VIT.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('641','2018-12-12','121','170','2','FUS. CISTOCENTESIS. PROPANTELINA + ENRO + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('642','2018-12-12','14','16','3','ANTIRRABICA. PROVIDEAN. SERIE 043 SENASA 134713073 M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('643','2016-09-22','82','171','3','1° VACUNA QUINTUPLE + APRAX 5.300KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('644','2016-10-14','82','171','3','2° VACUNA QUINTUPLE + APRAX 8.300KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('645','2016-11-04','82','171','3','3° VACUNA QUINTUPLE + APRAX 11.600 KG ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('646','2016-12-23','82','171','2','VOMITOS, T° NORMAL. CERENIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('647','2016-12-31','82','171','2','VOMITOS, DECAIMIENTO, T° NORMAL. GASTRIN + VIT','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('648','2017-03-04','82','171','4','APRAX 25KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('649','2017-09-16','82','171','4','APRAX 40 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('650','2018-04-06','82','171','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('651','2018-06-12','82','171','3','VACUNA 5°','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('652','2018-12-12','82','171','4','1° DIA BASKEN, 2° Y 3° DIA APRAX ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('653','2018-12-12','82','119','4','1° DIA BASKEN, 2° Y 3° DIA APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('654','2018-12-13','82','119','3','VACUNA  QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('655','2018-08-28','122','172','2','ANTECEDENTE: PIOMETRA. LLEGA A CONSULTA CON DOLOR RENAL, BRONCONEUMONIA, DESCARGA VULVAR PURULENTA (INFECCCION URINARIA?). ENRRO X 10 DIAS + PREDNISOLONA X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('656','2018-12-13','122','172','3','5° + APRAX 5.200 KG. NEXGARD','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('657','2018-12-14','41','53','4','ATP APRAX 30 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('658','2018-12-15','33','37','2','CAÍDA ABUNDANTE DE PELO. KUALCOVIT B POR 60 DÍAS + CEPILLADO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('659','2018-12-15','41','55','4','APRAX.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('660','2018-12-15','41','51','4','APRAX. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('661','2018-12-17','123','173','4','400 GR. TOTAL FULL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('662','2018-12-17','23','27','3','VACUNA QUINTUPLE. ELECTROCARDIOGRAMA + ANALISIS SANGUINEO PREQUIRURGICO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('663','2018-12-17','7','54','2','ELECTROCARDIOGRAMA PRE QUIRURGICO. NORMAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('664','2018-07-14','125','178','2','ARTROSIS SENIL. OVIMIN + RIMADIL INTERCALADO CON PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('665','2018-12-18','125','178','2','ANALISIS DE SANGRE. INCONTINENCIA URINARIA. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('666','2018-09-25','125','177','2','GASTROENTERITIS. GASTRINE + DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('667','2017-03-16','125','176','2','HONGOS Y SARNA. LOS HERMANITOS ESTAN CURSANDO CON UN COMPLEJO RESPIRATORIO. BASKEN SUSPENCION 0.870 KG. KETOCONAZOL 1/8 C/24 HS X 30 DIAS. PROTECTOR HEPATICO 1/2 COMP X DIA + KUALCOVIT B 0.5 ML X DIA. SI NO MEJORA SE COMIENZA CON SISTEMA ENDECTOCIDA.
','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('668','2017-03-30','125','176','4','0.960 KG BASKEN PLUS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('669','2017-05-06','125','176','3','1° DOSIS TRIPLE + ATP BASKEN 1.550 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('670','2017-06-05','125','176','3','2° DOSIS TRIPLE + ATP BASKEN 1.950 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('671','2017-07-03','125','176','3','3° DOSIS TRIPLE + ATP 2.570 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('672','2017-09-04','125','176','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('673','2018-09-15','125','176','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('674','2018-09-15','125','176','3','ATR','0');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('675','2018-12-18','67','96','2','ZONAS ALOPESICAS EN DIFERENTES PARTES DEL CUERPO COMPATIBLE CON REACCION ALERGICA ESTACIONAL CONTAMINADA CON POSIBLE MICOSIS. PRURITO. DEXA + DERMIL 1/2 C 12HS X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('676','2018-04-14','125','175','3','1° VACUNA QUINTUPLE. FRACTURA BILATERAL FEMUR.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('677','2018-05-05','125','175','3','2° VACUNA QUINTUPLE + APRAX 4.200KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('678','2018-05-26','125','175','3','3° VACUNA QUINTUPLE + APRAX 5.350KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('679','2018-06-30','125','175','3','ATR (PROVIDEAN S: 082 S: 130661802 M)','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('680','2018-12-19','125','176','8','prueba','0');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('681','2018-12-19','126','179','3','PRIMER VACUNA + APRAX COMP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('682','2018-12-19','88','127','3','SEGUNDA VACUNA QUINTUPLE + APRAX 5.430','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('683','2018-12-19','128','181','2','TRAQUEOBRONQUITIS. TRIBIOTIC + DEXA. ENRO + PREDNISOLONA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('684','2018-12-19','99','139','2','GASTROENTERITIS HEMORRAGICA. CERENIA + DEXA + VIT + TRIBIOTIC. CONSUMO DE HUESOS Y PLANTAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('685','2018-04-09','129','182','3','VACUNA 5°','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('686','2018-04-26','129','182','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('687','2018-09-26','129','182','2','NERVIOSISMO POR DRAMAS FAMILIARES. GL. TAPADAS. TOS. CONTAL 15 1/4 C/12 X 1 - 1/4 C/24 X 2 - 1/4 C/48. PREDNISOLONA 10 MG 1/4 C/12 X 4. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('688','2018-12-19','129','182','2','GL. TAPADAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('689','2018-12-19','23','27','7','COMIENZO CON CLINDAMICINA CADA 12 HS DURANTE 20 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('690','2018-05-22','130','183','3','5° + ATR + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('691','2018-05-30','130','183','2','CONJUNTIVITIS INFECCIOSA. TAU SIN ESTEROIDES','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('692','2018-10-03','130','183','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('693','2018-12-19','118','167','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('694','2018-12-20','117','166','3','VACUNAS QUINTUPLE Y ANTIRRABICA ( PROVIDEAN MULTID. S 043 S 134713073M)+ APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('695','2018-12-20','117','165','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('696','2018-12-20','7','54','6','LIMPIEZA DENTARIA CON EXTRACCIÓN DE PIEZAS. ODONTOBIOTIC 1/4 COMPRIMIDO CADA 24 HS + PREDNISOLONA 1/4 COMPRIMIDO CADA 12 HS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('697','2015-11-06','131','184','2','CONTROL. DESPARASITA CON APRAX 22 KG. SE RECOMIENDA MEJORAR LA ALIMENTACIÓN.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('698','2016-01-08','131','184','2','ATOPIA+ PIODERMIA. POSIBLE MICOSIS. ENRO+ DERMIL. CONTROL 10 DÍAS PARA VER SI DESAPARECIERON LOS HONGOS. POSIBLE KETOCONAZOL. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('699','2016-03-31','131','184','2','DERMIL 1/2 COMPRIMIDO CADA 12 POR 2 DÍAS- -1/4 C/ 12 HS. POR 4 DÍAS-- 1/4 C/ 24 HS. POR 4 DÍAS-- 1/4 C/ 24 HS. CUANDO SE CORTA REGRESA PRURITO Y ALOPECIA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('700','2017-05-29','131','184','2','TOS. ANTECEDENTES : CONSUMO DE POLLO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('701','2017-11-02','131','184','2','TOS DE LAS PERRERAS. AMOXI+ DEXA. ENRO POR 10 DÍAS + PREDNISOLONA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('702','2018-12-20','131','184','2','39,8 ° C. TOS, REFLEJO TUSIGENO POSITIVO.  DECAÍDO. POSIBLE ALERGIA.  DIPIRONA + DEXA + TRIBIOTIC. DIPIRONA. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('703','2018-12-21','45','60','3','2° DOSIS VACUNA TRIPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('704','2016-10-03','132','187','2','ALERGIA. PICADURA PULGAS. PREDNISOLONA 10 MG. 1/4 COMPRIMIDO C/12 POR 2 DÍAS-- 1/4 COMPRIMIDO C/ 24 HS. POR 3 DÍAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('705','2016-10-27','132','187','2','HERIDA POR VIDRIO EN MANO. SUTURA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('706','2017-01-09','132','187','4','APRAX 10 KG PV. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('707','2012-10-06','132','185','2','PIODERMIA EN LOMO Y MUSLO DERECHO. PERVINOX + 6A. OTITIS : SE REALIZA LIMPIEZA CON OTOVIER Y SE COLOCAN GOTAS DE OTOVIER NF 5-7 GOTAS C/ 12 HS. POR 3 DÍAS. LUEGO C/24 HS. POR 5 DÍAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('708','2015-03-31','132','185','2','DOLOR COXOFEMORAL. PREDNISOLONA 20 MG. 1 COMPRIMIDO C/ 12 HS. POR 3 DÍAS. LUEGO 1/2 COMPRIMIDO C/12 HS. POR 4 DÍAS. MANTENIMIENTO  1/2 COMPRIMIDO C/ 48 HS. POR 2 SEMANAS. POLADIN 30 1/2 COMP C/ 24 HS. CAMBIO DE ANTIARTROSICO. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('709','2016-07-04','132','185','2','ANTIATROSICO: FORMULA ANTIARTROSICA. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('710','2017-01-09','132','185','4','APRAX 15 KG. PV ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('711','2016-12-10','132','186','4','ATP SUSPENSIÓN. 400 GS PV','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('712','2016-12-26','132','186','4','570 GS PV. ATP FENTEL SUSPENSIÓN.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('713','2017-01-09','132','186','4','950 GS PV. FENTEL.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('714','2017-01-26','132','186','4','1, 360 KG. BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('715','2017-02-20','132','186','3','1,850 KG. 1° VACUNA TRIPLE.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('716','2017-03-21','132','186','3','2,210 KG. 2° VACUNA TRIPLE.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('717','2017-05-02','132','186','3','2, 520 KG. 3° VACUNA TRIPLE.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('718','2018-04-13','132','186','2','HERIDA PÓR MORDEDURA EN CUELLO. TRIBIOTIC+ DEXA. ENROFLOXACINA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('719','2018-12-21','100','143','3','SEGUNDA VACUNA QUINTUPLE + APRAX 3.530 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('720','2018-12-21','132','187','2','ABCSESO PERIAPICAL. CLAVAMOX 1/2 CADA 12 X 8 + PREDNISOLONA X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('721','2018-12-21','108','155','3','TERCER VACUNA QUINTUPLE + APRAX 2.800 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('722','2015-03-28','133','188','3','VACUNA ANTIRRÁBICA + ATP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('723','2015-07-07','133','188','2','POSIBLE BRONQUITIS. TRIBIOTIC+ S.R.E. DERMIL x 2 DIAS ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('724','2018-12-21','133','188','2','POSIBLE BRONQUITIS. TRIBIOTIC+ S.R.E. DERMIL x 2 DIAS ','0');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('725','2018-12-21','133','188','2','POSIBLE BRONQUITIS. TRIBIOTIC+ S.R.E. DERMIL x 2 DIAS ','0');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('726','2015-11-30','133','188','3','VACUNA QUINTUPLE+ ATP BASKEN. CELO C/ 5 MESES','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('727','2016-01-22','133','188','2','CONJUNTIVITIS LEVE EN OJO DERECHO. TE x 3 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('728','2016-02-19','133','188','2','LESION INTERDIGITAL POR ALERGIA x CONTACTO. REACCION EN VIENTRE. PERVINOX + PREDNISOLONA. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('729','2016-03-24','133','188','2','ATOPIA. S.R.E.+ DEXA. 1/2 COMP C/ 12 HS POR 3 DÍAS- 1/4 COMP C/ 12 HS POR 3 DÍAS- 1/4 COMP C/ 24 HS POR 5 DÍAS- 1/4 COMP C/ 48 HS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('730','2016-03-30','133','188','3','ANTIRRÁBICA ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('731','2016-07-14','133','188','2','PSEUDOPREÑEZ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('732','2016-10-13','133','188','2','SEBORREA. SHAMPOO ANTISEBORREICO. PRURITO= PREDNISOLONA 1/4 C/ 12 x 4.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('733','2016-11-09','133','188','2','VOMITO- DIARREA- T° NORMAL. CERENIA+ VIT+ TRIBIOTIC- AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('734','2016-12-01','133','188','3','VACUNA QUINTUPLE.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('735','2017-03-14','133','188','2','DERMATOPHITOSIS EN HOCICO. APRAX x 14 KG. 6A+ PERVINOX+ S.R.E.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('736','2017-03-30','133','188','3','ANTIRRABICA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('737','2017-05-03','133','188','2','PRURITO. PIPETA PROTECH+ DERMIL.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('738','2017-05-20','133','188','2','PSEUDOPREÑEZ. MANEJO. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('739','2017-07-27','133','188','2','EPIFORA- RINITIS. PREDNISOLONA 10 MG 1/2 COMP C/ 12 x 3.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('740','2018-12-21','101','144','3','2° DOSIS VACUNA QUINTUPLE + APRAX 2 KG PV. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('741','2017-11-22','133','188','3','QUINTUPLE+ ATP+ FRONLINE. SECRECIÓN LÁCTEA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('742','2018-03-23','133','188','3','ANTIRRABICA. ODONTOBIOTIC','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('743','2018-04-26','133','188','2','VOMITO- GASTRITIS. GASTRINE+ DEXA. RANITIDINA 500 1/4 C/ 24 HS. (ANTES DE LA COMIDA).','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('744','2018-12-21','133','188','3','QUINTUPLE. PREDNISOLONA (OTITIS).','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('745','2017-01-25','134','189','3','VACUNA QUINTUPLE+ VACUNA ANTIRRABICA+ ATP (APRAX). PESO: 29,900 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('746','2017-04-17','134','189','2','DESPRENDIMIENTO DE UÑA PATA DERECHA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('747','2018-01-04','134','189','3','VACUNA QUINTUPLE+ ATP+ ATP APRAX PESO: 32 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('748','2018-12-21','134','189','3','VACUNA QUINTUPLE+ ATR (PROVIDEAN S: 043 S: 134713073M) + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('749','2018-12-22','20','23','4','NEXGARD 2-4 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('750','2018-12-22','125','178','2','COMIENZA A CONSUMIR DERM CAPS, UNA CUCHARADA POR DÍA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('751','2018-12-22','51','68','2','ENRO 50 MG. + PREDNISOLONA 10 MG. ESTADO ALÉRGICO CON AFECCIÓN RESPIRATORIA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('752','2018-12-22','135','190','3','SEGUNDA VACUNA QUINTUPLE + APRAX 5.030','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('753','2018-12-24','137','194','2','DERIVADO DE SEBASTIAN MAZZANTTI. TRAQUEOBRONQUITIS. TRIBIOTIC + DEXA . ENRO X 8 + PREDNISOLONA X 2','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('754','2018-12-22','136','192','3','SEGUNDA VACUNA QUINTUPLE + APRAX 3.280 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('755','2018-12-22','136','193','3','SEGUNDA VACUNA QUINTUPLE + APRAX 3.360 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('756','2017-04-03','136','191','3','PRIMER VACUNA QUINTUPLE + BASKEN 1.150 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('757','2017-04-24','136','191','3','SEGUNDA VACUNA QUINTUPLE + BASKEN 1.440 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('758','2017-05-16','136','191','3','TERCER VACUNA QUINTUPLE + BASKEN 1.610 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('759','2017-09-12','136','191','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('760','2018-09-12','136','191','2','ECOGRAFIA GESTACIONAL. FECHA PARTO PROMEDIO 28/09. RANGO DE ESPERA 22-09 AL 02-10','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('761','2018-12-22','136','191','4','APRAX 6 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('762','2018-12-26','138','195','2','MICOSIS EN PECHO. CREMA 6 A + KAUCOVIT B 1 ML X 60 DIAS + APRAX. NO TIENE VACUNAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('763','2018-12-27','140','198','2','GINGIVITIS, ULCERA DE CORNEA,PIODERMIA ESCROTAL. FLUORESCEIDA POSITIVA. PULGAS. PYO DERM X 20 DIAS + PREDNISOLONA X 4 DIAS. CORULETS CADA 8 HS. CONTROL EN 5 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('764','2018-12-26','139','196','2','GASTROENTERITIS. T NORMAL. CERENIA + VIT. AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('765','2018-12-26','139','197','2','GASTROENTERITIS. NO SE PUEDE DESPARASITAR. CERENIA + VIT. AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('766','2018-12-27','105','199','2','CONVULSIONES. HIPOTERMIA. SE APLICA SUERO ENDOVENOSO+ DEXA+ TRIBIOTIC + VIT.  CONTAL 60 1/2 CADA 12 X 4 LUEGO 1/4 CADA 12. SI EMPEORA 1 CADA 12','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('767','2018-12-27','141','200','2','HERIDA  EN PATA POR POSIBLE CUADRO DE ALERGIA POR CONTACTO. PYO DERM + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('768','2018-12-27','142','201','3','PRIMER VACUNA TRIPLE + TOTAL FULL 1.110 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('769','2018-12-28','144','203','3','PRIMER VACUNA QUINTUPLE + APRAX  3.780 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('770','2018-12-28','144','204','3','PRIMER VACUNA QUINTUPLE + APRAX 4.310 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('771','2018-12-28','86','124','3','SEGUNDA VACUNA QUINTUPLE + APRAX 2.460 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('772','2017-08-09','143','202','3','PRIMER VACUNA QUINTUPLE + FENTEL SUSP. 1 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('773','2017-08-30','143','202','3','SEGUNDA VACUNA QUINTUPLE + APRAX SUSP 1.400 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('774','2017-09-18','143','202','3','TERCER VACUNA QUINTUPLE + APRAX SUSP. 1.670 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('775','2017-12-26','143','202','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('776','2018-09-27','143','202','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('777','2017-11-25','144','205','2','HEMATOMA EN CUELLO POR MORDIDA. PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('778','2017-12-01','144','205','3','VACUNAS QUINTUPLE + APRAX 14 KG. SE LE TRABA LARODILLA IZQUIERDA. POLADIN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('779','2018-04-14','144','205','4','PROTECH. ALERGIA POR PULGAS EN LOMO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('780','2018-12-28','144','205','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('781','2018-02-26','144','206','3','PRIMER VACUNA QUINTUPLE + APRAX 4.470 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('782','2018-03-21','144','206','3','SEGUNDA VACUNA QUINTUPLE ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('783','2018-12-28','144','206','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('784','2018-02-26','144','207','3','PRIMER VACUNA QUINTUPLE + ANTIRRABICA + APRAX 8.640 KG. PLAN DE DOS DOSIS. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('785','2018-03-21','144','207','3','SEGUNDA Y ULTIMA VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('786','2018-12-28','144','207','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('787','2015-12-01','145','208','3','SEGUNDA VACUNA QUINTUPLE + APRAX 14.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('788','2015-12-22','145','208','3','TERCER VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('789','2015-12-29','145','208','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('790','2016-12-26','145','208','3','VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('791','2017-01-02','145','208','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('792','2017-12-28','145','208','3','VACUNA QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('793','2018-12-28','145','208','3','VACUNA QUINTUPLE + ANTIRRABICA PROVIDEAN S 043 S 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('794','2014-08-23','146','209','2','ORINA CON SANGRE. ECOGRAFIA: RIÑON CON FOCOS DE CALCIFICACION. LITIASIS URETRAL. ALIMENTO RENAL X 1 SEMANA, LUEGO URINARY','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('795','2014-10-02','146','209','2','OTITIS.LIMPIEZA. OTOVIER NF. CONTROL DE PESO 5.030 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('796','2014-11-20','146','209','2','REACCION ANAFILACTICA POR PICADURA. DEXA. APRAX 5.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('797','2015-03-21','146','209','2','PRESENCIA DE CALCULO EN VEJIGA DE 1 CM. INFLAMACION.LITIASIS RENAL.PREDNISOLONA X 10 DIAS ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('798','2015-04-02','146','209','2','CRISTALES DE OXALATO DE CALCIO. RESTRICCION DE AGUA MINERAL. ATB + PREDNISOLONA. TIENE PREDISPOSICION ENETICA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('799','2015-06-24','146','209','2','INFLAMACION PERIANAL. DRENAJE DE GL. PEDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('800','2015-12-05','146','209','2','REACCION ANAFILACTICA. DEXA + DIFENILHIDRAMINA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('801','2016-08-06','146','209','2','VACIADO DE GLANDULAS PERIANALES. DIFICULTAD MICCION, PROPANTELINA + FIELOXACINA + TRIBIOTIC','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('802','2016-08-23','146','209','3','VACUNAS QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('803','2016-10-24','146','209','2','VOMITOS.GLANDULAS PERIANALES CON GRAN CONTENIDO. BASKEN 3.870 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('804','2016-10-30','146','209','2','GASTROENTERITIS. CERENIA + VIT ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('805','2017-09-16','146','209','3','VACUNAS QUINTUPLE + ANTIRRABICA + APRAX 4.030 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('806','2018-07-27','146','209','4','APRAX 4.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('807','2018-09-21','146','209','3','VACUNAS QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('808','2018-12-28','114','162','3','TERCER VACUNA QUINTUPLE + APRAX 2.250 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('809','2018-12-29','144','205','3','VACUNA QUINTUPLE + PREDNISOLONA X ALERGIA POR PULGAS + OSSPRET','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('810','2018-12-31','147','211','2','PARCHE CALIENTE X PULGAS. PYO DER + PREDNISOLONA. SIMPARICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('811','2012-11-01','148','212','2','ULCERA EN CORNEA. CIPROVET 1 GOTA CADA 12 HS, EN OJO IZQUIERDO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('812','2015-06-19','148','212','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('813','2018-12-29','148','212','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('814','2018-12-31','56','76','2','REACCION ALERGICA. DEXA + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('815','2018-12-31','149','213','2','SECTORES ALOPECICOS COMPATIBLES CON MICOSIS. RECUPERANDESE. APRAX. TONIPET 1/4 CADA 24 HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('816','2018-12-31','150','214','2','TRAQUEOBRONQUITIS. TRIBIOTIC + DEXA. ENRO + PREDNISOLONA. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('817','2015-11-30','152','216','2','PRURITO INTENSO. OBESIDAD. SEBORREA. DERMIL 1/4 CADA 12 X 4 - 1/4 CADA 24 X 4 - 1/4 CADA 48 + SHAMPOO ANTISEBORREICO UNA VEZ POR SEMANA X  2 MESES','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('818','2016-04-04','152','216','2','DERMIL NUEVAMENTE. COMIENZO CON NEXGARD.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('819','2017-12-11','152','216','2','POSIBLE GOLPE EN MIEMBRO POSTERIOR IZQUIERDO. PREDNISOLONA 20 1/4 CADA 12','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('820','2018-04-28','152','216','2','TRAQUEOBRONQUITIS. ABESIDAD. SOLICITO ANALISIS SANGUINEO. RUMICLAMOX + PREDNISOLONA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('821','2018-12-21','152','216','2','ELECTROCARDIOGRAMA. CORAZON DESPLAZADO, CON SIGNOS DE AGRANDAMIENTO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('822','2019-01-02','152','216','2','HERIDA EN PABELLON AURICULAR. SUTURA. ACOGRAFIA ABDOMINAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('823','2017-02-07','154','219','3','VACUNAS QUINTUPLE + ANTIRRABICA + APRAX 28 KG. ANIKIL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('824','2017-09-04','154','219','4','APRAX 25 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('825','2018-02-23','154','219','3','VACUNAS QUINTUPLE+ ANTIRRABICA + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('826','2018-09-05','154','219','4','APRAX 30 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('827','2019-01-02','154','219','2','QUELOIDE EN PUNTA DE COLA. VENDAJE. POSIBLE AMPUTACION','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('828','2017-02-07','154','220','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('829','2017-09-04','154','220','3','ANTIRRABICA + APRAX 7.550 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('830','2018-02-23','154','220','3','VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('831','2018-09-05','154','220','3','ANTIRRABICA + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('832','2018-02-06','153','217','2','CONTROL GENERAL + APRAX 5.600 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('833','2018-02-14','153','217','3','PRIMER VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('834','2018-03-17','153','217','3','SEGUNDA VACUNA QUINTUPLE. PLAN DE DOS DOSIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('835','2018-04-05','153','217','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('836','2018-07-03','153','217','2','DERMATITIS. PIPETA + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('837','2019-01-02','153','217','2','DRENAJE DE GLANDULAS + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('838','2019-01-03','155','221','2','DERIVADO DE CLAUDIA CANDELERO. GASTROENTERITIS HEMORRAGICA. VOMITOS HIPERTERMIA. GRAN CANTIDAD DE PARASITOS. POSIBLE PARVO. NO POSEE VACUNAS. SUERO SC + CERENIA + VIT + DEXA + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('839','2019-01-03','156','222','2','DRENAJE DE GLANDULAS PERIANALES. DIARREA. APRAX ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('840','2018-12-07','124','174','2','PIODERMIA EN VENTRAL. REACCION ALERGICA EN SECTORES VENTRALES. PREDNISOLONA + ENRO X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('841','2019-01-03','124','174','2','PIODERMIA PROFUNDA VENTRAL. ALOPECIA. APRAX. CAMBIO DE DIETA A OLD PRINCE. PERVINOX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('842','2018-11-12','157','224','3','PRIMER VACUNA QUINTUPLE + TOTAL FULL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('843','2018-12-06','157','224','3','SEGUNDA VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('844','2019-01-03','157','224','3','TERCER VACUNA QUINTUPLE + APRAX 3.040 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('845','2018-03-10','157','223','2','ALOPECIA+ PRURITO. DERMIL 1/4 CADA 12 X 4 - CADA 24 X 7 - CADA 48 A 72 HS. POSIBLE RASPADO SI NO MEJORA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('846','2018-01-18','157','225','3','SEGUNDA VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('847','2018-02-08','157','225','3','TERCER VACUNA QUINTUPLE + APRAX 3.590. KUALCOVIT B + PREDNISOLONA 10 MG 1/4 CADA 12 HS X 5 DIAS. ALERGIA + HONGOS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('848','2013-05-21','153','218','2','REACCION ALERGICA-CEBORREA-PIODERMIA. COME RESTOS DE COMIDA-BAÑO CON JABÓN BLANCO + SHAMPOO ANTISEBORREICO. CAMBIO DE DIETA A KEN-L ADULTO. DERMIL ATP BASKEN.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('849','2013-06-15','153','218','2','SARNA. RASPADO. IVERMECTINA + TRIBIOTIC.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('850','2013-07-29','153','218','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('851','2014-07-30','153','218','3','VACUNA QUINTUPLE + ATP + PIPETA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('852','2014-09-01','153','218','3','ANTIRRABICA. MORDIDA EN MIEMBRO POSTERIOR-INGLE.DIFICULTAD PARA CAMINAR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('853','2015-07-30','153','218','3','VACUNA QUINTUPLE + ATP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('854','2015-09-01','153','218','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('855','2016-08-23','153','218','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('856','2016-10-14','153','218','2','ARTROSIS EN RODILLA IZQUIERDA-OVIMIN. APRAX. PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('857','2017-05-20','153','218','2','PRURITO-ALOPECIA EN COLA. DEXA- PREDNISOLONA. PROTECH','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('858','2017-10-30','153','218','3','VACUNA QUINTUPLE + BARREDOR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('859','2018-05-19','153','218','3','ANTIRRABICA. PIPETA. APRAX. PIODERMIA POR PULGAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('860','2018-10-02','153','218','3','VACUNA QUINTUPLE + APRAX + PIPETA. COMIENZO CON POLADIN 15 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('861','2018-11-12','153','218','2','TRAQUEOBRONQUITIS. DEXA + TRIBIOTIC. PREDNISOLONA + ENRO 100 MG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('862','2016-01-20','151','215','5','GASTROENTERITIS HEMORRAGICA-VOMITOS-FIEBRE-INTERNACION','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('863','2016-02-01','151','215','4','COMIENZO CON FENTEL MAX X TRES DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('864','2016-02-23','151','215','3','TERCER VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('865','2016-05-13','151','215','2','DEMODEX EN HOCICO Y CUELLO. RASPADO POSITIVO. COMIENZO CON EQUUALAM 2.3 ML X DIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('866','2016-07-08','151','215','2','REAJUSTE DOSIS AQUUALAM 2.6 ML. PESO 25.500 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('867','2016-11-29','151','215','4','APRAX 30 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('868','2016-12-17','151','215','3','VACUNA ANTIRRABICA + PIPETA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('869','2016-12-23','151','215','2','REACCION ANAFILACTICA X PICADURA DE INSECTO-DEXA + DIFENILHIDRAMINA. DECAIMIENTO CON HIPERTERMIA. DIPIRONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('870','2017-12-19','151','215','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('871','2018-12-22','151','215','3','ANTIRRABICA PROVIDEAN. SERIE 043 S 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('872','2017-01-25','158','227','4','FENTEL X 3 DIAS. 4.160 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('873','2017-02-07','158','227','2','T NORMAL.VOMITOS. DIARREA SANGUINOLENTA. TRAQUEOBRONQUITIS. FIELOXACINA X 10 DIAS + PREDNISOLONA X 3 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('874','2018-03-17','158','227','2','CUADRO RESPIRATORIO. ENRO + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('875','2016-03-14','158','226','2','PARCHE CALIENTE EN LOMO. POSIBLE QUISTE O NEOPLASIA DE PIEL. KUALCODERM','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('876','2017-01-01','158','226','2','GASTROENTERITIS POR CONSUMO DE LECHON. CERENIA + VIT + DEXA + GASTRINE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('877','2017-01-12','158','226','2','RANITIDINA + PROTECTOR HEPATICO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('878','2017-01-25','158','226','4','MATERIA FECAL CON SANGRE. TRATAMIENTO COCCIDIAS. FENTEL X TRES DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('879','2017-02-07','158','226','2','GASTROENTERITIS. T NORMAL. TRAQUEOBRONQUITIS. FIELOXACINA + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('880','2019-01-03','158','226','2','GASTROENTERITIS. CERENIA + VIT + DEXA + AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('881','2019-01-04','99','142','2','BROTE DE DEMODEX EN PATAS Y HOCICO. COMIENZO CON PYO DERM X 2O DIAS MINIMO + DORAMECTINA 0.25 ML POR SEMANA DURANTE UN MES Y MEDIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('882','2019-01-04','159','228','3','CACUNA QUINTUPLE + APRAX 6 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('883','2019-01-04','159','229','3','VACUNA QUINTUPLE + APRAX 4.950 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('884','2017-11-23','159','230','3','PRIMER VACUNA QUINTUPLE + APRAX 3.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('885','2017-12-01','159','230','2','DECAIMIENTO, T NORMAL, RINITIS. VIT + DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('886','2017-12-14','159','230','3','SEGUNDA VACUNA QUINTUPLE + APRAX 4.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('887','2018-01-04','159','230','3','TERCER VACUNA QUINTUPLE + APRAX 6.220 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('888','2018-03-10','159','230','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('889','2019-01-04','159','230','3','VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('890','2019-01-05','18','21','2','TRAQUEOBRONQUITIS, DEXA + TRIBIOTIC. PREDNISOLONA CADA 12 HS X 4 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('891','2019-01-05','103','147','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('892','2019-01-07','160','231','3','TERCER VACUNA QUINTUPLE + APRAX 3.360 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('893','2018-12-17','162','233','3','PRIMER VACUNA QUINTUPLE + FENTEL SUSP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('894','2019-01-07','162','233','3','SEGUNDA VACUNA QUINTUPLE + APRAX 3.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('895','2019-01-08','126','179','3','SEGUNDA VACUNA QUINTUPLE + APRAX 2.600 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('896','2019-01-08','126','234','3','VACUNA QUINTUPLE + ANTIRRABICA PROVIDEAN S 043 S 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('897','2019-01-08','66','95','2','HERIDA POR MORDEDURA. PUNTOS. TRIBIOTIC + DEXA. ENRO + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('898','2019-01-08','164','236','3','VACUNA ANTIRRABICA PROVIDEAN S 043 S 134713073 M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('899','2018-12-17','57','237','3','PRIMER VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('900','2019-01-09','57','237','3','SEGUNDA VACUNA QUINTUPLE + APRAX 4.240 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('901','2018-12-17','57','238','3','PRIMER VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('902','2019-01-09','57','238','3','SEGUNDA VACUNA QUINTUPLE + APRAX 3 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('903','2017-11-08','165','239','3','SEGUNDA VACUNA QUINTUPLE + APRAX 2.790 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('904','2017-11-29','165','239','3','TERCER VACUNA QUINTUPLE + APRAX 4.030 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('905','2018-01-31','165','239','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('906','2019-01-08','165','239','3','VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('907','2019-01-09','88','127','3','TERCER VACUNA QUINTUPLE + APRAX 7.240 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('908','2019-01-09','88','126','4','APRAX 9.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('909','2019-01-09','59','240','3','PRIMER VACUNA QUINTUPLE + APRAX 9.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('910','2019-01-09','123','173','4','TOTAL FULL 0.720 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('911','2017-11-29','166','241','3','PRIMER VACUNA TRIPLE + APRAX SUSP 1.250 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('912','2018-01-14','166','241','3','SEGUNDA VACUNA TRIPLE + APRAX 2.110 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('913','2018-05-28','166','241','3','HIPERSALIVACION. DECAIMIENTO. DOLOR ABDOMINAL. GASTRINE + DEXA + VIT','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('914','2018-04-24','166','241','3','ANTIRRABICA MUNICIPAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('915','2019-01-10','166','241','3','VACUNA TRIPLE + APRAX X 48 HS. 5.550 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('916','2019-01-10','167','242','3','VACUNA QUINTUPLE + ANTIRRABICA PROVIDEAN S 043 S 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('917','2019-01-11','168','243','2','GASTROENTERITIS. VOMITO DE PELO. DIARREA. TEMP. NORMAL. GASTRINE+ DEXA + VIT','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('918','2018-07-02','168','243','3','ANTIRRABICA MUNICIPAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('919','2019-01-11','31','35','2','DOLOR ABDOMINAL, COMIO OTRO ALIMENTO. GASTRINE +  DEXA + VIT . AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('920','2019-01-11','67','96','2','BROTE. COMPLEJO B 1/2 CADA 24 HS X 30 DIAS. DERMIL 1 C/12 X 7 - 1/2 C 12 X 10- 1/2 C 24 X 10 - 1/2 C 48 X 30. APRAX 50 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('921','2019-01-11','24','26','3','ANTIRRABICA PROVIDEAN S 043- S 134713073 M + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('922','2019-01-11','73','104','3','VACUNA ANTIRRABICA PROVIDEAN S 043 S 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('923','2019-01-12','170','245','2','PISADO POR  PIES. SHOCK. DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('924','2018-12-17','171','246','3','PRIMER VACUNA QUINTUPLE + TOTAL FULL SUSP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('925','2019-01-12','171','246','3','SEGUNDA VACUNA QUINTUPLE + APRAX  2.400 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('926','2019-01-12','172','247','3','PRIMER VACUNA QUINTUPLE + APRAX 2.810 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('927','2017-03-27','173','249','2','DERMATITIS POR PULGAS. COMFORTIS + PREDNISOLONA X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('928','2017-04-21','173','249','2','DERMATITIS ALERGICA. DERMIL 1/4 CADA 12 X 4- 1/4 CADA 24 X 7- 1/4 CADA 48-72 HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('929','2015-05-05','173','248','3','SEGUNDA VACUNA QUINTUPLE + ATP. OTITIS, TRATAMIENTO CON OTOVIER + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('930','2015-05-26','173','248','3','TERCER VACUNA QUINTUPLE + ATP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('931','2015-06-29','173','248','2','GRITOS, DOLOR NO ESPECIFICO. GL. PERIANALES INFLAMADAS. COMPLEJO B + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('932','2016-10-13','173','248','2','HERIDA X MORDEDURA EN MEJILLA-CUELLO- ENRO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('933','2017-08-24','173','248','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('934','2018-02-02','173','248','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('935','2018-07-09','173','248','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('936','2015-08-25','173','250','2','T 40 GRADOS. SANGRADO X VULVA DURANTE MAS DE 30 DIAS. INFECCION? TVT? PIOMETRA? LEPTO? DIPIRONA + DOXICICLINA . DE REALIZA  ECOGRAFIA, SE VEN DIFERENTES ONDAS DE MADURACION FOLICULAR GENERANDO CELO X 60 DIAS. SE SOLICITA OVARIOHISTERECTOMIA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('937','2017-08-24','173','250','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('938','2018-02-02','173','250','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('939','2018-07-19','173','250','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('940','2019-01-14','173','250','2','CONSUME DE VENENO PARA RATONES. VIT K + DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('941','2019-01-14','54','73','3','VACUNA ANTIRRABICA S 043 S 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('942','2019-01-14','175','252','3','VACUNA ANTIRRABICA. PROVIDEAN S 043 S 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('943','2019-01-14','175','253','3','VACUNA ANTIRRABICA. PROVIDEAN S 043 S 134713073 M. SE COME LA CABEZA DE UN MURCIELAGO. ME AVISAN DESPUES DE VACUNAR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('944','2019-01-15','100','143','3','ULTIMA VACUNA QUINTUPLE + APRAX 3,870 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('945','2019-01-15','176','254','2','MICOSIS EN PIEL. CREMA 6 A + IODO X 25 DIAS. SI NO MEJORA COMIENZA VIA ORAL. APRAX 4 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('946','2019-01-15','178','256','2','DOLOR EN RODILLA. RIMADYL X DOS DIAS. LUEGO PREDNISOLONA 20 MG CADA 12 HS X 5 + ALGEN 60 CADA 12 HS X 3. CANCER DE MAMA, UN SOLO FOCO DE 3 X 2 CM','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('947','2019-01-15','177','255','2','DERIVADO. HISTORIA DE GASTROENTERITIS. OJO CON LA TRIADITIS. PERDIDA EXCESIVA DE PELO, CONSUME FIT 32. DECAIMIENTO, T NORMAL. SE APLICA DEXA + GASTRINE + VIT. CUIDADO CON SUS VIAS URINARIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('948','2019-01-15','180','258','2','DERMATITIS GENERALIZADA. OTITIS. PULGAS. DEXA + TRIBIOTIC . OTOVIER NF CADA 12 HS + PREDNISOLONA 10 MG 1/2 CADA 12 X 6 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('949','2018-02-09','181','259','3','PRIMER VACUNA 5°+ FENTEL SUSPENSIÓN 0,700 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('950','2018-02-20','181','259','4','FENTEL SUSPENSIÓN POR 48 HS. 0,800 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('951','2018-03-05','181','259','3','SEGUNDA VACUNA 5°+ FENTEL SUSPENSIÓN 1, 110 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('952','2018-04-03','181','259','3','TERCER VACUNA 5°+ APRAX 1,900 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('953','2018-06-26','181','259','4','3,200 KG. APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('954','2019-01-15','181','259','4','APRAX 3,410 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('955','2019-01-15','179','257','2','PARCHE CALIENTE FACIAL. PELO HIRSUTO. CEFALEXINA 15 DÍAS+ PREDNISOLONA 5 DÍAS. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('956','2019-01-18','156','222','2','DOLOR EN ZONA LUMBAR. OBESIDAD. UÑAS LARGAS.. PREDNISOLONA 20 1/2 CADA 12 X 5. CAMBIO DE ALIMENTO DE SIEGER LIGHT A KEN-L LIGHT','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('957','2019-01-11','99','142','7','DORAMECTINA 0.25 -2 DOSIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('958','2019-01-18','99','142','2','DORAMECTINA 0.25- 3 DOSIS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('959','2019-01-18','136','192','3','TERCER VACUNA QUINTUPLE  + APRAX 4.490 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('960','2019-01-18','136','193','3','TERCER VACUNA QUINTUPLE + APRAX 4.450 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('961','2019-01-18','136','191','3','VACUNA ANTIRRABICA PROVIDEAN SERIE 043 SENASA 134713073M + APRAX 6.400 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('962','2019-01-18','183','263','2','SENIL. HIPOTERMIA. POSIBLE INSUFICIENCIA RENAL. HISTORIA DE CONSUMO DE HIGADO Y CARNE MOLIDA CRUDA DIARIAMENTE. APRAX. VIT + DEXA. KUALCOVIT B 0.5 ML','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('963','2017-02-23','182','262','3','VACUNA TRIPLE + ANTIRRABICA. 6.600KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('964','2018-03-24','182','262','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('965','2019-01-18','182','262','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('966','2016-11-01','182','261','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('967','2017-01-17','182','261','4','APRAX 4.600 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('968','2017-08-09','182','261','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('969','2017-11-07','182','261','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('970','2018-08-22','182','261','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('971','2019-01-18','182','261','3','VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('972','2016-10-03','182','260','4','FENTEL SUSP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('973','2016-11-01','182','260','3','PRIMER VACUNA TRIPLE + FENTEL SUSP. 1.510 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('974','2016-12-06','182','260','3','SEGUNDA VACUNA TRIPLE + BASKEN 2.370 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('975','2016-12-14','182','260','2','VOMITOS. DIARREA. GASTRINE + VIT','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('976','2017-01-17','182','260','3','TERCER VACUNA TRIPLE + APRAX 3.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('977','2017-02-23','182','260','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('978','2017-05-12','182','260','6','ORQUIECTOMIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('979','2018-02-01','182','260','3','VACUNA TRIPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('980','2018-03-08','182','260','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('981','2019-01-19','182','260','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('982','2019-01-19','135','190','3','TERCER VACUNA QUINTUPLE + APRAX 8.670 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('983','2019-01-19','184','264','3','PRIMER VACUNA QUINTUPLE + APRAX 3,380 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('984','2019-01-21','144','205','3','ANTIRRABICA PROVIDEAN S 043, S 134713073M + PERFOS + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('985','2019-01-21','116','265','2','DOLOR ABDOMINAL, CAMBIO DE ALIMENTO BRUSCO. AYUNO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('986','2019-01-21','46','61','3','PRIMER VACUNA TRIPLE + TOTAL FULL 1.600 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('987','2019-01-21','66','95','3','VACUNAS QUINTUPLE + ANTIRRABICA PROVIDEAN SERIE 043 - SENASA 134713073M. ALGEN POR DOLOR DE MANITO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('988','2019-01-21','185','266','3','PRIMER VACUNA QUINTUPLE + TOTAL FULL 1.500 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('989','2019-01-21','86','124','3','TERCER VACUNA QUINTUPLE + APRAX 3.680 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('990','2018-09-14','186','267','3','SEGUNDA VACUNA QUINTUPLE + APRAX 5.600 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('991','2018-10-05','186','267','3','TERCER VACUNA QUINTUPLE + APRAX 8.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('992','2019-01-21','186','267','3','ANTIRRABICA PROVIDEAN MULTID. SERIE 043 SENASA 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('993','2019-01-21','140','198','4','APRAX 2.570 kg','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('994','2019-01-22','184','264','2','COMIENZO CON ENTEROSEPT 0.5 ML CADA 8 HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('995','2016-08-18','187','268','2','EXTRACCION DE UÑA( ESPOLON). BASKEN 7.230 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('996','2016-12-23','187','268','2','DECAIMIENTO-VOMITOS. VIT + GASTRINE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('997','2016-12-27','187','268','4','APRAX 7.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('998','2016-12-31','187','268','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('999','2018-01-18','187','268','3','VACUNA QUINTUPLE + APRAX 7.860 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1000','2019-01-23','187','268','3','VACUNA QUINTUPLE + ANTIRRA BICA PROVIDEAN SERIE 043- SENASA 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1001','2015-04-06','188','269','2','SE COLOCA ABORTIVO IM PRIVAPROL 0,2 ML + ENROFLOXACINA 25 MG C/ 24 HS POR 15 DÍAS. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1002','2016-04-29','188','269','2','RONQUIDO RESPIRATORIO. SOLICITO ELECTRO, ANÁLISIS DE SANGRE( HIPOTIROIDISMO, DIABETES, HIPERADRENO). POSIBLES PATOLOGÍAS: PALADAR, PÓLIPO NASAL.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1003','2016-06-03','188','269','2','ECOGRAFIA: UTERO POLIQUISTICO, HIPERPLASIA ENDOMETRIAL QUISTICA CAMINO A PIOMETRA. PARA CIRUGÍA SE SOLICITA ELECTRO. ENRO POR 10 DÍAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1004','2016-06-29','188','269','6','OVARIOHISTERECTOMIA, ÚTERO QUISTICO SACULADO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1005','2017-04-01','188','269','2','DOLOR EN MANO, PREDNISOLONA 10 MG 1/4 C/ 12 HS POR 4 DÍAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1006','2019-01-23','188','269','3','ATR ( PROVIDEAN) SERIE: 043 SENASA: 134713073M + 6° ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1007','2019-01-23','188','270','3','ATR ( PROVIDEAN) SERIE: 043 SENASA: 134713073M + 6°','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1008','2019-01-24','159','229','2','DECAIMIENTO. T°: 39,7. MUCOSAS AMARILLENTAS. DOLOR RENAL. CONSULTORIO: TRIBIOTIC+ DEXA+ VIT + DIPIRONA. DOXICLINA 50 MG. 1/2 COMPRIMIDO C/ 12 HS. DIPIRONA 1/4 C/ 8 HORAS. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1009','2019-01-24','116','265','2','PREDNISOLONA 5 MG CADA 12 HS X 6 DIAS + ALGEN CADA 12 HS X 4 DIAS. POLADIN MAX CACHORROS 1/2 CADA 24 HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1010','2015-07-03','189','271','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1011','2015-11-04','189','271','4','APRAX 25 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1012','2016-02-27','189','271','3','QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1013','2016-03-10','189','271','4','BASKEN PLUS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1014','2016-07-21','189','271','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1015','2016-11-15','189','271','2','DRENAJE DE GLANDULAS PERIANALES + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1016','2017-03-02','189','271','3','QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1017','2017-03-23','189','271','4','APRAX 25 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1018','2017-07-31','189','271','4','APRAX 25 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1019','2017-11-21','189','271','4','BASKEN 25 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1020','2018-03-03','189','271','3','QUINTUPLE + ANTIRRABICA + BASKEN 25 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1021','2018-07-02','189','271','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1022','2018-10-05','189','271','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1023','2019-01-25','189','271','4','APRAX 25 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1024','2015-07-03','189','272','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1025','2015-08-15','189','272','3','QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1026','2015-11-04','189','272','4','APRAX 15 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1027','2016-03-10','189','272','2','TOS DE LAS PERRERAS, OTITIS INFLAMATORIA. ENRO X 10 DIAS + PREDNISOLONA X 2 DIAS + DIPIRONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1028','2016-05-23','189','272','2','JADEO- T 39.6. DIPIRONA + TRIBIOTIC+ DEXA. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1029','2016-07-21','189','272','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1030','2016-08-13','189','272','3','QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1031','2016-11-23','189','272','4','APRAX 15 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1032','2017-03-23','189','272','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1033','2017-07-31','189','272','4','APRAX 15 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1034','2017-08-12','189','272','3','QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1035','2017-09-30','189','272','2','DOLOR EN FALANGES Y METACARPOS DERECHOS, DEXA + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1036','2017-11-21','189','272','4','BASKEN 20 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1037','2018-03-27','189','272','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1038','2018-07-02','189','272','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1039','2018-08-11','189','272','3','QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1040','2018-10-05','189','272','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1041','2019-01-25','189','272','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1042','2019-01-28','24','26','2','VOMITOS Y MATERIA FECAL BLANDA. T° 39.1. CERENIA + TIBIOTIC + DEXA. DIETA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1043','2019-01-28','190','273','3','1° VACUNA QUINTUPLE + TOTAL FULL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1044','2016-09-21','191','275','3','2° VACUNA QUINTUPLE + APRAX  7.720KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1045','2016-10-13','191','275','3','3° VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1046','2016-11-08','191','275','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1047','2017-02-13','191','275','4','APRAX 20 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1048','2018-07-09','191','275','3','5 + ATR + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1049','2019-01-28','191','275','4','NEXGARD','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1050','2016-09-21','191','274','3','2° VACUNA QUINTUPLE + APRAX 8.730KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1051','2016-10-08','191','274','2','INFLAMACION EN CABEZA (HUESO PARIETAL). PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1052','2016-10-13','191','274','3','3° VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1053','2016-11-08','191','274','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1054','2017-01-25','191','274','2','PRURITO. DERMIL 1/2 COMP C/12 HS X 3 DIAS, 1/2 COMP C/24HS X 2 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1055','2017-02-13','191','274','4','APRAX 20KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1056','2018-03-09','191','274','3','5 + ATR + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1057','2019-01-28','191','274','4','NEXGARD','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1058','2019-01-29','133','188','2','DERMATITIS X PULGAS. PIPETA OSSPRET + PREDNISOLONA X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1059','2018-08-15','193','277','2','VOMITO. ATP. GASTRINE + VIT + DEXA. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1060','2019-01-29','193','277','3','PRIMER VACUNA QUINTUPLE + ATP ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1061','2014-12-16','194','278','3','VACUNA QUINTUPLE + ATP BARREDOR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1062','2015-01-27','194','278','3','ATR + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1063','2015-06-19','194','278','2','DECAIMIENTO. DIPIRONA + TRIBIOTIC','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1064','2015-12-17','194','278','3','QUINTUPLE + ATP APRAX ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1065','2016-06-27','194','278','2','INFLAMACION GLANDULAS PERIANALES. VACUNA ATR + ATP APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1066','2016-07-28','194','278','2','DOLOR EN CARPO + BRONQUITIS. TRIBIOTIC + DEXA. PREDNISOLONA1/2 COMPRIMIDO c/ 12 HS POR 4 DÍAS. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1067','2016-09-19','194','278','2','DIARREA. 40 °C.  OTITIS. ENRO POR 10 DÍAS. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1068','2016-11-14','194','278','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1069','2017-01-03','194','278','3','QUINTUPLE ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1070','2017-10-19','194','278','4','BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1071','2018-01-06','194','278','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1072','2019-01-29','194','278','3','QUINTUPLE + ATR + ATP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1073','2017-02-24','195','279','3','PRIMER VACUNA 5°','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1074','2017-02-17','195','279','3','SEGUNDA VACUNA 5°+ APRAX 3,680 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1075','2017-04-17','195','279','3','TERCER VACUNA 5° + APRAX 6,500 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1076','2014-11-28','195','280','2','FECHA DE SERVICIO 8 Y 12 DE OCTUBRE. FECHA POSIBLE DE PARTO 4-16 / 12 ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1077','2016-04-15','195','280','6','CASTRACIÓN. ATP APROX. 6 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1078','2017-04-12','195','280','4','ATP APRAX, 7, 5 KG APROX.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1079','2018-04-25','195','280','3','ATR MUNICIPAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1080','2018-09-10','195','281','2','JADEO. DOLOR ABDOMINAL. HISTORIA PSEUDOGESTACION. T° NORMAL. CELO IRREGULAR HACE 15 DÍAS. PIOMETRA? AUSENCIA DESCARGA VULVAR. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1081','2018-09-12','195','281','2','ECOGRAFIA. PIOMETRA. CIRUGÍA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1082','2016-04-15','195','282','3','VACUNA 5° + ATP (BASKEN PLUS) 5,450 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1083','2016-06-09','195','282','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1084','2016-06-16','195','282','8','0,5 ML','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1085','2016-11-15','195','282','8','0,5 ML 5,200 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1086','2017-04-12','195','282','8','0,6 ML + ATP 7,500 KG + OTRA PERRITA SIN FICHA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1087','2017-04-19','195','282','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1088','2017-06-09','195','282','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1089','2017-11-18','195','282','8','ANOV.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1090','2018-04-17','195','282','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1091','2018-04-20','195','282','8','ANOV','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1092','2018-06-14','195','282','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1093','2018-09-21','195','282','8','ANOV.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1094','2019-01-29','195','280','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1095','2019-01-29','195','281','5','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1096','2019-01-29','195','282','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1097','2019-01-29','162','233','3','TERCER VACUNA QUINTUPLE + APRAX  4.380','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1098','2019-01-29','90','129','2','CONJUNTIVITIS INFECCIOSA. GANGLIOS INFLAMADOS. ENRO + PREDNISOLONA + TAU CON ESTEROIDES.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1099','2019-01-30','142','201','3','SEGUNDA VACUNA TRIPLE + APRAX 2.080 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1100','2019-01-29','192','276','5','GASTROENTERITIS , POSIBLE GOLPE DE CALOR + MALA ALIMENTACION','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1101','2019-01-30','196','283','3','PRIMER VACUNA QUINTUPLE + APRAX SUSP 1.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1102','2019-01-30','126','179','3','TERCER VACUNA QUINTUPLE + APRAX 3, 630 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1103','2019-01-30','168','243','3','VACUNA TRIPLE + COMFORTIS 4, 500 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1104','2019-01-30','197','284','2','REACCION ALERGICA EN VIENTRE Y VULVA. POSIBLE CONTAMINACION MICOTICA. TRATAMIENTO SOLO CON DERMIL. 1/4 CADA 12 HS X 5 DIAS, LUEGO CADA 24 HS X 10 DIAS, LUEGO CADA 48 HS X 30 DIAS. CONTROL EN 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1105','2016-08-30','198','285','2','HISTORIA DE ANOVULATORIO CADA 5 MESES. HISTIOCITOMAS EN GLANDULAS MAMARIAS. ECOGRAFIA: MASTOCITOMAS EN  LAS DOS ULTIMAS GLANDULAS DEL LADO IZQUIERDO, ULTIMA  MAMA DEL LADO DERECHO Y AL COMIENZO DEL LADO DERECHO INTERMAMARIO. SE SOLICITA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1106','2016-11-15','198','285','6','OVARIOHISTERECTOMIA. QUEDAN PARTE DE LOS OVARIOS ADHERIDOS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1107','2017-01-23','198','285','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1108','2018-01-24','198','285','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1109','2019-01-31','198','285','3','QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1110','2019-01-31','200','287','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1111','2019-01-31','200','289','3','VACUNA ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1112','2019-01-30','122','172','2','ACCIDENTE TRANSITO. INTERNACION. RADIOGRAFIA. FRACTURA DE CADERA IZQUIERDA Y POSIBLE FRACTURA DERECHA. ECOGRAFIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1113','2019-02-02','165','239','3','ANTIRRABICA PROVIDEAN S 043 S 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1114','2019-02-02','99','142','7','ULTIMA DORAMECTINA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1115','2019-02-04','178','256','2','DOLOR EN PARA DELANTERA. EXA + ALGEN. POLFEN 1 A LA MAÑANA Y MEDIO POR LAS NOCHES','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1116','2019-02-04','147','290','3','PRIMER VACUNA QUINTUPLE + TOTAL FULL 1.230 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1117','2017-03-15','201','291','2','DERMATITIS POR PULGAS. DEXA.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1118','2018-07-25','201','291','2','VOMITO CRONICO. GASTRINE + RANITIDINA ORAL CADA 12 HS X 5 DIAS. MV GASTROINTESTINAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1119','2019-02-05','201','291','2','DERMATITIS X PULGAS. PIPETA OSSPRET + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1120','2019-02-05','171','246','3','ULTIMA QUINTUPLE + APRAX 3,280 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1121','2015-08-13','203','292','3','VACUNA QUINTUPLE + APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1122','2015-09-30','203','292','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1123','2015-10-15','203','292','2','PARCHE CALIENTE. CREMA 6 A','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1124','2016-01-28','203','292','4','BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1125','2016-03-24','203','292','2','COJUNTIVITIS INFECCIOSA-REACCION ALERGICA RESPIRATORIA CON MANIFESTACION EN PIEL. TRIBIOTIC + VIT + DEXA. TAU CADA 12 HS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1126','2016-06-06','203','292','2','GASTROENTERITIS X CONSUMO DE MILANESAS DE PESCADO Y POLLO AL HORNO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1127','2016-10-22','203','292','3','ANTIRRABICA + BASKEN 3.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1128','2018-03-23','203','292','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1129','2018-04-18','203','292','2','RADIOGRAFIAS EN METACARPO DERECHO. FISURA. VENDAJE DE ROBERT JONS X 40 DIAS CON CAMBIOS SEMANALES. AUMENTO DE GLUCOSA EN SANGRE, POSIBLEMENTE MEDICAMENTOSA. SE APLICA INSULINA. CONTINUA CON TRAMADOL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1130','2018-08-16','203','292','2','PARCHE CALIENTE. ENRO + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1131','2015-07-24','203','293','3','VACUNA QUINTUPLE + BASKEN','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1132','2015-10-23','203','293','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1133','2016-02-01','203','293','4','APRAX','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1134','2016-07-27','203','293','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1135','2016-10-21','203','293','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1136','2016-10-22','203','293','4','APRAX 12.900 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1137','2016-10-24','203','293','2','HERIDA X MORDEDURA. TRIBIOTIC + DEXA. ENRO + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1138','2017-08-04','203','293','3','VACUNA QUINTUPLE + APRAX 11.550 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1139','2017-11-22','203','293','3','ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1140','2018-08-08','203','293','3','VACUNA QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1141','2016-12-19','202','297','2','EPIFORA EN OJO DERECHO. TAU OFTALMICO. ATP FENTEL SUSP 0.900 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1142','2017-02-17','202','294','2','DOLOR. GRITOS. GL TAPADAS. PREDNISOLONA CADA 12 HS. ANQUITO + ALIMENTO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1143','2019-02-05','202','295','2','POSIBLE COMIENZO DE SARNA. DORAMECTINA 0.3 ML','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1144','2014-02-25','204','298','2','ZONAS ALOPÉCICAS. PRURITO EN OREJAS. ANTECEDENTES: SE QUEDO SOLO UNA SEMANA. ALOPECIA EN TORAX. DERMIL 1/2 COMP C/ 12HS X 2 DIAS, LUEGO 1/2 COMP C/ 24HS X 1 SEMANA, PERVINOX EN LAS ZONAS A TRATAR + CREMA KUALCODERM X 20 DIAS. REGRESA EN 20 DIAS ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1145','2014-03-31','204','298','2','MISMAS LESIONES, MISMO TRATAMIENTO QUE 25/02/14','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1146','2017-12-04','204','298','2','HERIDA POR MORDEDURA + PARCHE CALIENTE. CAMBIO ENRRO X PYODERM POR APATIA + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1147','2018-03-19','204','298','2','PIODERMIA PROFUNDA EN PATAS, POSIBLE INFECCION MICOTICA. TRIBIOTIC + DEXA + AMIXI. PYODERM X 30 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1148','2018-04-25','204','298','3','ATR','0');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1149','2018-04-25','204','298','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1150','2019-02-06','204','298','2','OTITIS INFECCIOSA. LIMPIEZA + OTOVIER NF. PYODERM 500 C/ 12HS X 20 DIAS + PREDNISOLONA 20 MG 1/2 COMP C/12 HS + OTOVIER NF C/12 X 20 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1151','2015-09-23','205','299','2','DIARREA. INFLAMACION GL. PERINEALES. TRIBIOTIC + DEXA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1152','2015-04-04','205','299','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1153','2015-10-20','205','299','4','APRAX 7.680KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1154','2015-12-01','205','299','2','REACCION ALERGICA. DERMIL 1/4 C/ 12HS X4 DIAS, 1/4 C/ 24HS X 4 DIAS, 1/4 C/48HS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1155','2015-12-28','205','299','2','RECAIDA. PYODERM 500 1/4 C/ 12HS X 10 DIAS + DERMIL 1/4 C/24 X 10. SI NO MEJORA RASPADO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1156','2016-01-27','205','299','2','RECAIDA - ATOPIA. DERMIL 1/4 C/12 X 4 DIAS. 1/4 C/24 X 1 SEM. CONTINUAR 1/4 C/48','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1157','2016-04-02','205','299','3','5° + ATP 7.800 KG','0');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1158','2016-04-02','205','299','3','5° + ATP 7.800 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1159','2017-04-03','205','299','3','5°','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1160','2016-04-30','205','299','3','ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1161','2016-05-28','205','299','2','MOSCA DE LA PUNTA DE LA OREJA. PERVINOX CADA 24HS Y LIQUIDO PUNTAOREJA 2 GOTAS EN CADA LADO EN CADA OREJA + 2 GOTAS EN EL LOMO CADA 10 DIAS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1162','2016-06-10','205','299','2','DRENAJE DE GL. PERIANALES','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1163','2016-08-16','205','299','2','DERMIL 1/4 C/ 12 X 4 DIAS, 1/4 C/ 24 X 4 DIAS, 1/ C/ 48 + APRAX ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1164','2016-09-14','205','299','2','VOMITOS, DECAIMIENTO, T° NORMAL. POSIBLE AFECCION RESPIRATORIA? TRIBIOTIC + DEXA + VIT + GASTRINE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1165','2018-04-07','205','299','3','5°','0');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1166','2018-04-19','205','299','3','ATR MUNICIPAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1167','2019-02-06','205','299','2','REACCION ALERGICA. DERMIL 1/4 C/12 X 4 DIAS, 1/4 C/24 X 7 DIAS, 1/4 C/48 X 45 DIAS. APRAX 8.300KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1168','2018-12-21','23','27','6','OVARIOHISTERECTOMIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1169','2019-02-07','109','156','3','SEGUNDA VACUNA QUINTUPLE + APRAX 13, 350 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1170','2019-02-08','195','282','8','ANOVULATORIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1171','2019-02-08','100','143','2','DOLOR ENFALANGES DE PATA DERECHA. PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1172','2019-02-08','206','300','2','TRAUMATISMOS VARIOS POR MORDEDURA. HEMATOMAS. DOLOR. FIEBRE.INFECCION SUPERFICIAL DE PIEL. TRIBIOTIC + DIPIRONA. PYO DERM X 10 DIAS + DIPIRONA + PREDNISOLONA. CONTROL EN 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1173','2019-02-09','90','129','2','CONJUNTIVITIS. COMIENZO CON OTEX (COPROFLOXACINA + HIDROCORTISONA) X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1174','2019-02-11','207','301','3','5° + ATR (N°043 SENASA 134713073)+ APRAX 30KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1175','2017-07-14','207','301','3','1° QUINTUPLE + APRAX 4.370KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1176','2017-08-07','207','301','3','2° QUINTUPLE + APRAX 6.170KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1177','2017-08-28','207','301','3','3° QUINTUPLE + APRAX 7.730KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1178','2019-02-11','23','27','7','EXTRACCION SANGRE P CONTROL. APRAX 14.600','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1179','2019-02-11','172','247','3','2° QUINTUPLE + APRAX  6.660KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1180','2019-02-12','178','256','2','DOLOR ARTICULAR DE CADERA, DECAIMIENTO, HIPERTERMIA 40°C, EXTRACCIÓN DE SANGRE. CONSULTORIO: DIPIRONA , TRIBIOTIC, VIT. ENRO POR 6 DIAS + DIPIRONA. SOSPECHA BRUCELOSIS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1181','2019-02-12','54','74','3','5° + ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1182','2018-04-28','208','302','3','PRIMER VACUNA QUINTUPLE + APRAX 2 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1183','2018-05-19','208','302','3','SEGUNDA VACUNA QUINTUPLE + APRAX 2.600 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1184','2018-06-09','208','302','3','TERCER VACUNA QUINTUPLE + APRAX 3.300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1185','2019-02-13','208','302','2','TOS. CONJUNTIVITIS INFLAMATORIA. TRIBIOTIC + DEXA. PREDNISOLONA X 4 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1186','2015-08-21','209','303','3','5° + BARREDOR FRONTAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1187','2015-08-29','209','303','2','ATROPELLADO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1188','2015-09-04','209','303','6','CIRUGIA LUXACION DE CADERA. ELECTRO + ANALISIS. ALGEN C/8HS X 3 DIAS LUEGO C/12HS X 4. CARPROFENO C/12 X 3 LUEGO C/24 X 2. OVIMIN 1 C/24. CONTOL DE RIÑONES!! SE REALIZA PLACA: ARBOLBRONQUIAL INFLAMADO, ESO NOS PUEDE GENERAR AUMENTO HEMATOCRITO, UREA Y CREATININA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1189','2015-09-15','209','303','2','DRENAJE DE SEROMA. CARPROBAY 1/2 C/12 X 4, LUEGO 1/2 C/24 X 2.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1190','2016-02-08','209','303','2','LESION NASAL POR PICADURA DE ARAÑA? ALACRAN? DEXA + TRIBIOTIC + DIFENILHIDRAMINA. ENRRO 100MG + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1191','2016-04-09','209','303','4','NEXGARD 25-50KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1192','2016-09-18','209','303','3','5° + ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1193','2019-02-13','209','303','2','CONVULSION AISLADA. HORAS ANTES ESTUVO COMIENDO BASURA CALLEJERA. POSIBLE CONSUMO DE VENENO PARA HORMIGAS. NO SE DIAGNOSTICA EPILEPSIA. SE ENCUENTRA EN OBSERVACION POR LA DUEÑA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1194','2019-02-14','61','89','2','GASTROENTERITIS. GASTRINE + DEXA + VIT','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1195','2019-02-13','178','256','7','COMIENZO CONPEDNISOLONA 20 MG CADA 12 HS X 5 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1196','2019-02-14','178','256','7','OVIMIN 1 CAP/DIA + KUALCOVIT B 1.5ML/DIA + POLFEN 1/2 C/12HS X 5 DIAS ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1197','2019-02-14','63','92','2','PIODERMIA. REACCION ALERGICA GENERALIZADA EN PIEL. PELO IRSUTO Y APELMAZADO. LE COLOCARON ACEITE EN DORSO Y LOMO. 1/4 PYODERM C/12 + PREDNISOLONA 1/2 C/12. SE SOLICITA BAÑO Y CORTE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1198','2019-02-15','23','27','7','AC. TIOCTICO 1 C/12 X 1 SEM, LUEGO 1 C/24 X 60 DIAS + DERM CAPS 0.5 C/24. SE LE PIDE MODIFICACION DE DIETA Y CONTRO EN 30 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1199','2019-02-15','20','23','4','NEXGARD 2-4 KG + PREDNISOLONA 1/4 C/12 X 1 SEM ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1200','2019-02-17','210','304','2','SUTURA EN COLA. APRAX 4.200 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1201','2019-02-18','211','305','2','DERMATITIS X PULGAS. ANIKIL + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1202','2019-02-18','3','3','3','QUINTUPLE + APRAX 5,300 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1203','2019-02-18','185','266','3','SEGUNDA VACUNA QUINTUPLE + TOTAL FULL 1, 780 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1204','2019-02-19','203','292','3','VACUNAS QUINTUPLE + ANTIRRABICA PROVIDEAN SERIE 013- SENASA 134713073M','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1205','2019-02-18','212','306','2','PERDIDA DE PROPIOCEPCION  EN PATAS TRASERAS CON POSIBLE AVANCE HACIA CRANEAL, BABEO , POSIBLES CONVULSIONES, DOLOR LUMBAR. DIAGNOSTICO PRESUNTIVO: DESPLAZAMIENTO DISCO INTERVERTEBRAL, ARTROSIS, TOXOPLASMOSIS, NEOSPOROSIS. SOLICITO ANÁLISIS Y RX DE CADERA Y COLUMNA VERTEBRAL. TRATAMIENTO: PREDNISOLONA 20 MG. C/ 12 HS POR 10 DÍAS + COMPLEJO B POR 30 DÍAS + OVIMIN.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1206','2019-02-19','196','283','3','SEGUNDA VACUNA QUINTUPLE + APRAX 1,900 KG.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1207','2019-02-19','190','273','3','SEGUNDA VACUNA QUINTUPLE + APRAX 6,380 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1208','2017-12-26','213','307','2','HEMATURIA.DOLOR RENAL.CONSUME PERFORMANCE. POSIBLE CRISTALURIA.TRBIOTIC + DEXA. ENRO X 10 DIAS + PREDNISOLONA X 4 DIAS. OBSTRUCCION GL PERIANALES. SOLICITO URIANALISIS.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1209','2017-12-27','213','307','3','VACUNAS QUINTUPLE + ANTIRRABICA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1210','2019-02-19','213','307','3','VACUNAS QUINTUPLE + ANTIRRABICA PROVIDEAN S 043 - S 134713073 + APRAX 10 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1211','2019-02-20','214','308','2','DERIVADO DE MAZZANTTI. FUS. COME ALIMENTO DE PERRO. TIENE 5 MESES. PROPANTELINA + PREDNISOLONA + ENRO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1212','2019-02-20','209','303','3','QUINTUPLE + ANTIRRABICA SERIE: 043/25. SENASA: 134713073','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1213','2019-02-20','215','309','2','ENTROPION, DERIVADO. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1214','2019-02-21','103','146','2','PICADURA EN GARRON. DEXA + PREDNISOLONA 5 MG CADA 12 HS X DOS DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1215','2019-02-21','87','125','2','PIODERMIA. VENTRAL DEL CUELLO Y PATA TRASERA. PYODERM 1/4 C/12 + PREDNISOLONA 1/4 C/12 ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1216','2018-03-02','216','310','3','1° DOSIS QUINTUPLE + APRAX 4.5KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1217','2018-03-23','216','310','3','2° DOSIS QUINTUPLE + APRAX 6.960KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1218','2018-04-13','216','310','3','ATR MUNICIPAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1219','2018-04-16','216','310','3','3° DOSIS QUINTUPLE','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1220','2019-02-07','122','172','6','CIRUGIA TRAUMATOLOGICA DE SOLUCION DE FRACTURAS DE CADERA. QUEDA PENDIENTE EXCERESIS CABEZA FEMORAL DERECHA Y RUPTURA DE LIGAMENTO CRUZADO POSTERIOR DERECHO. DIARREA HEMORRAGICA POR ULCERAS INTESTINALES TRATADAS CON SUCRALFATO. NO SE PUEDE HACER MAS TRANSFUSION','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1221','2019-02-21','122','172','2','CUADRO ALERGICO RESPIRATORIO. FIEBRE. SE APLICA DIPIRONA + TRIBIOTIC + DEXA. COMIENZA CON FISIO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1222','2019-02-21','172','247','2','REACCION ALERGICA EN ABDOMEN. DEXA + PREDNISOLONA 1/2 C/12HS X 2 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1223','2019-02-22','217','311','2','TRAQUEOBRONQUITIS. TRIBIOTIC + DEXA. ENRO + PREDNISOLONA. T NORMAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1224','2019-02-22','34','38','2','TRAQUEOBRONQUITIS. TRIBIOTIC + DEXA. ENRO + PREDNISOLONA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1225','2019-02-22','46','61','3','SEGUNDA TRIPLE FELINA + APRAX 2,200 KG. ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1226','2012-09-04','218','314','2','CELO MUY SEGUIDO (TODOS LOS MESES). TRANSOVULAR 1/2 C/24 X 10 DIAS. LUEGO 1 X SEMANA. SE SUGIERE OVARIOHISTERECTOMIA','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1227','2015-04-22','218','314','3','3° + ATR + ATP','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1228','2015-09-23','218','314','4','ATP BASKEN 5.230KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1229','2016-05-05','218','314','3','3° + ATR + APRAX 5.330KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1230','2016-12-19','218','314','4','APRAX X 2 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1231','2017-09-15','218','314','3','3° + ATR','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1232','2015-09-23','218','312','2','OBSTRUCCION DE VIAS URINARIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1233','2015-11-21','218','312','2','INFECCION RESPIRATORIA. 39.6° TRIBIOTIC','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1234','2016-05-05','218','312','3','3° + ATR + APRAX 4.300KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1235','2016-12-19','218','312','4','APRAX X 2 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1236','2017-09-14','218','312','3','3° + ATR ','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1237','2018-02-16','218','312','2','MIDRIASIS DERECHA. SIDA? DISMINUCION DE TAURINA? DISAUTONOMIA? SINDROME DE KEY-GASKELL? TONIPET 1/4 C/12. SOLICITO ANALISIS COMPLETO.','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1238','2019-02-22','218','312','2','DOLOR EN ZONA SACRA. 40°. TRIBIOTIC + DEXA + VIT + BAÑO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1239','2016-01-05','218','313','2','TOS DE LAS PERRERAS. AMINO+ PRED+ENRO X 10 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1240','2016-02-02','218','313','3','5°','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1241','2016-12-19','218','313','4','APRAX X 2 DIAS 3.810KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1242','2016-02-02','218','315','3','5°. NO ESTA CASTRADA. MASTOCITOMA Y POSIBLE HIPERPLASIA ENDOMETRIAL QUISTICA CON QUISTES EN OVARIOS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1243','2016-12-19','218','315','4','APRAX X 2 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1244','2017-12-20','218','315','2','TOS SECA. POSIBLE BRONQUITIS. PREDNISOLONA 10MG 1/4 C/12 X 5 DIAS. GRAN SOPLO 2-3° SOLICITO ECOCARDIO','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1245','2018-09-21','218','315','6','MASTECTOMIA, RESOLUCION HERNIA ABDOMINAL','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1246','2019-02-25','219','317','4','ATP SUSP. TOTAL FULL 0.460 KG','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1247','2019-02-26','220','318','2','PIODERMIA EN DORSO Y COLA. PYO DERM X 20 DIAS+ PREDNISOLONA X 8 DIAS','1');
INSERT INTO `consulta` (`idconsulta`,`fecha`,`cliente_idcliente`,`paciente_idpaciente`,`tipoConsulta_idtipoConsulta`,`motivo`,`estado`) VALUES
('1248','2019-02-26','221','319','2','TIENE COLOCADAS DOS VACUNAS, UNA QUINTUPLE Y OTRA SOLO CONTRA PARVO. SE RECOMIENDAN DOS QUINTUPLES MAS','1');



-- -------------------------------------------
-- TABLE DATA cruge_authassignment
-- -------------------------------------------
INSERT INTO `cruge_authassignment` (`userid`,`bizrule`,`data`,`itemname`) VALUES
('3','','N;','FullUser');



-- -------------------------------------------
-- TABLE DATA cruge_authitem
-- -------------------------------------------
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_cliente_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_cliente_buscarid','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_cliente_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_cliente_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_cliente_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_cliente_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_cliente_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_consulta_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_consulta_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_consulta_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_consulta_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_consulta_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_consulta_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_diagnosticocomplementario_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_diagnosticocomplementario_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_diagnosticocomplementario_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_diagnosticocomplementario_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_diagnosticocomplementario_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_diagnosticocomplementario_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_especie_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_especie_buscarid','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_especie_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_especie_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_especie_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_especie_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_especie_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_localidad_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_localidad_buscarlocalidades','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_localidad_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_localidad_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_localidad_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_localidad_listadodinamico','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_localidad_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_localidad_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_marca_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_marca_buscarmarcas','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_marca_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_marca_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_marca_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_marca_listadodinamico','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_marca_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_marca_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_paciente_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_paciente_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_paciente_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_paciente_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_paciente_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_paciente_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_actualizaprecios','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_actualizapreciosmasivo','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_actualizapreciosrubro','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_actualizapreciossubrubro','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_print','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_producto_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_raza_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_raza_buscarrazas','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_raza_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_raza_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_raza_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_raza_listadodinamico','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_raza_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_raza_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_rubro_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_rubro_buscarid','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_rubro_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_rubro_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_rubro_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_rubro_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_rubro_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_site_contact','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_site_error','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_site_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_site_login','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_site_logout','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_subrubro_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_subrubro_buscarsubrubros','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_subrubro_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_subrubro_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_subrubro_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_subrubro_listadodinamico','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_subrubro_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_subrubro_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_tipoconsulta_admin','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_tipoconsulta_create','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_tipoconsulta_delete','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_tipoconsulta_index','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_tipoconsulta_update','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('action_tipoconsulta_view','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_cliente','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_consulta','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_diagnosticocomplementario','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_especie','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_localidad','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_marca','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_paciente','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_producto','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_raza','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_rubro','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_site','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_subrubro','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('controller_tipoconsulta','0','','','N;');
INSERT INTO `cruge_authitem` (`name`,`type`,`description`,`bizrule`,`data`) VALUES
('FullUser','2','Puede administrar todo menos los usuarios','','N;');



-- -------------------------------------------
-- TABLE DATA cruge_authitemchild
-- -------------------------------------------
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','action_cliente_admin');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','action_cliente_buscarid');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','action_cliente_create');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','action_cliente_delete');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','action_cliente_index');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','action_cliente_update');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','action_cliente_view');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','action_producto_actualizapreciosrubro');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_cliente');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_diagnosticocomplementario');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_especie');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_localidad');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_marca');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_paciente');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_producto');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_raza');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_rubro');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_site');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_subrubro');
INSERT INTO `cruge_authitemchild` (`parent`,`child`) VALUES
('FullUser','controller_tipoconsulta');



-- -------------------------------------------
-- TABLE DATA cruge_session
-- -------------------------------------------
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('1','1','1492261513','1492263313','1','127.0.0.1','1','1492261513','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('2','1','1492468859','1492470659','0','127.0.0.1','1','1492468859','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('3','1','1492470680','1492472480','0','127.0.0.1','1','1492470680','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('4','1','1492472631','1492474431','0','127.0.0.1','1','1492472631','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('5','1','1492474453','1492476253','0','127.0.0.1','1','1492474453','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('6','1','1492476341','1492478141','1','127.0.0.1','1','1492476341','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('7','1','1492532313','1492534113','0','127.0.0.1','1','1492532313','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('8','1','1492534130','1492535930','1','127.0.0.1','1','1492534130','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('9','1','1492537183','1492538983','1','127.0.0.1','1','1492537183','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('10','1','1492641199','1492642999','0','127.0.0.1','1','1492641199','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('11','1','1492643115','1492644915','0','127.0.0.1','1','1492643115','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('12','1','1492644936','1492646736','0','127.0.0.1','1','1492644936','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('13','1','1492646771','1492648571','1','127.0.0.1','1','1492646771','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('14','1','1492692760','1492694560','1','127.0.0.1','1','1492692760','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('15','1','1492698845','1492700645','1','127.0.0.1','1','1492698845','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('16','1','1492863767','1492865567','0','::1','1','1492863767','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('17','1','1492867109','1492868909','0','::1','1','1492867109','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('18','1','1492868955','1492870755','0','::1','1','1492868955','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('19','1','1492870865','1492872665','1','::1','1','1492870865','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('20','1','1492874962','1492876762','1','::1','1','1492874962','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('21','1','1492899122','1492900922','0','::1','1','1492899122','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('22','1','1492901521','1492903321','0','::1','2','1492903223','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('23','1','1492903419','1492905219','0','::1','1','1492903419','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('24','1','1492905364','1492907164','1','::1','1','1492905364','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('25','1','1492974352','1492976152','1','127.0.0.1','1','1492974352','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('26','1','1493043759','1493045559','1','127.0.0.1','1','1493043759','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('27','1','1493052860','1493054660','0','127.0.0.1','1','1493052860','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('28','1','1493054920','1493056720','1','127.0.0.1','1','1493054920','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('29','1','1493137756','1493139556','0','127.0.0.1','1','1493137756','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('30','1','1493139613','1493141413','0','127.0.0.1','1','1493139613','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('31','1','1493141420','1493143220','1','127.0.0.1','1','1493141420','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('32','1','1493169562','1493171362','0','127.0.0.1','1','1493169562','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('33','1','1493171374','1493173174','1','127.0.0.1','3','1493171973','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('34','1','1493212495','1493214295','0','127.0.0.1','1','1493212495','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('35','1','1493214425','1493216225','1','127.0.0.1','1','1493214425','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('36','1','1493228327','1493230127','1','127.0.0.1','1','1493228327','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('37','1','1493403259','1493405059','1','127.0.0.1','1','1493403259','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('38','1','1493407099','1493408899','1','127.0.0.1','1','1493407099','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('39','1','1493496884','1493498684','0','127.0.0.1','1','1493496884','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('40','1','1493498751','1493500551','0','127.0.0.1','1','1493498751','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('41','1','1493500564','1493502364','0','127.0.0.1','1','1493500564','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('42','1','1493640169','1493641969','0','127.0.0.1','1','1493640169','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('43','1','1493642044','1493643844','0','127.0.0.1','2','1493643398','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('44','1','1493643980','1493645780','0','127.0.0.1','3','1493645307','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('45','1','1493646004','1493647804','0','127.0.0.1','1','1493646004','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('46','1','1493647985','1493649785','1','127.0.0.1','1','1493647985','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('47','1','1493827658','1493829458','1','127.0.0.1','1','1493827658','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('48','1','1493987177','1493988977','0','127.0.0.1','1','1493987177','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('49','1','1493989964','1493991764','1','127.0.0.1','1','1493989964','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('50','1','1494073591','1494075391','0','127.0.0.1','1','1494073591','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('51','1','1494075446','1494077246','0','127.0.0.1','1','1494075446','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('52','1','1494077360','1494079160','1','127.0.0.1','1','1494077360','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('53','1','1494079880','1494081680','1','127.0.0.1','1','1494079880','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('54','1','1494449287','1494451087','1','127.0.0.1','1','1494449287','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('55','1','1494511045','1494512845','0','127.0.0.1','1','1494511045','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('56','1','1494512930','1494514730','1','127.0.0.1','1','1494512930','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('57','1','1494524764','1494526564','0','127.0.0.1','1','1494524764','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('58','1','1494526734','1494528534','1','127.0.0.1','1','1494526734','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('59','1','1494852639','1494854439','1','127.0.0.1','1','1494852639','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('60','1','1494865925','1494867725','0','127.0.0.1','1','1494865925','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('61','1','1494867824','1494869624','0','127.0.0.1','1','1494867824','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('62','1','1494869678','1494871478','1','127.0.0.1','1','1494869678','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('63','1','1494966220','1494968020','1','127.0.0.1','1','1494966220','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('64','1','1495028156','1495029956','0','127.0.0.1','1','1495028156','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('65','1','1495030037','1495031837','0','127.0.0.1','1','1495030037','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('66','1','1495032039','1495033839','1','127.0.0.1','1','1495032039','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('67','1','1495126381','1495128181','1','127.0.0.1','1','1495126381','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('68','1','1495131090','1495132890','1','127.0.0.1','1','1495131090','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('69','1','1495201770','1495203570','1','127.0.0.1','1','1495201770','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('70','1','1495216233','1495218033','0','127.0.0.1','1','1495216233','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('71','1','1495218484','1495220284','1','127.0.0.1','1','1495218484','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('72','1','1495366963','1495368763','1','127.0.0.1','1','1495366963','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('73','1','1495455237','1495457037','0','127.0.0.1','1','1495455237','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('74','1','1495457437','1495459237','0','127.0.0.1','1','1495457437','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('75','1','1495460065','1495461865','1','127.0.0.1','2','1495460119','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('76','1','1495542363','1495544163','0','127.0.0.1','1','1495542363','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('77','1','1495544286','1495546086','1','127.0.0.1','1','1495544286','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('78','1','1495547203','1495549003','1','127.0.0.1','1','1495547203','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('79','1','1495550631','1495552431','1','127.0.0.1','1','1495550631','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('80','1','1495652663','1495654463','1','127.0.0.1','1','1495652663','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('81','1','1495656826','1495658626','0','127.0.0.1','1','1495656826','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('82','1','1495658657','1495660457','1','127.0.0.1','1','1495658657','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('83','1','1495806992','1495808792','0','127.0.0.1','1','1495806992','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('84','1','1495808838','1495810638','1','127.0.0.1','1','1495808838','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('85','1','1495822970','1495824770','0','127.0.0.1','1','1495822970','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('86','1','1495825178','1495826978','1','127.0.0.1','1','1495825178','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('87','1','1495827577','1495829377','0','127.0.0.1','1','1495827577','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('88','1','1495829885','1495837085','1','127.0.0.1','1','1495829885','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('89','1','1495886569','1495893769','1','127.0.0.1','1','1495886569','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('90','1','1496061426','1496068626','1','127.0.0.1','1','1496061426','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('91','1','1496083312','1496090512','1','127.0.0.1','1','1496083312','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('92','1','1496168395','1496175595','1','127.0.0.1','1','1496168395','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('93','1','1496839551','1496846751','0','127.0.0.1','1','1496839551','1496840841','127.0.0.1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('94','3','1496840847','1496848047','0','127.0.0.1','1','1496840847','1496840865','127.0.0.1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('95','1','1496840868','1496848068','0','127.0.0.1','1','1496840868','1496840918','127.0.0.1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('96','1','1496840922','1496848122','0','127.0.0.1','1','1496840922','1496840925','127.0.0.1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('97','3','1496840930','1496848130','0','127.0.0.1','1','1496840930','1496840950','127.0.0.1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('98','1','1496840954','1496848154','1','127.0.0.1','1','1496840954','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('99','1','1496941240','1496948440','0','::1','2','1496948190','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('100','1','1496948553','1496955753','1','::1','1','1496948553','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('101','1','1497362140','1497369340','1','::1','1','1497362140','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('102','1','1497370219','1497377419','0','::1','1','1497370219','1497373433','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('103','1','1498061489','1498068689','1','::1','1','1498061489','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('104','1','1498492863','1498500063','0','::1','1','1498492863','1498495764','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('105','1','1498496400','1498503600','1','::1','2','1498499011','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('106','1','1498565819','1498573019','1','::1','2','1498569202','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('107','1','1498582581','1498589781','1','::1','6','1498587410','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('108','1','1498849885','1498857085','1','::1','1','1498849885','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('109','1','1499099618','1499106818','1','::1','1','1499099618','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('110','1','1499283649','1499290849','1','::1','1','1499283649','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('111','1','1508356265','1508363465','0','::1','1','1508356265','1508360521','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('112','3','1508360528','1508367728','0','::1','1','1508360528','1508360539','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('113','1','1508791949','1508799149','0','::1','1','1508791949','1508792084','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('114','1','1508792732','1508799932','1','::1','1','1508792732','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('115','1','1511275321','1511282521','0','::1','1','1511275321','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('116','1','1516711627','1516718827','1','::1','1','1516711627','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('117','1','1517486974','1517494174','1','::1','2','1517487028','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('118','1','1518634597','1518641797','1','::1','1','1518634597','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('119','1','1518696952','1518704152','0','::1','1','1518696952','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('120','1','1518704258','1518711459','1','::1','1','1518704258','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('121','1','1518780081','1518787281','0','::1','1','1518780081','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('122','1','1518787867','1518795067','1','::1','1','1518787867','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('123','1','1519213434','1519220634','0','::1','2','1519213998','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('124','1','1519221012','1519228212','1','::1','1','1519221012','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('125','1','1519234509','1519241709','1','::1','2','1519237134','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('126','1','1519299893','1519307093','1','::1','2','1519300016','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('127','1','1519386364','1519393564','0','::1','1','1519386364','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('128','1','1519394451','1519401651','0','::1','2','1519395183','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('129','1','1519407672','1519414872','0','::1','1','1519407672','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('130','1','1519414943','1519422143','1','::1','1','1519414943','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('131','1','1519664883','1519672083','1','::1','1','1519664883','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('132','1','1519733097','1519740297','1','::1','1','1519733097','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('133','1','1519743502','1519750702','1','::1','1','1519743502','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('134','1','1519907087','1519914287','0','::1','2','1519913476','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('135','1','1519914922','1519922122','1','::1','1','1519914922','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('136','1','1520250832','1520258032','0','::1','1','1520250832','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('137','1','1520258209','1520265409','0','::1','1','1520258209','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('138','1','1520338232','1520345432','0','::1','1','1520338232','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('139','1','1520345447','1520352647','1','::1','1','1520345447','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('140','1','1520598122','1520605322','1','::1','1','1520598122','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('141','1','1520855879','1520863079','0','::1','1','1520855879','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('142','1','1520874901','1520882101','1','::1','1','1520874901','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('143','1','1521135086','1521142286','1','::1','1','1521135086','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('144','1','1521209085','1521216285','1','::1','1','1521209085','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('145','1','1521220726','1521227926','1','::1','1','1521220726','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('146','1','1521722894','1521730094','1','::1','2','1521726458','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('147','1','1522064436','1522071636','0','::1','1','1522064436','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('148','1','1522071667','1522078867','1','::1','2','1522074244','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('149','1','1522323050','1522330250','0','::1','1','1522323050','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('150','1','1522331155','1522338355','1','::1','2','1522332619','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('151','1','1523882151','1523889351','1','::1','1','1523882151','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('152','1','1524244572','1524251772','1','::1','1','1524244572','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('153','1','1524571061','1524578261','1','::1','1','1524571061','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('154','1','1524656918','1524664118','0','::1','1','1524656918','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('155','1','1524827228','1524834428','0','::1','1','1524827228','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('156','1','1524834446','1524841646','1','::1','1','1524834446','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('157','1','1525176492','1525183692','1','::1','1','1525176492','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('158','1','1525458656','1525465856','1','::1','1','1525458656','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('159','1','1525876641','1525883841','1','::1','1','1525876641','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('160','3','1527181054','1527188254','0','::1','1','1527181054','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('161','3','1527188973','1527196173','1','::1','1','1527188973','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('162','1','1527193370','1527200570','1','::1','1','1527193370','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('163','3','1527602214','1527609414','1','::1','1','1527602214','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('164','1','1528311057','1528318257','0','::1','1','1528311057','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('165','1','1528321166','1528328366','1','::1','1','1528321166','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('166','1','1528394076','1528401276','1','::1','1','1528394076','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('167','1','1528461196','1528468396','0','::1','1','1528461196','1528465764','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('168','1','1528465770','1528472970','0','::1','2','1528467354','1528467757','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('169','1','1528467762','1528474962','1','::1','1','1528467762','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('170','1','1528491121','1528498321','0','::1','1','1528491121','1528493076','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('171','1','1528493095','1528500295','0','::1','1','1528493095','1528493179','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('172','3','1528493186','1528500386','0','::1','1','1528493186','1528493198','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('173','1','1528493204','1528500404','0','::1','1','1528493204','1528493334','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('174','3','1528493341','1528500541','0','::1','1','1528493341','1528493354','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('175','1','1528493364','1528500564','1','::1','1','1528493364','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('176','3','1529095049','1529102249','0','::1','1','1529095049','1529096611','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('177','1','1529096620','1529103820','0','::1','1','1529096620','1529096709','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('178','3','1529326736','1529333936','0','::1','1','1529326736','1529327075','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('179','3','1529327083','1529334283','1','::1','1','1529327083','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('180','3','1529893701','1529900901','1','::1','1','1529893701','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('181','3','1531575780','1531582980','1','::1','1','1531575780','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('182','1','1532632687','1532639887','0','::1','1','1532632687','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('183','1','1532642081','1532649281','1','::1','1','1532642081','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('184','3','1534596623','1534603823','1','::1','1','1534596623','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('185','3','1534940681','1534947881','0','::1','1','1534940681','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('186','3','1535027861','1535035061','0','::1','1','1535027861','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('187','3','1535046500','1535053700','1','::1','1','1535046500','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('188','3','1535133471','1535140671','0','::1','1','1535133471','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('189','3','1535140921','1535148121','1','::1','1','1535140921','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('190','3','1535394446','1535401646','0','::1','1','1535394446','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('191','3','1535401838','1535409038','1','::1','1','1535401838','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('192','3','1538446143','1538453343','0','::1','1','1538446143','1538446922','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('193','3','1538529384','1538536584','0','::1','1','1538529384','1538529560','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('194','3','1538530175','1538537375','0','::1','1','1538530175','1538530217','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('195','3','1538530753','1538537953','1','::1','1','1538530753','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('196','3','1538567200','1538574400','1','::1','1','1538567200','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('197','3','1538585176','1538592376','0','::1','1','1538585176','1538586778','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('198','3','1538594982','1538602182','0','::1','1','1538594982','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('199','3','1538602348','1538609548','0','::1','1','1538602348','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('200','3','1538609625','1538616825','1','::1','1','1538609625','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('201','3','1538653655','1538660855','0','::1','1','1538653655','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('202','3','1538661039','1538668239','0','::1','1','1538661039','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('203','3','1538680494','1538687694','0','::1','1','1538680494','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('204','3','1538687714','1538694914','1','::1','2','1538687717','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('205','1','1538695018','1538702218','0','::1','1','1538695018','1538695095','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('206','3','1538695104','1538698704','0','::1','1','1538695104','1538695142','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('207','3','1538695357','1538698957','1','::1','1','1538695357','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('208','3','1538703113','1538706713','0','::1','1','1538703113','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('209','3','1538706787','1538710387','1','::1','1','1538706787','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('210','3','1538736297','1538739897','0','::1','1','1538736297','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('211','3','1538739918','1538743518','0','::1','1','1538739918','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('212','3','1538743557','1538747157','0','::1','1','1538743557','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('213','3','1538747839','1538751439','0','::1','2','1538749199','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('214','3','1538751577','1538755177','0','::1','2','1538752788','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('215','3','1538759651','1538763251','1','::1','1','1538759651','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('216','3','1538767212','1538770812','0','::1','1','1538767212','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('217','3','1538771034','1538774634','0','::1','1','1538771034','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('218','3','1538774654','1538778254','0','::1','1','1538774654','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('219','3','1538778310','1538781910','0','::1','2','1538779193','1538779227','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('220','3','1538779677','1538783277','1','::1','1','1538779677','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('221','3','1538789212','1538792812','0','::1','1','1538789212','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('222','3','1538792850','1538796450','0','::1','1','1538792850','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('223','3','1538796502','1538800102','1','::1','1','1538796502','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('224','3','1538823379','1538826979','0','::1','1','1538823379','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('225','3','1538827012','1538830612','0','::1','1','1538827012','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('226','3','1538830722','1538834322','0','::1','1','1538830722','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('227','3','1538834671','1538838271','0','::1','2','1538835916','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('228','3','1538838958','1538842558','0','::1','1','1538838958','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('229','3','1539002759','1539006359','0','::1','1','1539002759','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('230','3','1539006416','1539010016','0','::1','2','1539008547','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('231','3','1539010171','1539013771','0','::1','1','1539010171','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('232','3','1539026532','1539030132','0','::1','1','1539026532','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('233','3','1539030204','1539033804','0','::1','1','1539030204','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('234','3','1539033824','1539037424','0','::1','1','1539033824','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('235','3','1539037495','1539041095','0','::1','1','1539037495','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('236','3','1539041118','1539044718','0','::1','1','1539041118','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('237','1','1539053686','1539057286','0','::1','1','1539053686','1539053773','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('238','3','1539082027','1539100027','1','::1','2','1539096686','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('239','3','1539116106','1539134106','0','::1','2','1539130791','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('240','3','1539136127','1539154127','0','::1','1','1539136127','1539136166','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('241','3','1539169003','1539187003','0','::1','1','1539169003','1539186531','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('242','1','1539186613','1539204613','0','::1','1','1539186613','1539186706','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('243','3','1539201587','1539249587','0','::1','1','1539201587','1539219451','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('244','3','1539259764','1539307764','0','::1','2','1539287395','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('245','3','1539346422','1539394422','1','::1','4','1539393323','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('246','3','1539432713','1539480713','1','::1','2','1539454637','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('247','3','1539538348','1539586348','0','::1','1','1539538348','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('248','3','1539640999','1539688999','0','::1','1','1539640999','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('249','3','1539692900','1539740900','1','::1','3','1539719474','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('250','3','1539776664','1539824664','1','::1','2','1539804974','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('251','3','1539865944','1539913944','1','::1','2','1539892537','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('252','3','1539953042','1540001042','1','::1','2','1539978314','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('253','3','1540037406','1540085406','0','::1','2','1540079981','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('254','3','1540130459','1540178459','1','::1','1','1540130459','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('255','3','1540209468','1540257468','1','::1','3','1540238024','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('256','3','1540296405','1540344405','1','::1','2','1540326812','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('257','3','1540382030','1540430030','1','::1','2','1540410797','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('258','3','1540468229','1540516229','1','::1','4','1540509430','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('259','3','1540555007','1540603007','1','::1','2','1540582916','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('260','3','1540642341','1540690341','1','::1','1','1540642341','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('261','3','1540734383','1540782383','1','::1','1','1540734383','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('262','3','1540792451','1540840451','1','::1','2','1540813727','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('263','3','1540842431','1540890431','1','::1','1','1540842431','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('264','3','1540898395','1540946395','1','::1','2','1540928987','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('265','3','1540988736','1541036736','1','::1','3','1541027954','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('266','3','1541072971','1541120971','1','::1','2','1541100979','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('267','3','1541157862','1541205862','1','::1','3','1541184137','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('268','3','1541248054','1541296054','1','::1','3','1541260938','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('269','3','1541339732','1541387732','1','::1','2','1541381575','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('270','3','1541418478','1541466478','1','::1','2','1541447694','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('271','3','1541506959','1541554959','1','::1','3','1541534165','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('272','3','1541592944','1541640944','1','::1','3','1541619388','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('273','3','1541679767','1541727767','1','::1','3','1541717005','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('274','3','1541765046','1541813046','1','::1','2','1541794896','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('275','3','1541849601','1541897601','1','::1','2','1541860435','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('276','3','1542023892','1542071892','1','::1','2','1542050863','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('277','3','1542108390','1542156390','1','::1','3','1542151120','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('278','3','1542194450','1542242450','1','::1','3','1542231870','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('279','3','1542281492','1542329492','1','::1','2','1542310062','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('280','3','1542366630','1542414630','1','::1','2','1542396869','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('281','3','1542457129','1542505129','1','::1','1','1542457129','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('282','3','1542551710','1542599710','0','::1','1','1542551710','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('283','3','1542627260','1542675260','1','::1','1','1542627260','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('284','3','1542712521','1542760521','1','::1','4','1542739489','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('285','3','1542800386','1542848386','1','::1','2','1542829334','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('286','3','1542883697','1542931697','1','::1','2','1542914880','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('287','3','1542972911','1543020911','1','::1','2','1543005467','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('288','3','1543059174','1543107174','1','::1','1','1543059174','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('289','3','1543162328','1543210328','0','::1','2','1543164722','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('290','3','1543233788','1543281788','1','::1','2','1543259393','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('291','3','1543320157','1543368157','0','::1','2','1543348310','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('292','3','1543402731','1543450731','1','::1','4','1543433613','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('293','3','1543494158','1543542158','1','::1','2','1543520265','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('294','3','1543577827','1543625827','1','::1','2','1543608366','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('295','3','1543665486','1543713486','1','::1','2','1543665993','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('296','3','1543835388','1543883388','1','::1','2','1543866590','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('297','3','1543884726','1543932726','0','::1','1','1543884726','1543885010','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('298','3','1543923034','1543971034','1','::1','3','1543952427','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('299','3','1544008483','1544056483','1','::1','2','1544038220','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('300','3','1544099361','1544147361','1','::1','2','1544125545','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('301','3','1544181294','1544229294','1','::1','3','1544202005','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('302','3','1544280218','1544328218','1','::1','1','1544280218','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('303','3','1544442804','1544490804','1','::1','3','1544482627','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('304','3','1544529489','1544577489','1','::1','4','1544557837','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('305','3','1544615467','1544663467','0','::1','3','1544650417','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('306','3','1544703328','1544751328','1','::1','3','1544731232','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('307','3','1544789250','1544837250','1','::1','2','1544816790','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('308','3','1544875522','1544923522','1','::1','1','1544875522','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('309','3','1545048181','1545096181','1','::1','2','1545075050','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('310','3','1545134547','1545182547','0','::1','2','1545162666','1545176868','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('311','1','1545176876','1545224876','0','::1','1','1545176876','1545176982','::1');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('312','3','1545176991','1545224991','0','::1','3','1545223147','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('313','3','1545227661','1545275661','1','::1','2','1545248577','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('314','3','1545307098','1545355098','1','::1','2','1545334615','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('315','3','1545392102','1545440102','1','::1','3','1545437374','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('316','3','1545482013','1545530013','1','::1','2','1545515840','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('317','3','1545653135','1545701135','1','::1','1','1545653135','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('318','3','1545826525','1545874525','1','::1','2','1545853042','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('319','3','1545912108','1545960108','1','::1','1','1545912108','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('320','3','1546000019','1546048019','1','::1','3','1546026083','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('321','3','1546085715','1546133715','1','::1','1','1546085715','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('322','3','1546193779','1546241779','1','::1','1','1546193779','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('323','3','1546257895','1546305895','1','::1','2','1546291487','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('324','3','1546429069','1546477069','1','::1','1','1546429069','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('325','3','1546518722','1546566722','1','::1','2','1546545780','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('326','3','1546601805','1546649805','1','::1','2','1546633254','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('327','3','1546690125','1546738125','0','::1','1','1546690125','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('328','3','1546863207','1546911207','1','::1','2','1546890997','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('329','3','1546947954','1546995954','1','::1','2','1546975444','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('330','3','1547034256','1547082256','1','::1','2','1547064027','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('331','3','1547120084','1547168084','1','::1','2','1547148913','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('332','3','1547205281','1547253281','1','::1','2','1547236475','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('333','3','1547292589','1547340589','1','::1','1','1547292589','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('334','3','1547464955','1547512955','1','::1','2','1547495846','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('335','3','1547553760','1547601760','1','::1','3','1547582267','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('336','3','1547638748','1547686748','1','::1','3','1547668707','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('337','3','1547727333','1547775333','1','::1','2','1547755925','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('338','3','1547812753','1547860753','1','::1','2','1547839258','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('339','3','1547898700','1547946700','1','::1','1','1547898700','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('340','3','1548071160','1548119160','1','::1','2','1548100693','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('341','3','1548158142','1548206142','1','::1','2','1548187100','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('342','3','1548243203','1548291203','1','::1','3','1548272290','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('343','3','1548332523','1548380523','1','::1','1','1548332523','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('344','3','1548417235','1548465235','1','::1','2','1548445931','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('345','3','1548677396','1548725396','1','::1','3','1548705812','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('346','3','1548762381','1548810381','1','::1','2','1548791951','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('347','3','1548849572','1548897572','1','::1','2','1548876562','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('348','3','1548937099','1548985099','1','::1','2','1548963434','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('349','3','1549019943','1549067943','1','::1','2','1549050014','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('350','3','1549109162','1549157162','1','::1','2','1549112687','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('351','3','1549280491','1549328491','1','::1','2','1549309501','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('352','3','1549368733','1549416733','1','::1','2','1549398756','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('353','3','1549452639','1549500639','1','::1','2','1549481440','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('354','3','1549540230','1549588230','1','::1','2','1549569867','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('355','3','1549626833','1549674833','1','::1','2','1549656769','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('356','3','1549714933','1549762933','1','::1','1','1549714933','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('357','3','1549885633','1549933633','1','::1','2','1549914856','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('358','3','1549973188','1550021188','1','::1','3','1550011714','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('359','3','1550059066','1550107066','1','::1','2','1550087707','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('360','3','1550145231','1550193231','1','::1','2','1550176355','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('361','3','1550232483','1550280483','1','::1','3','1550260002','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('362','3','1550318347','1550366347','1','::1','1','1550318347','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('363','3','1550374754','1550422754','1','::1','1','1550374754','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('364','3','1550490881','1550538881','1','::1','2','1550518552','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('365','3','1550577069','1550625069','1','::1','2','1550606569','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('366','3','1550663604','1550711604','1','::1','2','1550692247','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('367','3','1550752972','1550800972','1','::1','2','1550779065','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('368','3','1550835600','1550883600','1','::1','2','1550865560','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('369','3','1550924167','1550972167','1','::1','1','1550924167','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('370','3','1551096544','1551144544','1','::1','1','1551096544','','');
INSERT INTO `cruge_session` (`idsession`,`iduser`,`created`,`expire`,`status`,`ipaddress`,`usagecount`,`lastusage`,`logoutdate`,`ipaddressout`) VALUES
('371','3','1551181407','1551229407','1','::1','1','1551181407','','');



-- -------------------------------------------
-- TABLE DATA cruge_system
-- -------------------------------------------
INSERT INTO `cruge_system` (`idsystem`,`name`,`largename`,`sessionmaxdurationmins`,`sessionmaxsameipconnections`,`sessionreusesessions`,`sessionmaxsessionsperday`,`sessionmaxsessionsperuser`,`systemnonewsessions`,`systemdown`,`registerusingcaptcha`,`registerusingterms`,`terms`,`registerusingactivation`,`defaultroleforregistration`,`registerusingtermslabel`,`registrationonlogin`) VALUES
('1','default','','800','10','1','-1','-1','0','0','0','0','','0','','','1');



-- -------------------------------------------
-- TABLE DATA cruge_user
-- -------------------------------------------
INSERT INTO `cruge_user` (`iduser`,`regdate`,`actdate`,`logondate`,`username`,`email`,`password`,`authkey`,`state`,`totalsessioncounter`,`currentsessioncounter`) VALUES
('1','','','1545176876','admin','admin@tucorreo.com','arc1030q','','1','0','0');
INSERT INTO `cruge_user` (`iduser`,`regdate`,`actdate`,`logondate`,`username`,`email`,`password`,`authkey`,`state`,`totalsessioncounter`,`currentsessioncounter`) VALUES
('2','','','','invitado','invitado','nopassword','','1','0','0');
INSERT INTO `cruge_user` (`iduser`,`regdate`,`actdate`,`logondate`,`username`,`email`,`password`,`authkey`,`state`,`totalsessioncounter`,`currentsessioncounter`) VALUES
('3','1496061483','','1551181407','dargenti','diegoargenti@hotmail.com','vidaanimal','042a196ab4effabdd912719c54b08b4d','1','0','0');



-- -------------------------------------------
-- TABLE DATA diagnosticocomplementario
-- -------------------------------------------
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('1','1','CCCCCCCCCC','190715149611987193_853289494767839_3937611378075080522_n.jpg','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('2','8','HEMOGRAMA .','819184260Hemograma Argenti 16.348.pdf','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('3','332','','1423790033Hemograma Argenti 16.535.pdf','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('5','501','ANALISIS SANGUINEO','1241074427Leptospirosis Argenti 16.671.pdf','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('6','431','PERFIL TIROIDEO 1','836830974Hormonas Argenti 16.652 (1).pdf','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('7','431','PERFIL TIROIDEO 2','2072373135Hormonas Argenti 16.652.pdf','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('8','662','CONTROL PREQUIRURGICO','980892466Hemograma Argenti 16.825.pdf','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('9','665','POLIURIA','1126205684Hemograma Argenti 16.839.pdf','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('10','1112','PREQUIRURGICO','1568420941Hemograma Argenti 17.005.pdf','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('12','1178','CONTROL 1','2132060820Hemograma Argenti 17.066 (1).pdf','1');
INSERT INTO `diagnosticocomplementario` (`iddiagnosticoComplementario`,`consulta_idconsulta`,`descripcion`,`archivo`,`estado`) VALUES
('13','1195','CONTROL ANUAL 1','637241510Hemograma y Brucelosisi Argenti 17.077.pdf','1');



-- -------------------------------------------
-- TABLE DATA especie
-- -------------------------------------------
INSERT INTO `especie` (`idespecie`,`nombre`,`estado`) VALUES
('1','CANINO','1');
INSERT INTO `especie` (`idespecie`,`nombre`,`estado`) VALUES
('2','FELINO','1');



-- -------------------------------------------
-- TABLE DATA localidad
-- -------------------------------------------
INSERT INTO `localidad` (`idlocalidad`,`codigoPostal`,`provincia_idprovincia`,`nombre`,`estado`) VALUES
('1','5800','28','RIO CUARTO','1');
INSERT INTO `localidad` (`idlocalidad`,`codigoPostal`,`provincia_idprovincia`,`nombre`,`estado`) VALUES
('2','5807','28','CHARRAS','1');
INSERT INTO `localidad` (`idlocalidad`,`codigoPostal`,`provincia_idprovincia`,`nombre`,`estado`) VALUES
('3','5805','28','HIGUERAS','1');
INSERT INTO `localidad` (`idlocalidad`,`codigoPostal`,`provincia_idprovincia`,`nombre`,`estado`) VALUES
('4','5000','28','CORDOBA','1');



-- -------------------------------------------
-- TABLE DATA marca
-- -------------------------------------------
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('1','TRITON','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('2','ANIMAL STEREO N 1 Y 2','2','0');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('3','ANIMAL STEREO ','2','0');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('4','ANIMAL STEREO ','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('5','SIN MARCA','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('6','FORTALEZA','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('7','NAMHUT','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('8','CORRECAMINOS','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('9','FIEL','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('10','HOLLIDAY','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('11','VARIOS','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('12','CX 1000','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('13','PORTA','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('14','ALGEN','1','0');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('15','RICHMOND','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('16','GENERICO','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('17','INSTITUTO DERMATOLOGICO','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('18','ACME','4','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('19','ZOETIS','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('20','ATMAN','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('21','IMVI','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('22','KONIG','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('23','PERROS','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('24','JANVIER','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('25','ATON','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('26','NUTRINAL','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('27','PURINAS','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('28','EL MOLINO ','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('29','NATURE','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('30','MASEGRAL','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('31','OLD PRINCE','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('32','ROYAL CANIN','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('33','BALLADARES','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('34','GUIAR ','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('35','ALICAN ','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('36','NO POSEE','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('37','RIO DE JANEIRO','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('38','TODOS','5','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('39','KUALCOS','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('40','DELENTE','6','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('41','GELTEK','5','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('42','STORM','5','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('43','HORTAL','5','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('44','GLACOXAN','5','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('45','MUSTAD','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('46','DERBY','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('47','EL CHAJA','4','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('48','SUPREMO','4','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('49','ARBOLITO','4','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('50','SCHMIEDEN','4','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('51','JM','4','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('52','SIN MARCA','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('53','VETUE','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('54','BROWER','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('55','LAMAR','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('56','LABYES','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('57','NORT','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('58','YOUNG','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('59','AFFORD','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('60','MERIAL','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('61','OSSPRET','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('62','ELANCO','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('63','HOLLIDAY','3','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('64','OSSPRET','2','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('65','RUMINAL','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('66','SIN MARCA','6','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('67','SIN MARCA','4','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('68','LAIKA','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('69','ECOWORLD','5','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('70','INMUNOVET','1','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('71','TRENTO','4','1');
INSERT INTO `marca` (`idmarca`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('72','MAYORS','1','1');



-- -------------------------------------------
-- TABLE DATA paciente
-- -------------------------------------------
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('1','1','CHERRY','','1','1','Macho','2018-10-01','','','1375706229IMG-20180914-WA0062.jpg','0');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('2','2','RAMONA','','1','1','Hembra','2018-02-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('3','3','DAKI','','1','1','Hembra','2009-05-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('4','4','NEGRITO','','1','1','Macho','2018-02-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('5','5','MAICON','','1','1','Macho','2011-03-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('6','6','TOTO','','1','1','Macho','2007-06-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('7','7','VITO','','1','1','Hembra','2018-07-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('8','8','UMA','','1','1','Hembra','2018-07-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('9','9','RUMA','','1','8','Hembra','2015-05-07','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('10','10','LEO','','1','8','Macho','2016-11-27','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('11','10','FELIPE','','1','8','Macho','2012-06-16','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('12','12','BLACK','','1','1','Macho','2018-08-08','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('13','10','FLORA','','2','42','Hembra','2018-08-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('14','11','ROCKO','','1','22','Macho','2012-08-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('15','13','MORENA','','1','11','Hembra','2011-04-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('16','14','BASTIAN','','1','9','Macho','2018-07-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('17','17','MONONA','','1','21','Hembra','2006-06-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('18','17','PANCHO','','1','1','Macho','2017-02-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('19','17','NEGRA','','1','1','Hembra','2018-04-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('20','17','LARA','','1','8','Hembra','2015-03-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('21','18','MILO','','1','1','Macho','2014-02-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('22','19','PINTA','','1','1','Hembra','2018-05-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('23','20','FARA','','1','8','Hembra','2015-01-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('24','21','BAUTISTA','','1','8','Macho','2014-05-26','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('25','22','PRECIOSA','','1','25','Hembra','2014-02-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('26','24','DUKE','','1','1','Macho','2018-06-13','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('27','23','DANA','','1','9','Hembra','2014-09-03','CASTRADA','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('28','25','ONA','','1','9','Hembra','2014-01-08','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('29','26','BLAKIE','','1','8','Hembra','2015-05-05','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('30','27','MAIA','','1','1','Hembra','2016-04-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('31','27','MAIA','','1','1','Macho','2016-04-10','','','avatar_azul.png','0');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('32','28','APOLO','','1','1','Macho','2016-03-13','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('33','29','DOBY','','1','1','Macho','2018-06-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('34','30','CHARLY','','1','1','Macho','2018-08-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('35','31','JONY','','1','19','Macho','2009-10-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('36','32','SIMON','','2','42','Macho','2018-09-07','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('37','33','TITI','','2','42','Hembra','2013-12-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('38','34','KIARA','','1','8','Hembra','2017-07-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('39','35','SAMARA','','1','1','Hembra','2018-07-08','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('40','36','POMELO','','1','1','Macho','2016-01-17','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('41','36','RINGO','','1','1','Macho','2014-11-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('42','37','CHICHO','','1','8','Macho','2014-07-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('43','38','FITO','','1','8','Macho','2017-07-17','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('44','37','CHICHA','','1','1','Hembra','2013-07-07','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('45','39','LUNA','','1','8','Hembra','2015-08-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('46','39','FELIPE','','1','8','Macho','2014-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('47','39','BIANCA','','1','8','Hembra','2015-02-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('48','39','BLACK','','1','8','Macho','2014-01-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('49','40','BEETHOVEN','','1','2','Macho','2017-08-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('50','8','GENESIS','','1','14','Hembra','2014-03-13','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('51','41','LOLA','','2','42','Hembra','2017-02-05','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('52','42','ROCO','','1','8','Macho','2013-07-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('53','41','LUPE','','1','1','Hembra','2014-01-23','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('54','7','COOCKIE','','1','1','Macho','2012-09-13','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('55','41','FLASH','','1','1','Macho','2018-05-08','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('56','21','REX','','1','1','Macho','2012-01-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('57','43','NERON','','1','1','Macho','2017-05-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('58','44','SANTINA','','1','43','Hembra','2014-11-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('59','44','MORA','','1','43','Hembra','2018-01-17','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('60','45','MILO','','2','39','Macho','2018-08-05','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('61','46','ARIA','','2','42','Hembra','2018-09-25','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('62','47','MAMU','','2','42','Hembra','2018-02-15','','CASTRADA','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('63','47','LUCI','','1','25','Hembra','2015-02-06','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('64','48','JIMMY','','1','1','Macho','2010-05-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('65','49','PIPO','','1','8','Macho','2009-02-02','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('66','49','FATIGA','','1','8','Macho','2016-10-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('67','50','HASTON','','1','3','Macho','2008-06-17','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('68','51','CANDY','','1','8','Hembra','2006-06-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('69','52','CAROLA','','1','1','Hembra','2015-06-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('70','52','CRISTAL','','2','42','Hembra','2016-02-10','','CASTRADA','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('71','52','ROCCO','','1','11','Macho','2013-11-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('72','53','MARTIN','','2','42','Macho','2011-03-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('73','54','LIO','','1','8','Macho','2017-07-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('74','54','PICHU','','1','1','Macho','2010-02-09','','CASTRADO','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('75','55','MIKIKI','','2','42','Hembra','2011-06-08','','CASTRADA','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('76','56','PANCHO','','1','11','Macho','2013-02-12','','CRIPTORQUIDO','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('77','57','CATALINA','','1','11','Hembra','2016-03-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('78','58','AMELIA','','1','8','Hembra','2018-09-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('79','58','BENICIO','','1','8','Macho','2015-07-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('80','58','BENJAMIN','','1','8','Macho','2004-02-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('81','59','WILLIAM','','1','15','Macho','2017-06-08','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('82','60','CHIPITA','','1','1','Hembra','2004-07-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('83','59','CRYCSUS','','1','44','Macho','2017-02-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('84','59','NERON','','1','22','Macho','2016-11-26','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('85','59','AKIRA','','1','22','Hembra','2017-11-29','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('86','59','WILLIAM','','1','15','Macho','2017-06-08','','','avatar_azul.png','0');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('87','61','ROQUE','','2','42','Macho','2013-07-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('88','61','JORGE','','2','42','Macho','2015-02-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('89','61','ATILIO','','2','42','Macho','2017-01-02','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('90','62','CATA','','2','42','Hembra','2014-09-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('91','64','PANCHA','','1','1','Hembra','2016-10-11','','CASTRADA','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('92','63','TITAN','','1','45','Macho','2011-09-07','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('93','65','LARA','','1','22','Hembra','2008-08-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('94','65','EMMA','','1','1','Hembra','2011-02-08','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('95','66','ODIE','','1','8','Macho','2012-09-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('96','67','TRUENO','','1','6','Macho','2017-05-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('97','68','BLACKIE','','1','1','Macho','2007-05-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('98','68','PATRICIO','','1','1','Macho','2013-06-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('99','18','MIKA','','2','42','Hembra','2018-09-24','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('100','69','PERLA','','1','1','Hembra','2004-03-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('101','70','TINCHO','','1','1','Macho','2016-12-15','MESTIZO CON MALTES','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('102','71','COKI','','1','1','Macho','2018-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('103','72','KATO','','1','3','Macho','2016-12-17','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('104','73','SKYPE','','1','8','Macho','2016-06-24','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('105','74','SIN NOMBRE','','1','22','Hembra','2018-10-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('106','75','ROLO','','2','42','Macho','2004-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('107','75','KITA','','2','42','Hembra','2010-02-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('108','75','FLORA','','2','42','Hembra','2012-10-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('109','75','FLORA','','2','42','Hembra','2012-10-04','','','avatar_azul.png','0');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('110','76','BRUMA','','1','1','Hembra','2015-08-05','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('111','77','FILOMENA','','1','1','Hembra','2014-01-23','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('112','77','INDIA','','1','1','Hembra','2016-11-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('113','78','FRIDA','','1','8','Hembra','2010-10-28','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('114','79','AIKA','','2','42','Hembra','2016-08-23','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('115','79','MATILDA','','1','9','Hembra','2007-12-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('116','79','AVVY','','2','42','Hembra','2015-02-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('117','80','CANELA','','1','1','Hembra','2015-07-23','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('118','81','INCA','','1','3','Hembra','2012-07-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('119','82','RULO','','1','8','Macho','2013-07-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('120','83','MAX','','1','1','Macho','2017-01-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('121','84','DANIEL','','1','1','Macho','2009-06-16','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('122','85','LINDA','','2','42','Macho','2013-02-05','','CASTRADO','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('123','51','AGUSTIN','','1','8','Macho','2017-12-13','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('124','86','MANCHI','','1','1','Hembra','2018-10-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('125','87','TOBY','','1','8','Macho','2006-02-07','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('126','88','BEBE','','1','1','Hembra','2016-07-02','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('127','88','DIXI','','1','1','Hembra','2018-10-08','CRUZA CON COLIE','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('128','89','ALFONSINA','','2','42','Hembra','2012-06-05','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('129','90','MENTA','','1','43','Hembra','2018-01-25','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('130','91','MILO','','1','4','Macho','2016-05-28','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('131','92','TOBY','','1','1','Macho','2016-08-17','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('132','93','BAYO','','2','42','Macho','2018-10-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('133','94','LUPE','','1','1','Hembra','2016-07-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('134','95','BRISA','','1','3','Hembra','2012-09-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('135','96','MATEO','','1','1','Macho','2009-07-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('136','97','ZULE','','1','11','Hembra','2018-09-27','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('137','98','MICHU','','2','42','Macho','2016-10-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('138','98','LADY SOL','','2','42','Hembra','2018-09-28','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('139','99','JUANA','','1','45','Hembra','2009-08-13','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('140','99','LENY ','','1','8','Macho','2002-07-23','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('141','99','INTI','','1','23','Macho','2005-07-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('142','99','ZOE','','1','8','Hembra','2007-07-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('143','100','MILO','','1','1','Macho','2018-10-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('144','101','SIMONA','','1','1','Hembra','2018-10-10','CRUZA BEAGLE CON SALCHICHA','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('145','102','CANELA','','1','8','Hembra','2017-01-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('146','103','CLOE','','1','14','Hembra','2017-11-21','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('147','103','LUPE','','1','14','Hembra','2015-08-29','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('148','104','MILI','','2','42','Hembra','2016-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('149','104','MILO','','2','42','Macho','2014-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('150','105','CATU','','2','42','Macho','2014-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('151','105','LUNA','','2','42','Hembra','2017-05-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('152','105','CHOCOLATE','','1','1','Macho','2010-11-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('153','106','LOLA','','1','19','Hembra','2016-08-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('154','107','KAISER','','1','26','Macho','2008-07-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('155','108','TIMON','','1','11','Macho','2018-09-27','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('156','109','ROCKY','','1','1','Macho','2018-10-25','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('157','110','LUCILA','','2','42','Hembra','1970-01-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('158','110','LEONEL','','1','8','Macho','2015-05-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('159','111','HANO','','1','8','Macho','2011-10-11','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('160','112','LOLA','','1','8','Hembra','2018-10-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('161','113','IVO','','1','1','Macho','2008-12-23','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('162','114','TONI','','1','33','Macho','2018-09-26','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('163','115','DIZZY','','1','1','Hembra','2011-11-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('164','116','OLIVIA','','1','1','Hembra','2018-08-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('165','117','CIRO','','1','3','Macho','2012-01-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('166','117','PATAN','','1','46','Macho','2015-01-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('167','118','NERON','','1','1','Macho','2017-08-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('168','119','ROMEO','','1','1','Macho','2014-05-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('169','120','LULA','','1','1','Hembra','2009-08-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('170','121','CAROLO','','2','39','Macho','2012-07-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('171','82','TITAN','','1','1','Macho','2016-07-27','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('172','122','COTI','','1','8','Hembra','2009-05-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('173','123','OREO','','2','42','Macho','2018-11-07','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('174','124','SIRAH','','1','34','Hembra','2013-08-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('175','125','SUYAN','','1','1','Hembra','2017-10-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('176','125','CLEOTILDE','','2','42','Hembra','2017-01-11','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('177','125','KALA','','1','25','Hembra','2012-07-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('178','125','KIARA','','1','7','Hembra','2010-06-17','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('179','126','LOLA','','1','11','Hembra','2018-10-31','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('180','127','CHINO','','2','42','Macho','2014-06-10','','CASTRADO','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('181','128','CHIQUITITA','','1','1','Hembra','2012-11-07','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('182','129','LOLITA','','1','8','Hembra','2013-03-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('183','130','ALF','','1','1','Macho','2017-03-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('184','131','GRINGO','','1','38','Macho','2012-08-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('185','132','CATALINA','','1','1','Hembra','2002-08-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('186','132','ANGRA','','2','42','Hembra','2017-11-02','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('187','132','KAO','','1','1','Macho','2009-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('188','133','MIA','','1','26','Hembra','2014-09-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('189','134','WARA','','1','47','Hembra','2014-06-28','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('190','135','OLIVIA','','1','22','Hembra','2018-10-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('191','136','GALA','','1','11','Hembra','2017-02-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('192','136','VINCENT','','1','11','Hembra','2018-09-27','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('193','136','DALI','','1','11','Hembra','2018-09-27','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('194','137','TOFI','','1','8','Macho','2014-01-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('195','138','FIONA','','1','29','Hembra','2006-05-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('196','139','COPITO','','1','8','Macho','2018-08-30','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('197','139','BALTAZAR','','1','22','Macho','2018-11-25','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('198','140','PEETER','','1','8','Macho','2010-09-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('199','105','MAIA','','1','1','Hembra','2006-06-13','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('200','141','HUACO','','1','45','Macho','2011-04-16','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('201','142','CHINO','','2','42','Macho','2018-09-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('202','143','SOL','','1','8','Hembra','2017-06-26','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('203','144','MIEL','','1','1','Hembra','2018-11-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('204','144','SIMON','','1','1','Macho','2018-11-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('205','144','PAPI','','1','1','Macho','2010-12-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('206','144','MORA','','1','1','Hembra','2017-12-06','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('207','144','FIONA','','1','1','Hembra','2016-12-01','OVARIECTOMIA','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('208','145','KEILO','','1','1','Macho','2015-05-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('209','146','BORIS','','1','19','Macho','2009-07-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('210','147','ESPIQUE','','1','1','Macho','2018-11-25','','','avatar_azul.png','0');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('211','147','ALEM','','1','2','Hembra','2015-12-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('212','148','CIRILA','','1','43','Hembra','2010-06-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('213','149','SIN NOMBRE','','2','42','Macho','2014-06-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('214','150','PANCHO','','1','1','Macho','2016-09-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('215','151','MORENA','','1','2','Hembra','2015-09-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('216','152','PINI','','1','1','Hembra','2007-06-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('217','153','MOLLO','','1','1','Macho','2016-07-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('218','153','NEGRO','','1','1','Macho','2008-06-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('219','154','ROCKI','','1','1','Macho','2007-11-07','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('220','154','COCO','','1','8','Macho','2012-06-25','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('221','155','JUAN','','1','1','Macho','2019-11-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('222','156','LUNA','','1','9','Hembra','2015-12-10','','OVARIECTOMIA','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('223','157','JUANA','','1','11','Hembra','2016-06-21','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('224','157','BJORN','','1','11','Macho','2018-09-27','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('225','157','BAGNAC','','1','11','Macho','2017-11-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('226','158','MULAN','','1','8','Macho','2011-05-29','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('227','158','TOTO','','1','8','Macho','2010-03-24','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('228','159','BUGUI','','1','8','Macho','2016-08-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('229','159','NEGRO','','1','8','Macho','2010-06-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('230','159','DALMA','','1','3','Hembra','2017-10-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('231','160','MOMO','','1','11','Macho','2018-11-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('232','161','SULTAN','','1','6','Macho','2018-11-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('233','162','BINGO','','1','11','Macho','2018-10-31','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('234','126','BLANCA','','1','8','Hembra','2012-11-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('235','163','TOMY','','1','8','Macho','2006-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('236','164','TIN','','1','12','Hembra','2018-07-05','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('237','57','BENJY','','1','11','Macho','2018-10-31','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('238','57','MANCHITA','','1','11','Hembra','2018-10-31','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('239','165','ELI','','1','9','Hembra','2017-09-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('240','59','JUNIOR','','1','22','Macho','2018-09-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('241','166','ELVIS','','2','42','Macho','2017-09-19','CASTRADO','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('242','167','JACINTO','','1','7','Macho','2011-07-21','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('243','168','TITINA','','2','42','Hembra','2014-03-04','CASTRADA','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('244','169','LOBO','','1','27','Macho','2018-05-16','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('245','170','TEO','','2','42','Macho','2018-11-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('246','171','PAZ','','1','11','Hembra','2018-10-31','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('247','172','MILO','','1','1','Macho','2018-11-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('248','173','BRANDI','','1','25','Hembra','2015-02-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('249','173','LIZZY','','1','1','Hembra','2005-12-13','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('250','173','UMA','','1','17','Hembra','2014-12-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('251','174','BARACK','','1','4','Macho','2018-09-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('252','175','LIZ','','1','1','Hembra','2008-06-17','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('253','175','ANGELA','','1','1','Hembra','2017-11-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('254','176','RAGNER','','1','11','Hembra','2018-08-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('255','177','ESPUMA','','2','42','Hembra','2013-06-25','CASTRADA','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('256','178','LUNA','','1','6','Hembra','2012-11-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('257','179','COQUI','','1','1','Macho','2018-08-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('258','180','TEDDY','','1','8','Macho','1970-01-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('259','181','LOLA','','1','8','Hembra','2017-12-16','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('260','182','COCO','','2','42','Macho','2016-08-23','CASTRADO','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('261','182','INDIA','','1','8','Hembra','2016-05-04','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('262','182','MICHA','','2','42','Hembra','2009-06-16','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('263','183','ELVIS','','2','39','Macho','2007-06-19','CASTRADO','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('264','184','SIMON','','1','15','Macho','2018-10-30','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('265','116','SOFIA','','1','11','Hembra','2011-06-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('266','185','LIBERTAD','','1','1','Hembra','2018-11-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('267','186','LUNA','','1','45','Hembra','2018-07-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('268','187','LORENA','','1','1','Hembra','2007-07-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('269','188','BELLA','','1','19','Hembra','2011-06-24','CASTRADA','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('270','188','MIA','','1','19','Hembra','2013-09-05','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('271','189','HARA','','1','46','Hembra','2011-12-24','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('272','189','PACHI','','1','1','Hembra','2010-06-15','CASTRADA','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('273','190','PACO','','1','18','Macho','2018-12-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('274','191','GOHAN','','1','1','Macho','2016-07-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('275','191','MORITA','','1','1','Macho','2016-07-09','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('276','192','HARVEY','','1','6','Macho','2018-09-25','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('277','193','FRIDA','','1','1','Hembra','2018-03-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('278','194','HIBRIS','','1','7','Macho','2013-08-23','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('279','195','TAO','','1','4','Macho','2017-01-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('280','195','LULI','','1','8','Hembra','2005-08-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('281','195','POLI','','1','8','Hembra','2006-08-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('282','195','LOLA','','1','8','Hembra','2014-12-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('283','196','MILO','','1','1','Macho','2018-12-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('284','197','INDIA','','1','8','Hembra','2014-11-18','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('285','198','MORCI','','1','1','Hembra','1970-01-01','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('286','199','GRETA','','1','1','Hembra','2009-06-16','CASTRADA','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('287','200','CHAMPA','','2','42','Macho','2017-07-03','CASTRADO','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('289','200','MICHU','','2','42','Macho','2016-06-14','CASTRADO','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('290','147','NICKY','','1','8','Macho','2018-12-13','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('291','201','COKI','','1','1','Macho','2012-06-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('292','203','CANDE','','1','8','Hembra','2008-06-03','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('293','203','MANCHITA','','1','1','Hembra','2013-04-04','CASTRADA','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('294','202','FELIPE','','1','19','Macho','2014-06-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('295','202','LOLI','','1','1','Hembra','2012-06-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('296','202','DANA','','1','1','Hembra','2007-06-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('297','202','FIDEL','','2','42','Macho','2016-10-11','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('298','204','NEGRO','','1','1','Macho','2011-07-12','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('299','205','ONUR','','1','11','Macho','2014-11-28','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('300','206','OLAF','','1','1','Macho','2016-11-24','CASTRADO','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('301','207','CYBORG','','1','3','Macho','2017-05-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('302','208','LUNA','','1','1','Hembra','2018-02-21','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('303','209','PANCHO','','1','1','Macho','2011-06-22','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('304','210','FELIPE','','2','42','Macho','2010-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('305','211','TEO','','1','1','Macho','2005-04-14','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('306','212','LOLA','','1','1','Hembra','2009-08-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('307','213','THEO','','1','48','Macho','2013-06-06','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('308','214','GATITO','','2','42','Macho','2018-09-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('309','215','RODO','','1','14','Macho','2018-12-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('310','216','OTTO','','1','1','Macho','2018-01-08','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('311','217','BENITO','','1','12','Macho','2017-03-05','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('312','218','BENITO NESTOR','','2','42','Macho','2010-06-15','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('313','218','SIMON BOLIVAR','','1','19','Macho','2013-01-25','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('314','218','MARIA EVA ','','2','42','Hembra','2011-10-19','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('315','218','LAYSA','','1','1','Hembra','2004-04-06','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('316','125','CANELA','','1','1','Hembra','2012-11-29','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('317','219','SIN NOMBRE','','2','42','Hembra','2019-01-20','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('318','220','AUKA','','1','1','Hembra','2003-06-10','','','avatar_azul.png','1');
INSERT INTO `paciente` (`idpaciente`,`cliente_idcliente`,`nombre`,`pacientecol`,`especie_idespecie`,`raza_idraza`,`sexo`,`fechaNacimiento`,`observacion`,`señaParticular`,`foto`,`estado`) VALUES
('319','221','SUSSE','','1','2','Hembra','2018-12-22','','','avatar_azul.png','1');



-- -------------------------------------------
-- TABLE DATA producto
-- -------------------------------------------
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('1','1','PROPANTELINA','1','14','25','69.55','140','149.8','168','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('2','2','ANIMAL STEREO 1 Y 2','2','2','4','93.5','132','141.24','158.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('3','3','ANIMAL STEREO 3','2','2','4','88','146.3','156.541','175.56','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('4','4','ANIMAL STEREO 4 Y 5','2','2','4','88','165','176.55','198','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('5','5','IMPEARMEABLE LLUVIA 2','2','2','5','60.5','165','176.55','198','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('6','6','IMPEARMEABLE LLUVIA 1','2','2','5','88','143','153.01','171.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('7','7','CAPA N 0','2','2','6','198','484','517.88','580.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('8','8','CAPA N 1','2','2','6','198','528','564.96','633.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('9','9','POLAR CHALECO 0','2','2','7','78.1','184.8','197.736','221.76','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('10','10','POLAR CHALECO 1','2','2','7','119.9','247.5','264.825','297','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('11','11','POLAR CHALECO 2','2','2','7','84.7','217.8','233.046','261.36','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('12','12','POLAR CHALECO 3','2','2','7','184.8','365.2','390.764','438.24','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('13','13','POLAR CHALECO 4','2','2','7','126.5','250.8','268.356','300.96','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('14','14','POLAR CHALECO 5','2','2','7','205.92','405.9','434.313','487.08','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('15','15','POLAR CHALECO 6','2','2','7','137.5','330','353.1','396','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('16','16','POLAR CHALECO 7','2','2','7','227.04','448.8','480.216','538.56','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('17','17','POLAR CHALECO 8','2','2','7','165','396','423.72','475.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('18','18','POLAR CHALECO 10','2','2','7','125.62','247.5','264.825','297','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('19','19','CORRECAMINO 3','2','2','8','110','356.4','381.348','427.68','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('20','20','POLAR FORTALEZA 1','2','2','6','83.6','303.6','324.852','364.32','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('21','21','POLAR FORTALEZA 2','2','2','6','91.3','343.2','367.224','411.84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('22','22','POLAR FORTALEZA 3','2','2','6','108.9','369.6','395.472','443.52','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('23','23','POLAR FORTALEZA 4','2','2','6','154','442.2','473.154','530.64','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('24','24','POLAR FORTALEZA 5','2','2','6','110','475.2','508.464','570.24','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('25','25','POLAR FORTALEZA 6','2','2','6','110','508.2','543.774','609.84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('26','26','POLAR FORTALEZA 7','2','2','6','110','521.4','557.898','625.68','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('27','27','AC. TIOCTICO - CALCIO BLIST','1','3','9','33','80','85.6','96','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('28','28','ACEDAN','1','4','10','74','148','158.36','177.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('29','29','ADORNO PECERA 1','2','5','5','50','200','214','240','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('30','30','ADORNO PECERA 2','2','5','5','50','300','321','360','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('31','31','AGUA OXIGENADA 100ML','1','6','11','10.0905','39.9','42.693','47.88','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('32','32','AGUA OXIGENADA 500ML','1','6','11','26.859','103.95','111.227','124.74','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('33','33','AGUJA DESC 25/8','1','7','11','0.92','1.5','1.6','1.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('34','34','AGUJA DESC 40/8','1','7','11','0.96','1.7','1.82','2.04','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('35','35','AGUJA DESC 40/12','1','7','11','1.2','2','2.14','2.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('36','36','AIREADOR ','2','5','12','100','300','321','360','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('37','37','ALCOHOL EN GEL 250ML','1','6','11','52.2585','88.2','94.374','105.84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('38','38','ALCOHOL EN GEL 500ML','1','6','11','59.8185','100.8','107.856','120.96','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('39','39','ALCOHOL PORTA 250ML','1','6','13','21','48.3','51.681','57.96','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('40','40','ALGEN 60 (BLISTER)','1','8','15','92','180','192.6','216','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('41','41','ALGEN 60 (COMP)','1','8','15','20','23','24.61','27.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('42','42','ALICATE GUILLOTINA','2','9','5','95','140','149.8','168','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('43','43','ALICATE PROFESIONAL ','2','9','5','69','120','128.4','144','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('44','44','ALICATE TIJERA 1','2','9','5','48','74','79.18','88.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('45','45','ALICATE TIJERA 2','2','9','5','63','79','84.53','94.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('46','46','AMOXICILINA + CLAVULANICO SUSP 250ML','1','10','36','113.14','215','230.05','258','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('47','47','AMOXICILINA 500MG GENERICO (BLISTER)','1','10','16','35','65','69.55','78','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('48','48','AMOXICILINA 500MG GENERICO (COMP)','1','10','16','5','8','8.56','9.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('49','49','ANIKIL 2 - 10 KG','1','11','17','100.5','167','178.69','200.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('50','50','ANIKIL 10 - 20 KG','1','11','17','110.5','184','196.88','220.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('51','51','ANIKIL 20 - 40 KG','1','11','17','155.6','259','277.13','310.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('52','52','ANIKIL 40 - 60 KG','1','11','17','0','0','0','0','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('53','53','ANIKIL GATOS HASTA 4 KG','1','11','17','90.55','150','160.5','180','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('54','54','ALFORJA DE LONA','2','12','5','500','1100','1177','1320','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('55','55','ANILLOS DE ALPACA','4','13','18','44','200','214','240','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('56','56','ANTICLORO 100ML','2','5','5','34','68','72.76','81.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('57','57','APOQUEL 5.4 OCLACITINIB (BILSTER)','1','14','19','400','690','738.3','828','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('58','58','APOQUEL 5.4 OCLACITINIB (CAJA)','1','14','19','809','1201','1285.07','1441.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('59','59','APRAX 10 KG (BLISTER)','1','11','15','65','117','125.19','140.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('60','60','APRAX 10 KG (COMP)','1','11','15','17','45','48.15','54','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('61','61','APRAX 20 KG (BLISTER)','1','11','15','107','195','208.65','234','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('62','62','APRAX 20 KG (COMP)','1','11','15','30','60','64.2','72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('63','63','APRAX SUSP 20 ML','1','11','15','113','203','217.21','243.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('64','64','AROS COLGANTES GRANDES ALPACA','4','13','18','100','150','160.5','180','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('65','65','CALENTADOR 50W','2','5','20','250','400','428','480','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('66','67','AZITROMICINA 500 MG','1','10','11','24','130','139.1','156','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('67','68','AZUL DE METILENO 100 ML','2','5','5','37','74','79.18','88.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('68','69','ATOMO DESINFLAMANTE 50 GR','1','15','21','64.86','148','158.36','177.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('69','70','BANDEJA SANITARIA 1','2','16','5','70','108','115.56','129.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('70','71','BANDEJA SANITARIA 2','2','16','5','80','130','139.1','156','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('71','72','KIT SANITARIO ','2','16','5','103','168','179.76','201.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('72','73','BAÑADERA PARA PAJAROS 1','2','16','5','16','33','35.31','39.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('73','74','BAÑADERA PARA PAJAROS 2','2','16','5','22.3','42','44.94','50.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('74','75','BAÑADERA PARA PAJAROS 3','2','16','5','22.3','50','53.5','60','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('75','76','BAÑADERA PARA PAJAROS 4','2','16','5','22.3','65','69.55','78','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('76','77','KONTROL MAX BLISTER','1','11','9','67','125','133.75','150','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('77','78','KONTROL MAX COMPRIMIDO','1','11','9','5','20','21.4','24','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('78','79','BARRIL PORTA DATOS','2','17','5','35.31','74','79.18','88.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('79','80','BASKEN PLUS 40 CAJA','1','11','22','133.61','227','242.89','272.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('80','81','BASKEN PLUS 40 COMPRIMIDO','1','11','22','33','62','66.34','74.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('81','82','BASKEN PLUS 60 CAJA','1','11','22','154.31','262','280.34','314.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('82','83','BASKEN PLUS 60 COMPRIMIDO','1','11','22','51','95','101.65','114','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('83','84','BASKEN PLUS GATO CAJA','1','11','22','85.63','145','155.15','174','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('84','85','BASKEN PLUS GATO COMPRIMIDO','1','11','22','21','43','46.01','51.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('85','86','BASTO VICTORIA','2','12','5','2000','3400','3638','4080','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('86','87','BEBEDERO ACRILICO AVES 2','2','18','5','23.5','44','47.08','52.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('87','88','BEBEDERO HAMSTER PLASTICO','2','18','5','95','149','159.43','178.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('88','89','BILLETERA DAMA 1','4','19','18','130','210','224.7','252','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('89','90','BILLETERA DAMA 2','4','19','18','180','340','363.8','408','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('90','91','BILLETERA HOMBRE CUERO CRUDO','4','19','18','250','570','609.9','684','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('91','92','BILLETERA HOMBRE 1','4','19','18','120','250','267.5','300','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('92','93','BILLETERA PORTABILLETES','4','19','18','90','160','171.2','192','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('93','94','BOINA DE HILO','4','19','18','150','500','535','600','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('94','95','BOINA DE LANA','4','19','18','130','350','374.5','420','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('95','96','PORTA BOLSA HUESO','2','16','5','50','90','96.3','108','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('96','97','BOLSA FECAL REPUESTO X 3','2','16','5','45','75','80.25','90','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('97','98','BOLSO TRANSPORTADOR 50 CM','2','20','23','600','998','1067.86','1197.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('98','99','BOMBACHA SANITARIA 3','2','16','23','115','260','278.2','312','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('99','100','BOMBACHA SANITARIA 4','2','16','23','200','340','363.8','408','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('100','101','BOMBILLA ALPACA RESORTE','4','19','18','80','155','165.85','186','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('101','102','BOMBILLA ECONOMICA ROSCA','4','19','18','50','79','84.53','94.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('102','103','BOMBILLA ECONOMICA ALUMINIO-COLOR','4','19','18','18','55','58.85','66','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('103','104','BOZAL CANASTA 002','2','21','5','118','140','149.8','168','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('104','105','BOZAL CANASTA 003','2','21','5','130','175','187.25','210','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('105','106','BOZAL CANASTA 004','2','21','5','150','192','205.44','230.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('106','107','BOZAL CANASTA 005','2','21','5','200','270','288.9','324','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('107','108','BOZAL CANASTA 006','2','21','5','200','320','342.4','384','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('108','109','BOZAL CANASTA 007','2','21','5','240','380','406.6','456','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('109','110','BOZAL CANASTA 008','2','21','5','300','400','428','480','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('110','111','BOZAL CUERO 1','2','21','5','70','150','160.5','180','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('111','112','BOZAL CUERO 6','2','21','5','150','320','342.4','384','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('112','113','BOZAL NYLON','2','21','23','50','103','110.21','123.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('113','114','BOZAL POLIPROPILENO 2','2','21','5','60','120','128.4','144','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('114','115','BOZAL EDUCADOR','2','21','5','70','168','179.76','201.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('115','116','BRO K 600 COMPRIMIDO','1','4','24','15','23','24.61','27.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('116','117','COLLAR CON TERMINAL CUERO 1','2','22','5','82.951','128.7','137.709','154.44','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('117','118','COLLAR CON TERMINAL CUERO 3','2','22','5','78.804','122.1','130.647','146.52','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('118','119','COLLAR CON TERMINAL CUERO 2','2','22','5','80.861','125.4','134.178','150.48','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('119','120','COLLAR CON TERMINAL CUERO 4','2','22','5','67.859','104.5','111.815','125.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('120','121','COLLAR CON TERMINAL CUERO 5','2','22','5','66.451','102.3','109.461','122.76','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('121','122','COLLAR CON TERMINAL CUERO 6','2','22','5','64.713','100.1','107.107','120.12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('122','123','COLLAR CON TERMINAL CUERO 6','2','22','5','64.713','100.1','107.107','120.12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('123','124','COLLAR CON TERMINAL CUERO 7','2','22','5','47.839','73.7','78.859','88.44','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('124','125','COLLAR CON TERMINAL CUERO 8','2','22','5','47.333','72.6','77.682','87.12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('125','126','COLLAR CON TERMINAL CUERO 9','2','22','5','45.265','69.3','74.151','83.16','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('126','127','COLLAR CON TERMINAL CUERO 10','2','22','5','35.134','53.9','57.673','64.68','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('127','128','COLLAR CON TERMINAL CUERO 11','2','22','5','33.748','51.7','55.319','62.04','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('128','129','COLLAR CON TERMINAL CUERO 12','2','22','5','33.154','50.6','54.142','60.72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('129','130','COLLAR POLIPROPILENO DOBLE 0','2','22','5','122.705','190.3','203.621','228.36','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('130','131','COLLAR POLIPROPILENO DOBLE 1','2','22','5','116.787','180.4','193.028','216.48','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('131','132','COLLAR POLIPROPILENO DOBLE 2','2','22','5','113.74','176','188.32','211.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('132','133','COLLAR POLIPROPILENO DOBLE 3','2','22','5','110.572','170.5','182.435','204.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('133','134','COLLAR POLIPROPILENO DOBLE 4','2','22','5','86.757','134.2','143.594','161.04','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('134','135','COLLAR POLIPROPILENO DOBLE 5 ','2','22','5','83.996','129.8','138.886','155.76','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('135','136','COLLAR POLIPROPILENO DOBLE 6','2','22','5','80.498','124.3','133.001','149.16','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('136','137','COLLAR POLIPROPILENO DOBLE 7','2','22','5','64.823','100.1','107.107','120.12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('137','138','COLLAR POLIPROPILENO DOBLE 8','2','22','5','62.469','96.8','103.576','116.16','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('138','139','COLLAR POLIPROPILENO DOBLE 9','2','22','5','60.258','93.5','100.045','112.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('139','140','COLLAR POLIPROPILENO 15/1','2','22','5','25.333','38.5','41.195','46.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('140','141','COLLAR POLIPROPILENO 15/2','2','22','5','27.302','41.8','44.726','50.16','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('141','142','COLLAR POLIPROPILENO 15/3','2','22','5','30.679','47.3','50.611','56.76','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('142','143','COLLAR POLIPROPILENO 15/4','2','22','5','32.307','49.5','52.965','59.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('143','144','COLLAR POLIPROPILENO 20/1','2','22','5','33.671','51.7','55.319','62.04','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('144','145','COLLAR POLIPROPILENO 20/2','2','22','5','37.378','57.2','61.204','68.64','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('145','146','COLLAR POLIPROPILENO 20/3','2','22','5','42.46','66','70.62','79.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('146','147','COLLAR POLIPROPILENO 25/1','2','22','5','48.488','74.8','80.036','89.76','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('147','148','COLLAR POLIPROPILENO 25/2','2','22','5','52.426','81.4','87.098','97.68','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('148','149','COLLAR POLIPROPILENO 25/3','2','22','5','69.179','106.7','114.169','128.04','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('149','150','COLLAR POLIPROPILENO 30/1','2','22','5','61.325','94.6','101.222','113.52','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('150','151','COLLAR POLIPROPILENO 30/2','2','22','5','71.522','111.1','118.877','133.32','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('151','152','CORREA POLIPROPILENO SIMPLE 120/15','2','22','5','103.917','160.6','171.842','192.72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('152','153','CORREA POLIPROPILENO SIMPLE 120/20','2','22','5','118.393','183.7','196.559','220.44','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('153','154','CORREA POLIPROPILENO SIMPLE 120/25','2','22','5','165.077','255.2','273.064','306.24','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('154','155','CORREA POLIPROPILENO SIMPLE 120/30','2','22','5','182.457','282.7','302.489','339.24','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('155','156','CORREA TERMINAL EN CUERO 2X50','2','22','5','109.307','169.4','181.258','203.28','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('156','157','CORREA TERMINAL EN CUERO 2X90','2','22','5','133.144','205.7','220.099','246.84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('157','158','CORREA TERMINAL EN CUERO 2.5X30','2','22','5','137.797','213.4','228.338','256.08','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('158','159','PECHERA REFORZADA EXTRA GRANDE','2','22','5','394.427','610.5','653.235','732.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('159','160','PECHERA REFORZADA GRANDE','2','22','5','355.85','551.1','589.677','661.32','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('160','161','PECHERA REFORZADA MEDIANA','2','22','5','332.167','514.8','550.836','617.76','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('161','162','PECHERA REFORZADA REGULABLE','2','22','5','379.555','583','623.81','699.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('162','163','PRETAL 0','2','22','5','67.012','103.4','110.638','124.08','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('163','164','PRETAL 1','2','22','5','74.723','115.5','123.585','138.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('164','165','PRETAL 2','2','22','5','80.597','124.3','133.001','149.16','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('165','166','PRETAL 3','2','22','5','87.758','135.3','144.771','162.36','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('166','167','PRETAL 4','2','22','5','118.998','183.7','196.559','220.44','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('167','168','PRETAL 5','2','22','5','128.546','199.1','213.037','238.92','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('168','169','PRETAL 6','2','22','5','170.324','264','282.48','316.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('169','170','PRETAL 7','2','22','5','207.482','321.2','343.684','385.44','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('170','171','KEN-L CACHORRO 15 KG','3','27','26','963.04','1223','1308.61','1467.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('171','172','KEN-L ADULTO 15 KG','3','27','26','903.49','1156','1236.92','1387.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('172','173','KEN-L ADULTO 22 KG','3','27','26','1248.25','1598','1709.86','1917.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('173','174','KEN-L GATO 7.5 KG','3','28','26','744','968','1035.76','1161.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('174','175','KEN-L LIGHT 15 KG','3','27','26','966.77','1237','1323.59','1484.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('175','176','TOP NUTRITION ADULTOS PEQUEÑOS 1 KG','3','27','26','1','1','1.07','1.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('176','177','TOP NUTRITION ADULTOS PEQUEÑOS 3 KG','3','27','26','1','1','1.07','1.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('177','178','TOP NUTRITION ADULTOS PEQUEÑOS 7.5 KG','3','27','26','921.26','1198','1281.86','1437.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('178','179','TOP NUTRITION CACHORRO PEQUEÑO 1 KG','3','27','26','1','1','1.07','1.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('179','180','TOP NUTRITION CACHORRO PEQUEÑO 3 KG','3','27','26','1','1','1.07','1.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('180','181','TOP NUTRITION SENIOR 3 KG','3','27','26','349.47','455','486.85','546','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('181','182','TIERNITOS CACHORRO 15 KG','3','27','26','573.6','740','791.8','888','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('182','183','TIERNITOS CACHORRO 22 KG','3','27','26','807.48','1025','1096.75','1230','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('183','184','CARO AMICI MIX 15 KG','3','28','26','613.82','798','853.86','957.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('184','185','EXACT ADULTO 25 KG','3','27','26','655.75','853','912.71','1023.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('185','186','PRO PLAN ADULTO 15 KG','3','27','27','1754','2228','2383.96','2673.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('186','187','PRO PLAN CACHORRO 15 KG','3','27','27','1895','2407','2575.49','2888.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('187','188','CAT CHOW ADULTO 15 KG','3','28','27','1277.1','1622','1735.54','1946.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('188','189','DOG CHOW ADULTO 21 KG','3','27','27','1226','1594','1705.58','1912.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('189','190','DOG CHOW CACHORRO 21 KG','3','27','27','1287','1673','1790.11','2007.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('190','191','DOGUI CARNE/CERE/ARROZ 21KG','3','27','27','758','985','1053.95','1182','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('191','192','EXCELENT GATITO 7.5 ','3','28','27','1057','1374','1470.18','1648.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('192','193','EXCELENT GATO ADULTO 15 KG','3','28','27','1936','2439','2609.73','2926.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('193','194','EXCELENT PERRO ADULTO 20 KG ','3','27','27','1301','1639','1753.73','1966.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('194','195','GATI PESCADO/ARROZ/ESPINAC 15 KG','3','28','27','713','926','990.82','1111.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('195','196','INFINITY ADULTO 15 KG','3','27','28','813.12','1040','1112.8','1248','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('196','197','INFINITY ADULTO 21 KG','3','27','28','1036.87','1317','1409.19','1580.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('197','198','INFINITY ADULTO MORDIDA PEQUEÑA 15 KG','3','27','28','813.12','1050','1123.5','1260','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('198','199','INFINITY CACHORRO 10 KG','3','27','28','651.25','846','905.22','1015.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('199','200','INFINITY GATO ADULTO 10 KG','3','28','28','723.75','941','1006.87','1129.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('200','201','VORAZ GATITO','3','28','28','599','778','832.46','933.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('201','202','KROSTER 15 KG','3','27','28','262','343','367.01','411.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('202','203','NATURE CACHORRO PEQUEÑOS 8 KG','3','27','29','830','1064','1138.48','1276.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('203','204','NATURE ADULTO PEQUEÑO 8 KG ','3','27','29','782','999','1068.93','1198.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('204','205','NATURE GATO 8 KG','3','28','29','1075','1397','1494.79','1676.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('205','206','DR. PERROT 15 KG','3','27','29','332','431','461.17','517.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('206','207','DR. PERROT 22 KG','3','27','29','474','616','659.12','739.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('207','208','WHISKAS ADULTO 10 KG ','3','28','30','874.21','1110','1187.7','1332','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('208','209','WHISKAS GATITO 10 KG ','3','28','30','874.21','1136','1215.52','1363.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('209','210','LATA WHISKAS - PEDIGREE 340 GR','3','27','30','51.17','70','74.9','84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('210','211','SOBRE WHISKAS - PEDIGREE 85 GR','3','27','30','16.72','24','25.68','28.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('211','212','PEDIGREE ADULTO 21 KG ','3','27','30','1254.95','1581','1691.67','1897.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('212','213','PEDIGREE ADULTO MORDIDA PEQUEÑA 9 KG','3','27','30','591.62','745','797.15','894','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('213','214','PEDIGREE CACHORRO 21 KG','3','27','30','1380.44','1700','1819','2040','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('214','215','OLD PRINCE CORDERO 15 KG ','3','27','31','1237.8','1670','1786.9','2004','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('215','216','URINARY GATO 7.5 KG','3','27','32','1691.77','2538','2715.66','3045.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('216','217','URINARY GATO 1.5 KG','3','28','32','481','722','772.54','866.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('217','218','HEPATIC 10 KG ','3','27','32','1886','2829','3027.03','3394.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('218','219','MINI ADULTO 1 KG','3','27','32','214','278','297.46','333.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('219','220','MINI ADULTO 3 KG ','3','27','32','592','769','822.83','922.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('220','221','MINI JUNIOR 1 KG ','3','27','32','252.15','328','350.96','393.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('221','222','MINI JUNIOR 3 KG ','3','27','32','645.2','834','892.38','1000.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('222','223','RENAL GATO 2 KG','3','28','32','592.1','889','951.23','1066.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('223','224','URINARY PERRO 10 KG ','3','27','32','1765.2','2648','2833.36','3177.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('224','225','URINARY PERRO 1.5 KG ','3','27','32','346.4','520','556.4','624','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('225','226','CAN FEED ADULTO 15 KG ','3','27','33','911','1276','1365.32','1531.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('226','227','CAN FEED ADULTO 20 KG ','3','27','33','1154','1615','1728.05','1938','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('227','228','CAN FEED CACHORRO 20 KG ','3','27','33','1274','1783','1907.81','2139.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('228','229','CAN FEED CACHORRO 15 KG ','3','27','33','1007','1410','1508.7','1692','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('229','230','IRON PET ADULTO 20 KG ','3','27','33','650','845','904.15','1014','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('230','231','IRON PET PREMIUM 20 KG ','3','27','33','894','1162','1243.34','1394.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('231','232','PERFORMANCE ADULTO 15 KG ','3','27','32','1443','1804','1930.28','2164.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('232','233','PERFORMANCE CACHORRO 15 KG ','3','27','32','1483','1854','1983.78','2224.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('233','234','PERFORMANCE GATO 7.5 KG ','3','28','32','1162','1453','1554.71','1743.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('234','235','SABROSITOS MIX 15 KG','3','27','34','439.5','555','593.85','666','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('235','236','SABROSITOS CACHORRO 18 KG ','3','27','34','678.9','862','922.34','1034.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('236','237','SABROSITOS GATO 20 KG','3','27','34','818.5','1035','1107.45','1242','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('237','238','SIEGER CACHORROS 15 kg','3','27','35','1690.82','2150','2300.5','2580','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('238','239','SIEGER CRIADORES 15 KG','3','27','35','1426.16','1798','1923.86','2157.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('239','240','SIEGER CRIADORES 20 kg','3','27','35','1829.52','2298','2458.86','2757.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('240','241','CADENA CON MANIJA ECONOMICA 1','2','24','5','55','187','200.09','224.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('241','242','CADENA CON MANIJA POLIPROPILENO 30','2','24','5','257.07','398.2','426.074','477.84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('242','243','CALCIVET','1','26','25','100','200','214','240','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('243','244','CARDINA 1','2','9','5','80','125','133.75','150','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('244','245','CARDINA 2','2','9','5','89','140','149.8','168','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('245','246','CARDINA 3','2','9','5','116','178','190.46','213.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('246','247','CARTEL CUIDADO','2','17','5','69','128','136.96','153.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('247','248','CASCABEL METALICO','2','17','5','25','55','58.85','66','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('248','249','CASCABEL COLOR','2','17','5','16','35','37.45','42','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('249','250','ABOCAT','1','7','36','33','49','52.43','58.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('250','251','CEBO GRANULADO 100 GR','5','29','38','35','65','69.55','78','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('251','252','CEBO GRANULADO 250 GR','5','29','38','66','132','141.24','158.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('252','253','CEFALEXINA SUSPENSION','1','10','39','140','280','299.6','336','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('253','254','CEPILLO DENTAL DEDAL','2','16','5','30','60','64.2','72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('254','255','CEPILLO DENTAL DOBLE','2','16','5','30','60','64.2','72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('255','256','CEPILLO NEUMATICO DOBLE','2','9','5','87','134','143.38','160.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('256','257','CF 10 AMBIENTAL','5','30','38','109','240','256.8','288','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('257','258','CINCHA CORREDIZA YUTE','2','12','5','170','270','288.9','324','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('258','259','CINCHA FIJA LONA','2','12','5','130','238','254.66','285.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('259','260','CINTO DE CARPINCHO BORDADO','4','19','18','250','590','631.3','708','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('260','261','CINTO DE CUERO LISO','4','19','18','200','400','428','480','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('261','262','CINTO DE CUERO CRUDO FINO','4','19','18','200','400','428','480','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('262','263','CINTO DE CUERO CRUDO GRUESO','4','19','18','250','500','535','600','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('263','264','CINTO DE CUERO BORDADO','4','19','18','250','500','535','600','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('264','265','TRIPLE 15 500 GR','6','32','40','88','148.5','158.895','178.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('265','266','DERM CAPS 30 GR','1','26','17','232','407','435.49','488.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('266','267','DIJE DE ALPACA','4','19','18','80','120','128.4','144','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('267','268','DIPIRONA 500 MG BLISTER','1','14','36','25','35','37.45','42','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('268','269','DIPIRONA 500 MG COMPRIMIDO','1','14','36','3','8','8.56','9.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('269','270','DOXICICLINA 50 MG BLISTER','1','10','39','50','88','94.16','105.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('270','271','DOXICICLINA 50 MG COMPRIMIDO','1','10','39','4','10','10.7','12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('271','272','DOXICICLINA 100 MG BLISTER','1','10','39','65','115','123.05','138','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('272','273','DOXICICLINA 100 MG COMPRIMIDO','1','10','39','7','15','16.05','18','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('273','274','DOXICICLINA 200 MG BLISTER','1','10','39','75','135','144.45','162','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('274','275','DOXICICLINA 200 MG COMPRIMIDO','1','10','39','8','16','17.12','19.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('275','276','ENDECTOCIDA COMRIMIDO','1','11','10','15','23','24.61','27.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('276','277','ENROFLOXACINA 50 MG BLISTER','1','10','39','41','82','87.74','98.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('277','278','ENROFLOXACINA 50 MG COMPRIMIDO','1','10','39','5','15','16.05','18','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('278','279','ENROFLOXACINA 100 MG BLISTER','1','10','39','53','93','99.51','111.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('279','280','ENROFLOXACINA 100 MG COMPRIMIDO','1','10','39','6','14','14.98','16.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('280','281','ENROFLOXACINA 200 MG BLISTER','1','10','39','80','115','123.05','138','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('281','283','ENROFLOXACINA 200 MG COMPRIMIDO','1','10','39','8','17','18.19','20.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('282','284','ENTEROSEPT 100 ML','1','43','39','82','165','176.55','198','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('283','285','EPISOL 18 COMPRIMIDOS','1','4','22','114','195','208.65','234','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('284','286','ESTRIBOS DE SUELA CON ESTRIBERA','2','12','5','700','1600','1712','1920','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('285','287','RANITIDINA 150 MG COMPRIMIDO','1','3','36','3','8','8.56','9.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('286','288','FENTEL MAX 20 KG','1','11','39','67.5','122','130.54','146.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('287','289','FERTIFOX VARIOS 200 ML','6','32','40','94.6','156.2','167.134','187.44','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('288','290','FORMULA ANTIARTROSICA 30 ML','1','11','25','100','170','181.9','204','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('289','291','FRENA DE SUELA','2','12','5','700','1400','1498','1680','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('290','292','BOCADO HIERRO PATA CORTA','2','12','5','400','550','588.5','660','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('291','293','BOCADO HIERRO PATA LARGA','2','12','5','450','600','642','720','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('292','294','BOCADO CROMADO','2','12','5','500','750','802.5','900','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('293','298','FUMIXAN PASTILLA 30 GR','5','30','38','97','180','192.6','216','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('294','299','FUROSEMIDA 40 MG BLISTER 20 COMP.','1','35','36','29','60','64.2','72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('295','300','FUROSEMIDA 40 MG COMPRIMIDO','1','35','36','2','6','6.42','7.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('296','301','FUROSEMIDA 40 MG BLISTER','1','35','24','57','104','111.28','124.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('297','302','FUROSEMIDA 40 MG COMPRIMIDO','1','35','24','6','15','16.05','18','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('298','303','GASA  10x10-15x15 SOBRE','1','6','36','6.3','14.7','15.729','17.64','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('299','304','CEBO DE PARAFINA','5','36','41','5','10','10.7','12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('300','305','CEBO PLASTICO','5','38','41','3','6','6.42','7.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('301','306','JERINGA 6 GR','5','29','41','59','95','101.65','114','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('302','307','TALQUERA 250 GR','5','29','44','67','110','117.7','132','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('303','308','GLIFOSATO POLVO','5','39','38','140','250','267.5','300','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('304','309','CORULETS GOTAS','1','53','24','135','235','251.45','282','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('305','310','GUANTES X 10 UNIDADES','1','6','36','26.25','50.4','53.928','60.48','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('306','311','GUANTES UNIDAD','1','6','36','2.1','3.675','3.93225','4.41','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('307','312','ESFERA 2','2','40','5','307','479','512.53','574.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('308','313','RUEDA METALICA 2','2','40','5','345','504','539.28','604.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('309','314','RUEDA PLASTICA','2','40','5','35','70','74.9','84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('310','315','HERRADURA PESADA X 4','2','12','5','117','174','186.18','208.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('311','316','HERRADURA PESADA UNIDAD','2','12','5','30','53','56.71','63.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('312','317','HOJA DE BISTURI','1','6','36','6.3','16.8','17.976','20.16','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('313','318','LIQUIDO 60 ML','5','29','43','60','120','128.4','144','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('314','319','LIQUIDO 120 ML','5','29','43','86','172','184.04','206.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('315','320','HORMIGEL 170 ML','5','29','38','53','135','144.45','162','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('316','321','HORMIGEL 300 ML','5','29','38','86','198','211.86','237.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('317','322','HUESO DENTAL 28 GR','2','16','5','10','24','25.68','28.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('318','323','IODOPOVIDONA','1','6','36','72.45','130.2','139.314','156.24','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('319','324','JABON FAUNA','1','11','36','156','250','267.5','300','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('320','325','CINTURON DE SEGURIDAD ANCHO','2','34','5','140','278','297.46','333.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('321','326','CINTURON DE SEGURIDAD 1','2','34','23','168','289','309.23','346.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('322','327','CINTURON DE SEGURIDAD 2','2','34','23','198','340','363.8','408','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('323','328','CLAVOS HERRADURAS E4','2','12','45','4.8','6.5','6.96','7.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('324','329','CLAVOS HERRADURAS E6','2','12','45','5.1','6.9','7.38','8.28','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('325','330','JAULA VOLADORA 4 VASOS NIDO EXTERNO','2','41','5','759','1140','1219.8','1368','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('326','331','JAULA VOLADORA 4 VASOS NIDO INTERNO','2','41','5','654','1013','1083.91','1215.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('327','332','JAULA VOLADORA 6 VASOS NIDO INTERNO','2','41','5','791','1230','1316.1','1476','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('328','334','JAULA 1','2','40','5','452','700','749','840','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('329','335','JAULA 2','2','40','5','579','897','959.79','1076.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('330','336','JAULA 1','2','41','5','383','593','634.51','711.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('331','337','JERINGA 3 - 5','1','7','36','3.85','6','6.42','7.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('332','338','JERINGA 10','1','7','36','2.9','6','6.42','7.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('333','339','JERINGA 20','1','7','36','4','8','8.56','9.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('334','340','JERINGA 60','1','7','36','10','20','21.4','24','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('335','341','JUEGO DE MATE-BENDEJA DAMA','4','19','18','350','490','524.3','588','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('336','342','JUEGO TABLA-CUBIERTOS SIN VASO','4','19','18','250','440','470.8','528','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('337','343','KETOCONAZOL BLISTER','1','42','24','77.5','150','160.5','180','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('338','344','ALICATE KIT','2','9','5','95','198','211.86','237.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('339','345','KUALCOHEPAT 20 KG BLISTER','1','3','39','67.64','128','136.96','153.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('340','346','KUALCOVIT B 100 ML','1','26','39','111','199','212.93','238.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('341','347','LAZO 4 SOGAS','2','12','5','700','1500','1605','1800','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('342','348','LEVAMISOL SUSPENSION','1','11','39','50','95','101.65','114','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('343','349','LLAMADOR DE ANGEL','4','19','18','50','200','214','240','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('344','350','PASAPAÑUELOS ALPACA','4','13','18','70','150','160.5','180','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('345','351','COMEDERO ACERO CAZUELA 3B','2','18','5','80','245','262.15','294','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('346','352','COMEDERO ACERO N2','2','18','5','101','163','174.41','195.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('347','353','COMEDERO ACERO N3','2','18','5','152.43','236','252.52','283.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('348','354','COMEDERO ACERO N4','2','18','5','206.9','320','342.4','384','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('349','355','COMEDERO AVES N1','2','18','5','3','25','26.75','30','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('350','356','COMEDERO AVES N2','2','18','5','4.14','30','32.1','36','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('351','357','COMEDERO AVES N3','2','18','5','4.83','40','42.8','48','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('352','358','COMEDERO AVES N4','2','18','5','10','46','49.22','55.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('353','359','COMEDERO PARA HORMIGAS','2','18','5','20','69','73.83','82.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('354','360','COMEDERO PLASTICO AUTOMATICO','2','18','5','204.23','316','338.12','379.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('355','361','COMEDERO PLASTICO DOBLE','2','18','5','44.59','74','79.18','88.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('356','362','COMEDERO PLASTICO OVALADO N2','2','18','5','36.57','59','63.13','70.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('357','363','COMEDERO PLASTICO OVALADO N3','2','18','5','70.37','113','120.91','135.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('358','364','COMEDERO REDONDO N1','2','18','5','22.01','37','39.59','44.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('359','365','COMEDERO REDONDO N2','2','18','5','30.51','50','53.5','60','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('360','366','COMEDERO REDONDO N3 GATO OREJA','2','18','5','23.02','75','80.25','90','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('361','367','COMEDERO REDONDO N4','2','18','5','61.56','95','101.65','114','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('362','368','COMEDERO REGULADOR DE DIETA ','2','18','5','152.18','236','252.52','283.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('363','369','COLLAR ISABELINO N0','2','16','5','77.79','124','132.68','148.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('364','370','COLLAR ISABELINO N1','2','16','5','83.55','108','115.56','129.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('365','371','COLLAR ISABELINO N2','2','16','5','104','143','153.01','171.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('366','372','COLLAR ISABELINO N3','2','16','5','136.12','193','206.51','231.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('367','373','COLLAR ISABELINO N4','2','16','5','154.3','250','267.5','300','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('368','374','COLLAR ISABELINO N5','2','16','5','215.94','345','369.15','414','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('369','375','COLLAR ISABELINO N6','2','16','5','252.2','403','431.21','483.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('370','376','COMPLEJO B (BLISTER)','1','26','16','40','100','107','120','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('371','377','CONTAL 15MG (BLISTER)','1','4','24','79.5','147','157.29','176.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('372','378','CONTAL 150MG (BLISTER)','1','4','24','89','164','175.48','196.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('373','379','CONTAL 60MG (BLISTER)','1','4','24','72','135','144.45','162','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('374','380','OTOVIER 40ML LIMPIA OREJAS','1','44','24','108','193','206.51','231.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('375','381','OTOVIER NF 25ML','1','44','24','114.5','217','232.19','260.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('376','382','TRAMAVIER 80 MG (BLISTER)','1','8','24','74','130','139.1','156','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('377','383','TRAMAVIER 80 MG (COMPRIMIDO)','1','8','24','1','16','17.12','19.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('378','384','CUCHILLO DE COCINA ','4','45','51','165','330','353.1','396','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('379','385','JUEGO CUCHILLO PELUDO','4','45','51','660','968','1035.76','1161.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('380','386','CUCHILLO N1','4','45','51','110','187','200.09','224.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('381','387','CUCHILLO N2','4','45','51','105.6','275','294.25','330','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('382','388','CUCHILLO N3','4','45','51','165','368.5','394.295','442.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('383','389','CUCHILLO N4','4','45','51','264','415.8','444.906','498.96','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('384','390','CUCHILLO N5','4','45','51','387.2','550','588.5','660','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('385','391','CUCHILLO N6','4','45','51','413.6','644.6','689.722','773.52','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('386','392','CUCHILLO PARRILLERO ','4','45','51','297','514.8','550.836','617.76','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('387','393','CUCHILLO 2909','4','45','49','446.699','902','965.14','1082.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('388','394','CUCHILLO 8307','4','45','49','476.388','990','1059.3','1188','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('389','395','CUCHILLO CIERVO ','4','45','49','1568.75','2510.2','2685.91','3012.24','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('390','396','CUCHILLO MADERA','4','45','49','1329.9','2164.8','2316.34','2597.76','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('391','397','CUCHILLO TEFLONADO','4','45','49','657.8','1111','1188.77','1333.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('392','398','CUCHILLO CON ALPACA 14','4','45','50','291.5','495','529.65','594','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('393','399','CUCHILLO CON CUERO CRUDO 14','4','45','50','341','579.7','620.279','695.64','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('394','400','JUEGO CUCHILLO TRENZADO FINO','4','45','50','1320','2200','2354','2640','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('395','401','CUCHILLO ANILLADO','4','45','48','235.4','396','423.72','475.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('396','402','JUEGO CUCHILLO ANILLADO/CIERVO ','4','45','48','440','770','823.9','924','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('397','403','JUEGO CUCHILLO DOBLE N1','4','45','48','184.8','313.5','335.445','376.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('398','404','JUEGO CUCHILLO DOBLE N2','4','45','48','280','460','492.2','552','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('399','405','JUEGO CUCHILLO DOBLE PARRILLA','4','45','48','390.5','643.5','688.545','772.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('400','406','JUEGO CUCHILLO TRIPLE N2','4','45','48','228.8','520','556.4','624','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('401','407','CUCHILLO N2','4','45','48','181.5','308','329.56','369.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('402','408','CAUSTICO PARA VERRUGAS','1','6','37','112.35','210','224.7','252','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('403','409','CHOLITAS CAJA','3','31','52','71','110','117.7','132','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('404','410','CICATRINE POLVO','1','10','53','150','240','256.8','288','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('405','411','CIPROFLOXACINA 200 BLISTER','1','10','1','45','95','101.65','114','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('406','412','CIPROFLOXACINA 200 COMPRIMIDO','1','10','1','4.5','12','12.84','14.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('407','413','CISAPRIDE COMPRIMIDO','1','43','54','15','30','32.1','36','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('408','414','CLAVAMOX 250 MG BLISTER','1','10','19','169','300','321','360','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('409','415','CLAVAMOX 250 MG COMPRIMIDO','1','10','19','16','37','39.59','44.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('410','416','CLINDAMICINA 110 MG BLISTER','1','10','55','62.26','112','119.84','134.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('411','417','CLINDAMICINA 110 MG COMPRIMIDO','1','10','55','6.2','18','19.26','21.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('412','418','COLCHONETA DE CUERINA L','2','2','5','411.4','677.6','725.032','813.12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('413','419','COLCHONETA DE CUERINA M','2','2','5','300.3','493.9','528.473','592.68','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('414','420','COLCHONETA DE CUERINA S','2','2','5','209','344.3','368.401','413.16','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('415','421','COLCHONETA DE TELA L','2','2','5','359.7','592.9','634.403','711.48','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('416','422','COLCHONETA DE TELA S','2','2','5','180.4','295.9','316.613','355.08','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('417','423','COLCHONETA DE TELA XL','2','2','5','524.7','864.6','925.122','1037.52','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('418','424','COLCHONETA DE TELA M','2','2','5','262.9','432.3','462.561','518.76','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('419','425','COLLAR DE CUERO 0','2','46','5','234.3','363','388.41','435.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('420','426','COLLAR DE CUERO 1','2','46','5','186.175','288.2','308.374','345.84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('421','427','COLLAR DE CUERO 2','2','46','5','146.41','226.6','242.462','271.92','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('422','428','COLLAR DE CUERO 3','2','46','5','114.4','181.5','194.205','217.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('423','429','COLLAR DE CUERO 4','2','46','5','61.6','104.5','111.815','125.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('424','430','COLLAR DE CUERO 5','2','46','5','48.4','81.4','87.098','97.68','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('425','431','COLLAR DE CUERO 6','2','46','5','44','71.5','76.505','85.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('426','432','COLLAR ELASTIZADO','2','47','5','20','40','42.8','48','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('427','433','COLLAR PLASTICO CASCABEL - PAÑUELO','2','47','5','20','45','48.15','54','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('428','434','CORREA ALPINA','2','47','5','65','118','126.26','141.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('429','435','CORREA CON RESORTE','2','47','5','108','248','265.36','297.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('430','436','CORREA EXTENSIBLE 5 MT','2','47','5','250','540','577.8','648','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('431','437','CREMA 6 A 15 GR','1','15','56','144','250','267.5','300','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('432','438','CREMA DE ORDEÑE CREFSH','1','15','9','90','165','176.55','198','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('433','439','CREMA DE ORDEÑE CON ALOE VERA','1','15','57','124','217','232.19','260.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('434','440','CREMA TRINEO 30 GR','1','15','9','55','100','107','120','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('435','441','CURABICHERA CICATRIZOL','1','11','57','86','175','187.25','210','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('436','442','CURABICHERA YOUNG','1','11','58','80','150','160.5','180','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('437','443','DERMIL BLISTER','1','14','59','30','60','64.2','72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('438','444','DERMIL COMPRIMIDO','1','14','59','3','10','10.7','12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('439','445','DEXAMETASONA 0.5 MG BLISTER','1','14','55','22','44','47.08','52.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('440','446','DEXAMETASONA 0.5 MG COMPRIMIDO','1','14','55','3','7','7.49','8.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('441','447','FIDER 10-20 KG','1','11','56','73','135','144.45','162','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('442','448','FRONTLINE PLUS 10-20 KG','1','11','60','304','506','541.42','607.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('443','449','FRONTLINE PLUS GATOS','1','11','60','210','355','379.85','426','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('444','450','FRONTLINE SPOT-ON 10-20 KG','1','11','60','212','329','352.03','394.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('445','451','FRONTLINE SPOT-ON 20-40 KG','1','11','60','280','450','481.5','540','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('446','452','FRONTLINE SPOT-ON 2-10 KG','1','11','60','200','322','344.54','386.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('447','453','FRONTLINE SPOT-ON GATOS','1','11','60','177','286','306.02','343.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('448','454','GERIOX BLISTER','1','48','56','150','270','288.9','324','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('449','455','LAXAVET','1','43','54','118','225','240.75','270','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('450','456','LLAVEROS BOLEADORAS','4','19','18','70','170','181.9','204','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('451','457','LLAVEROS ECONOMICOS','4','19','18','40','85','90.95','102','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('452','458','LLAVEROS MANEAS','4','19','18','150','320','342.4','384','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('453','459','LLAVEROS SOMBRERO','4','19','18','50','90','96.3','108','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('454','460','MANGUERA POR METRO','2','5','5','15','40','42.8','48','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('455','461','MATE DE VIDRIO FORRADO','4','19','18','72','120','128.4','144','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('456','464','MATE FORRADO DISEÑOS VARIOS','4','19','18','150','240','256.8','288','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('457','465','MATRA GRUESA','2','12','5','350','570','609.9','684','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('458','466','MATRA POLERA','2','12','5','300','498','532.86','597.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('459','467','MEDALLA 1 ','2','17','5','17','43','46.01','51.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('460','468','MEDALLA 3','2','17','5','30','80','85.6','96','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('461','469','MEDALLA MEDALS PETS','2','17','5','85','140','149.8','168','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('462','471','METRONIDAZOL 500 MG BLISTER','1','10','11','20','45','48.15','54','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('463','472','METRONIDAZOL 500 MG COMPRIMIDO','1','10','11','2','7','7.49','8.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('464','473','MOCHILA TRANSPORTADORA','2','20','23','750','1400','1498','1680','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('465','474','MOISES L','2','47','5','575','948','1014.36','1137.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('466','475','MOISES M','2','47','5','448','738','789.66','885.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('467','476','MOISES S','2','47','5','300','489','523.23','586.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('468','477','MOSQUETON 4','2','34','5','64','100','107','120','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('469','478','NEXGARD 10-25','1','11','60','480','759','812.13','910.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('470','479','NEXGARD 2-4','1','11','60','307','460','492.2','552','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('471','480','NEXGARD 25-50','1','11','60','597','895','957.65','1074','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('472','481','NEXGARD 4-10','1','11','60','337','506','541.42','607.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('473','482','NIDO DE MIMBRE','2','41','5','50','130','139.1','156','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('474','483','NIDO METALICO EXTERNO','2','41','5','100','220','235.4','264','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('475','484','NIDO PLASTICO','2','41','5','40','87','93.09','104.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('476','485','ODONTOBIOTIC BLISTER','1','10','24','148','266','284.62','319.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('477','486','ODONTOBIOTIC COMPRIMIDO','1','10','24','14.7','35','37.45','42','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('478','487','ODONTOLIMP SPRAY','1','44','24','150','265','283.55','318','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('479','488','OMEPRAZOL COMPRIMIDO','1','43','36','3','7','7.49','8.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('480','489','PIPETA OSSPRET 11-20','1','11','61','64','128','136.96','153.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('481','490','PIPETA OSSPRET 2-10','1','11','61','60','118','126.26','141.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('482','491','PIPETA OSSPRET 20-40','1','11','61','82','155','165.85','186','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('483','492','PIPETA OSSPRET 40-60','1','11','61','78','170','181.9','204','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('484','493','PIPETA OSSPRET GATOS','1','11','61','65','130','139.1','156','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('485','494','OSTEOCART PLUS BLISTER','1','48','56','121','211','225.77','253.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('486','495','PAÑO PET 45 X 55','2','16','5','25.2','50','53.5','60','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('487','496','PAÑO PET 60 X 90 UNIDAD','2','16','5','42','66','70.62','79.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('488','497','PAÑO PET 45 X 55 UNIDAD','2','16','5','29.2','51','54.57','61.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('489','498','PAÑO PET 45 X 55 BOLSA 10 UNIDADES','2','16','5','292','425','454.75','510','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('490','499','PALITA SANITARIA','2','16','5','16.21','32','34.24','38.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('491','500','PECES PLASTICOS','2','5','5','15','50','53.5','60','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('492','501','COLLAR DE CUERO CON PUAS 0','2','46','5','434.5','672.1','719.147','806.52','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('493','502','COLLAR DE CUERO DOBLE PITBULL','2','46','5','484','749.1','801.537','898.92','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('494','503','COMFORTIS 18-27 KG','1','11','62','374','645','690.15','774','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('495','504','COMFORTIS 2.3 - 4.5 KG','1','11','62','258.62','417','446.19','500.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('496','505','COMFORTIS 27 - 54 KG','1','11','62','460.87','705','754.35','846','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('497','506','COMFORTIS 4,6 - 9 KG','1','11','62','279','453','484.71','543.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('498','507','COMFORTIS 9 - 18 KG','1','11','62','330','598','639.86','717.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('499','508','CORREONES ESPECIALES','2','12','5','130','250','267.5','300','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('500','509','JUGUETE CHIFLE 1','2','47','5','30','60','64.2','72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('501','510','JUGUETE CHIFLE 2','2','47','5','35','66','70.62','79.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('502','511','JUGUETE CHIFLE 3','2','47','5','55','83','88.81','99.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('503','512','JUGUETE CHIFLE 4','2','47','5','55','105','112.35','126','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('504','513','LONJA CUERO CRUDO 2','4','19','18','100','240','256.8','288','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('505','514','MAMADERA ECO','2','47','5','40','88','94.16','105.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('506','515','MATABABOSAS CARABA 200 GR','5','37','38','50','90','96.3','108','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('507','516','MATE FORRADO OFERTA','4','19','18','50','115','123.05','138','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('508','517','MV RENAL 1 KG','3','28','63','180','259','277.13','310.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('509','518','MV URINARY 2 KG','3','28','63','357.05','450','481.5','540','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('510','519','MV GASTROINTESTINAL 2 KG','3','27','63','344.54','436','466.52','523.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('511','520','NEO VITAPEL 30 COMPRIMIDOS','1','26','54','178','315','337.05','378','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('512','521','PABILO','2','12','5','100','200','214','240','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('513','522','PEGUAL FINO','2','12','5','150','340','363.8','408','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('514','523','PEINE RASTRILLO','2','9','5','40','99','105.93','118.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('515','524','PEINE METALICO','2','9','5','40','99','105.93','118.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('516','525','PEINE SACANUDOS','2','9','5','80','160','171.2','192','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('517','526','PEINE PARA PULGAS','2','9','5','35','88','94.16','105.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('518','527','PELOTA DE GOMA PULPO','2','47','5','3','60','64.2','72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('519','528','PELOTA DURA 1','2','47','5','38','83','88.81','99.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('520','529','PELOTA DURA 2','2','47','5','83.7','160','171.2','192','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('521','530','PELOTA DE TENIS','2','47','5','22','55','58.85','66','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('522','531','PELOTA SEMIRRIGIDA 1','2','47','5','12','30','32.1','36','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('523','532','PELOTA SEMIRRIGIDA 3','2','47','5','52','95','101.65','114','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('524','533','PERFOS 10 - 20','1','11','39','90','155','165.85','186','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('525','534','PERFOS GATOS ','1','11','39','45','130','139.1','156','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('526','535','PERROLAC','1','49','36','166.42','255','272.85','306','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('527','536','PIEDRAS PECERA 2.5 KG','2','5','5','50','120','128.4','144','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('528','537','PIEDRAS SANITARIAS DRY WAY','2','16','5','33','48','51.36','57.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('529','538','PIEDRAS SANITARIAS SILICA','2','16','5','259','385','411.95','462','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('530','539','PLANTA PECERA 30 CM','2','5','5','50','99','105.93','118.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('531','540','PLANTA PECERA CM','2','5','5','30','65','69.55','78','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('532','541','POLADIN MAX CACHORROS 15 KG BLISTER','1','48','39','40','75','80.25','90','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('533','542','POLADIN MAX CACHORROS 30 KG BLISTER','1','48','39','42.2','76','81.32','91.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('534','543','POLADIN MAX FORTE 30 KG BLISTER','1','48','39','60','110','117.7','132','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('535','544','PORTA TERMO 4','4','19','18','700','1700','1819','2040','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('536','545','PREDNISOLONA 10 MG BLISTER','1','14','55','35','65','69.55','78','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('537','546','PREDNISOLONA 10 MG COMPRIMIDO','1','14','55','4','10','10.7','12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('538','547','PREDNISOLONA 20 MG BLISTER','1','14','55','56','94','100.58','112.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('539','548','PREDNISOLONA 20 MG COMPRIMIDO','1','14','55','6','15','16.05','18','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('540','549','PRETAL DE CUERO 5','2','46','5','258.5','400.4','428.428','480.48','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('541','550','TONIPET BLISTER','1','26','10','35','75','80.25','90','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('542','551','ESPUMA SECA','1','44','58','118','189','202.23','226.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('543','552','COLLAR 0001','2','47','5','50','90','96.3','108','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('544','553','COLLAR DE AHORQUE 3524','2','24','5','99','176','188.32','211.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('545','554','COLLAR DE AHORQUE 4028','2','24','5','154','242','258.94','290.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('546','555','COLLAR DE CUERO CRUDO SIN DIJE','4','19','18','50','128','136.96','153.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('547','556','COLLAR DE SEMIAHORQUE POLIPROPILENO-CADENA','2','24','5','88','137.5','147.125','165','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('548','557','COLLAR DE SEMIAHORQUE CON PUAS CHICO','2','24','5','352','484','517.88','580.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('549','558','COLLAR DE SEMIAHORQUE CON PUAS GRANDE','2','24','5','445.5','660','706.2','792','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('550','559','COLLAR DE NYLON','2','22','4','129.8','275','294.25','330','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('551','560','COLLAR REFLECTIVO 15-40','2','22','4','35','72','77.04','86.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('552','561','CUENTA GANADOS CUERO CRUDO','4','19','18','130','280','299.6','336','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('553','562','HUESO DE CUERO 11/12','3','31','52','151','234','250.38','280.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('554','563','HUESO DE CUERO 3/4','3','31','52','22','34','36.38','40.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('555','564','HUESO DE CUERO 5/6','3','31','52','34','52','55.64','62.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('556','565','HUESO DE CUERO 7/8','3','31','52','61.26','94','100.58','112.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('557','566','HUESO DE CUERO 8/9','3','31','52','79.1','122','130.54','146.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('558','567','MOTILSEC COMPRIMIDO INDIVIDUAL','1','43','37','11','27','28.89','32.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('559','568','ENJUAGUE','2','9','64','125','196','209.72','235.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('560','569','LOCIÓN 50 ML','2','9','64','71.1','120','128.4','144','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('561','570','PROTECTOR SOLAR','2','9','64','200','378','404.46','453.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('562','571','LOCION NATURAL NEEM','2','9','64','70','155','165.85','186','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('563','572','OUT','5','38','38','40','90','96.3','108','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('564','573','OVIMIN','1','48','11','230','490','524.3','588','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('565','574','OXITESOL POLVO 1 KG','1','10','9','498','998','1067.86','1197.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('566','575','PROFEDIL 75 MG COMPRIMIDO','1','14','25','10','25','26.75','30','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('567','576','PRONAL','1','50','25','60','120','128.4','144','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('568','577','PROPOLVET SPRAY CICATRIZANTE','1','15','39','85','185','197.95','222','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('569','578','PULSERA DE ALPACA','4','19','18','70','130','139.1','156','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('570','579','PYO DERM 500 MG BLISTER','1','10','17','71','136','145.52','163.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('571','580','PYO DERM 500 MG COMPRIMIDO','1','10','17','7.2','18','19.26','21.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('572','581','RASCADOR','2','47','5','420','880','941.6','1056','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('573','582','RATITAS','2','47','5','20','44','47.08','52.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('574','583','AMPOLLA 2 ML','5','36','38','20','50','53.5','60','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('575','584','CEBO GRANULADO 50 GR','5','36','38','30','55','58.85','66','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('576','585','RECIPIENTE ESTERIL PARA ORINA','1','7','11','15','25','26.75','30','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('577','587','RIMADYL 25 MG COMPRIMIDO','1','14','19','12','19','20.33','22.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('578','588','RIMADYL 75 MG COMPRIMIDO','1','14','19','16.3','31','33.17','37.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('579','589','RUMICLAMOX 250 MG (BLISTER)','1','10','65','126','239','255.73','286.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('580','590','RUMICLAMOX 250 MG (COMPRIMIDOS)','1','10','65','10','29','31.03','34.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('581','591','RUMICLAMOX 500 MG (BLISTER)','1','10','65','170','295','315.65','354','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('582','592','RUMICLAMOX 500 MG (COMPRIMIDOS)','1','10','65','17','38','40.66','45.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('583','593','SEMILLAS','6','51','66','40','50','53.5','60','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('584','594','CESPED 500 GR','6','51','66','163','260','278.2','312','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('585','595','SHAMPOO MASCOTAS 250 ML','2','9','5','15.5','80','85.6','96','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('586','596','SHAMPOO PULGAS Y GARRAPATAS (2 EN 1)','2','9','64','115','189','202.23','226.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('587','597','SHAMPOO ALGAS ','2','9','64','97.2','160','171.2','192','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('588','598','SHAMPOO ALOE-AVENA','2','9','64','127.2','210','224.7','252','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('589','599','SHAMPOO REFRESCANTE ','2','9','64','127.7','210','224.7','252','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('590','600','SHAMPOO CON AMITRAZ','2','9','64','108','170','181.9','204','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('591','601','SHAMPOO ANTISEBORREICO','2','9','64','142','234','250.38','280.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('592','602','SHAMPOO CLORHEXIDINA','2','9','64','95','156','166.92','187.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('593','603','SHAMPOO GATO MAXIMO COLOR','2','9','64','80','130','139.1','156','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('594','604','SHAMPOO HIPOALERGENICO','2','9','64','89.15','146','156.22','175.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('595','605','SHAMPOO KETOCONAZOL','2','9','64','152','250','267.5','300','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('596','606','SHAMPOO KETOCONAZOL','2','9','64','152','250','267.5','300','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('597','607','SHAMPOO MAXIMO COLOR B-B-N','2','9','64','100','170','181.9','204','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('598','608','SHAMPOO PERFUMADO MIX FRUTAL ','2','9','64','89','146','156.22','175.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('599','609','SHAMPOO PULGAS Y GARRAPATAS ADULTO','2','9','64','115','189','202.23','226.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('600','610','SHAMPOO PULGAS Y GARRAPATAS CACHORRO','2','9','64','99','163','174.41','195.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('601','611','SHAMPOO PULGAS GATO','2','9','64','92.4','152','162.64','182.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('602','612','SOLUCION FISIOLOGICA 500 MG','1','7','36','46','66','70.62','79.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('603','613','STORM ','5','36','42','320','7','7.49','8.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('604','614','SULFATO DE HIERRO 500 MG ','6','32','66','92.4','154','164.78','184.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('605','615','T4 F (BLISTER)','1','52','55','59.89','102','109.14','122.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('606','616','TABLA PARA ASADO N1','4','19','67','80','120','128.4','144','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('607','617','TABLA PARA ASADO N2','4','19','67','120','280','299.6','336','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('608','618','TAU CON ANTIBIOTICO','1','53','56','156','270','288.9','324','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('609','619','TAU CON ESTEROIDES','1','53','56','173','296','316.72','355.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('610','620','TEA 327 COLLAR GATOS','1','11','22','177','284','303.88','340.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('611','621','TEA 327 COLLAR CACHORROS','1','11','22','187.47','312','333.84','374.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('612','622','TEA 327 COLLAR PERROS CHICOS-MEDIANOS ','1','11','22','228.86','381','407.67','457.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('613','623','TEA 327 COLLAR PERROS GRANDES','1','11','22','236.31','437','467.59','524.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('614','624','TEA 327 LIQUIDO 70ML','1','11','22','113','203','217.21','243.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('615','625','TERMIXAN CEBO GRANULADO 2 EN 1','5','36','44','26','80','85.6','96','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('616','626','TONANVIT 100ML','1','26','68','173','292','312.44','350.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('617','627','TORTUGA BUBBLES','2','5','5','100','175','187.25','210','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('618','628','TRAMPA ADHESIVA CHICA','5','36','38','24','49','52.43','58.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('619','629','TRAMPA ADHESIVA GRANDE','5','36','38','38','70','74.9','84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('620','630','TRAMPA MADERA CHICA','5','36','38','21','37','39.59','44.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('621','631','TRAMPA MADERA GRANDE','5','36','38','39','65','69.55','78','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('622','632','TRANSOVULAR 120MG','1','50','9','25.3','50','53.5','60','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('623','633','TRAMPA PARA MOSCA ECOLOGICA','5','30','69','110','205','219.35','246','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('624','634','TUBO PARA PECERA ','2','5','5','10','30','32.1','36','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('625','635','ULTRA PUM CEBO MOSCAS 30GR','5','30','38','30','60','64.2','72','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('626','636','UREA 500 GR','6','32','66','66','104.5','111.815','125.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('627','637','VAINA 1','4','19','67','25','50','53.5','60','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('628','638','VAINA 2','4','19','67','35','70','74.9','84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('629','639','VAINA 3','4','19','67','40','95','101.65','114','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('630','640','VAINA 6','4','19','67','130','190','203.3','228','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('631','641','VASELINA LIQUIDA 125 ML','1','6','36','54.6','99.75','106.732','119.7','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('632','642','VENDA CO-FLEX 10 CM','1','6','36','78.75','136.5','146.055','163.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('633','643','VENDA CO-FLEX 5 CM','1','6','36','50.4','94.5','101.115','113.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('634','644','VENDA TIPO CAMBRIC 10 CM','1','6','36','26.25','47.25','50.5575','56.7','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('635','645','VENDA TIPO CAMBRIC 7 CM','1','6','36','18.9','47.25','50.5575','56.7','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('636','646','VIRACEL 1 AMP','1','10','25','34','70','74.9','84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('637','647','MATE DE ALPACA CON PIE','4','19','67','150','379','405.53','454.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('638','648','MATE DE ALPACA SIN PIE','4','19','67','150','297','317.79','356.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('639','649','MATE DE CAÑA','4','19','67','40','80','85.6','96','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('640','650','MATE DE CUERO VAQUETA','4','19','67','240','400','428','480','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('641','651','MATE DE MADERA','4','19','67','65','100','107','120','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('642','652','MATE PATA - HUEVO DE TORO','4','19','67','90','230','246.1','276','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('643','653','YERBERA - AZUCARERA CUADRADA SIMIL','4','19','67','210','340','363.8','408','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('644','654','YERBERA - AZUCARERA REDONDA SIMIL','4','19','67','200','310','331.7','372','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('645','655','YUNTA DE ALPACA 2','4','19','67','200','315','337.05','378','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('646','656','JUEGO CUCHILLO SCHMIEDEN CON ALPACA','4','19','50','1050','1700','1819','2040','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('647','657','CUCHILLO TANDIL CAVOS REGIONALES 10','4','19','47','380','600','642','720','0');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('648','658','CUCHILLO TANDIL UÑA 14','4','19','47','420','715','765.05','858','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('649','659','CUCHILLO TANDIL CAVOS VARIOS 16','4','19','47','440','704','753.28','844.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('650','660','CUCHILLO TANDIL CAVOS VARIOS 10','4','19','47','380','600','642','720','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('651','661','CUCHILLO TANDIL CAVOS VARIOS 14','4','19','47','420','672','719.04','806.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('652','662','CUCHILLO TANDIL JUEGO','4','19','47','640','960','1027.2','1152','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('653','663','BEBEDERO ACRILICO AVES 1','2','18','5','21.05','40','42.8','48','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('654','664','PAÑO PET 60 X 90 BOLSA X 10 UNIDADES','2','16','5','422','610','652.7','732','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('655','665','NUTRIVET 500 GR','3','27','52','191','324','346.68','388.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('656','666','ECTHOL 5 X 70 ML','1','11','10','110','188','201.16','225.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('657','667','IVERMEC 100 ML','1','11','70','138.5','277','296.39','332.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('658','668','CREMA KUALCODERM 20 GR','1','10','39','97','185','197.95','222','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('659','669','CUCHILLO TANDIL UÑA 16','4','19','47','440','750','802.5','900','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('660','670','CUCHILLO TANDIL CAVOS VARIOS 20','4','19','47','480','768','821.76','921.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('661','671','CUCHILLO TANDIL CAVOS VARIOS 24','4','19','47','500','820','877.4','984','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('662','672','CUCHILLO TANDIL CAVOS VARIOS 28','4','19','47','560','905','968.35','1086','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('663','673','CUCHILLO TANDIL TEJIDO 14','4','19','47','450','900','963','1080','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('664','674','MEDALLA 2','2','17','5','27','64','68.48','76.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('665','675','REPELENTE DOG OUT 500ML','1','44','36','73.1','130','139.1','156','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('666','676','AEROSOL RUMINAL AMBIENTAL','1','11','65','217','400','428','480','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('667','677','AEROSOL TEA 327','1','11','22','181.16','345','369.15','414','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('668','678','TALCO TEA','1','11','22','108','189','202.23','226.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('669','679','SHAMPOO FORMULA MC DONALD','1','44','17','179.76','290','310.3','348','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('670','680','SHAMPOO TEA','1','44','22','168.88','289','309.23','346.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('671','681','MV RENAL PERRO 2 KG','3','27','63','317','436','466.52','523.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('672','682','FRONTLINE PLUS 2 - 10 KG','1','11','60','276.3','460','492.2','552','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('673','683','DAVITAN C ','1','26','25','173.5','313','334.91','375.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('674','684','PERFOS 5 - 10 ','1','11','39','80','125','133.75','150','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('675','685','PERFOS  20 - 40','1','11','39','100','200','214','240','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('676','686','SIMPARICA 1.3 - 2.5','1','11','19','297','474','507.18','568.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('677','687','SIMPARICA 2.5 - 5','1','11','19','320','512','547.84','614.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('678','688','SIMPARICA 5 - 10','1','11','19','326','521','557.47','625.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('679','689','SIMPARICA 10 - 20','1','11','19','423','676','723.32','811.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('680','690','SIMPARICA 20 - 40','1','11','19','496','793','848.51','951.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('681','691','SIMPARICA 40 - 60','1','11','19','580','928','992.96','1113.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('682','692','MV CARDIACO  2 KG','3','27','63','341.49','475','508.25','570','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('683','693','MV OBESIDAD 2 KG','3','28','63','421.44','532','569.24','638.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('684','694','MV SENSIBILIDAD DIETARIA 2 KG','3','27','63','366.48','505','540.35','606','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('685','695','WHOLE EARTH FARMS ADULTO 12 KG','3','27','27','1586','2062','2206.34','2474.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('686','696','WHOLE EARTH FARMS CACHORRO 7.5 KG','3','27','27','1207','1569','1678.83','1882.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('687','697','JUEGO PARRILLERO LARGO','4','45','47','792','1386','1483.02','1663.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('688','698','JUEGO TRINCHAR CORTO','4','45','47','682','1227.6','1313.53','1473.12','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('689','699','EXPLOSION VERDE','6','32','66','2.2','170.5','182.435','204.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('690','700','CUCHILLO','4','45','71','988.9','1639','1753.73','1966.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('691','701','TRIHEPAT','1','3','56','312','520','556.4','624','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('692','702','TALCO RUMINAL','1','11','65','82.3','160','171.2','192','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('693','703','SOSTEN CG 5 C.C.','1','48','72','280','450','481.5','540','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('694','704','MV URINARY 7.5 KG','3','28','63','1210.24','1530','1637.1','1836','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('695','705','RUMINAL 88 LIQUIDO','1','11','65','90','171','182.97','205.2','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('696','706','POLFEN BLISTER ','1','14','39','35','70','74.9','84','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('697','707','POLFEN COMPRIMIDO','1','14','39','4','15','16.05','18','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('698','708','COMEDERO ACERO N1','2','18','4','61','110','117.7','132','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('699','709','TOP NUTRITION PIEL SENSIBLE 15 KG','3','27','26','1573.6','2045','2188.15','2454','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('700','710','CURABICHERA BACTROVET PLATA','1','11','22','185','299','319.93','358.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('701','711','TALCO PERFOS','1','11','39','68.5','137','146.59','164.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('702','712','CANBABY','3','27','52','129','232','248.24','278.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('703','713','MATE IRROMPIBLE','4','19','18','190','315','337.05','378','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('704','714','JUEGO TABLA-CUBIERTOS CON VASO','4','19','18','480','790','845.3','948','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('705','715','PORTA TERMO 1','4','19','18','490','833','891.31','999.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('706','716','SALES REHIDRATANTES','1','43','16','32','64','68.48','76.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('707','717','PELOTA DURA 3','2','47','5','158','298','318.86','357.6','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('708','718','COLLAR REFLECTIVO 30-60','2','22','4','67.2','135','144.45','162','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('709','719','MAMADERA COMPLETA','2','47','5','165','279','298.53','334.8','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('710','720','ECTHOL COLLAR GATO','1','11','10','188','300','321','360','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('711','721','ECTHOL COLLAR CHICO','1','11','10','188','300','321','360','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('712','722','ECTHOL COLLAR GRANDE','1','11','10','207.5','332','355.24','398.4','1');
INSERT INTO `producto` (`idproducto`,`codigo`,`nombre`,`rubro_idRubro`,`subRubro_idSubRubro`,`marca_idmarca`,`precioCosto`,`precioEfectivo`,`precio2`,`precio3`,`estado`) VALUES
('713','723','ENROFLOXACINA 50 MG BLISTER ','1','10','55','60.4','120','128.4','144','1');



-- -------------------------------------------
-- TABLE DATA provincia
-- -------------------------------------------
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('24','Buenos Aires','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('25','Catamarca','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('26','Chaco','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('27','Chubut','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('28','Córdoba','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('29','Corrientes','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('30','Entre Ríos','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('31','Formosa','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('32','Jujuy','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('33','La Pampa','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('34','La Rioja','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('35','Mendoza','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('36','Misiones','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('37','Neuquén','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('38','Río Negro','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('39','Salta','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('40','San Juan','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('41','San Luis','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('42','Santa Cruz','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('43','Santa Fe','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('44','Santiago del Estero','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('45','Tierra del Fuego','1');
INSERT INTO `provincia` (`idprovincia`,`nombre`,`estado`) VALUES
('46','Tucumán','1');



-- -------------------------------------------
-- TABLE DATA raza
-- -------------------------------------------
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('1','1','MESTIZO','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('2','1','PASTOR ALEMAN','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('3','1','GOLDEN RETRIEVER','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('4','1','BORDER COLLIE','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('5','1','COLLIE','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('6','1','ROTWEILER','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('7','1','LABRADOR RETRIEVER','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('8','1','CANICHE','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('9','1','BEAGLE','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('10','1','PUG','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('11','1','DACHSHUND','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('12','1','SHORKSHIRE TERRIER','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('13','1','SAMOYEDO','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('14','1','SHAR PEI','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('15','1','BULLDOG INGLES','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('16','1','BULLDOG FRANCES','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('17','1','BOXER','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('18','1','BULL TERRIER','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('19','1','CHIHUAHUA','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('20','1','DOGO ARGENTINO','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('21','1','CHOW CHOW','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('22','1','PIT BULL','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('23','1','GALGO ESPAÑOL','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('24','1','GRAN DANES','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('25','1','BICHON FRISE','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('26','1','COCKER SPANIEL','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('27','1','PASTOR BELGA','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('28','1','BASSET HOUND','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('29','1','PINSCHER MINIATURA','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('30','1','PEKINES','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('31','1','POINTER','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('32','1','BICHON MALTES','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('33','1','SHIH TZU','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('34','1','STAFFORDSHIRE AMERICANO','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('35','1','WEST HIGHLAND','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('36','1','CRESTADO CHINO','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('37','1','AIREDALE TERRIER','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('38','1','BRACO DE WEIMAR','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('39','2','SIAMES','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('40','2','PERSA','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('41','2','ANGORA','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('42','2','MESTIZO','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('43','1','JACK RUSSEL','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('44','1','AMERICAN BULLY','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('45','1','SCHNAUZER','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('46','1','VIZLA','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('47','1','DOGO DE BURDEOS','1');
INSERT INTO `raza` (`idraza`,`especie_idespecie`,`nombre`,`estado`) VALUES
('48','1','FOX TERRIER','1');



-- -------------------------------------------
-- TABLE DATA rubro
-- -------------------------------------------
INSERT INTO `rubro` (`idRubro`,`nombre`,`estado`) VALUES
('1','MEDICAMENTOS','1');
INSERT INTO `rubro` (`idRubro`,`nombre`,`estado`) VALUES
('2','ACCESORIOS','1');
INSERT INTO `rubro` (`idRubro`,`nombre`,`estado`) VALUES
('3','ALIMENTOS','1');
INSERT INTO `rubro` (`idRubro`,`nombre`,`estado`) VALUES
('4','REGALERIA','1');
INSERT INTO `rubro` (`idRubro`,`nombre`,`estado`) VALUES
('5','VENENOS','1');
INSERT INTO `rubro` (`idRubro`,`nombre`,`estado`) VALUES
('6','JARDIN','1');



-- -------------------------------------------
-- TABLE DATA subrubro
-- -------------------------------------------
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('1','PROPANTELINA','1','0');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('2','ABRIGOS','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('3','PROTECTOR HEPATICO','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('4','SEDANTE','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('5','ACUARIO','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('6','PRIMEROS AUXILIOS ','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('7','DESCARTABLES','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('8','ANALGESICO','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('9','PELUQUERIA','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('10','ANTIBIOTICO','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('11','ANTIPARASITARIO','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('12','EQUINOS','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('13','JOYERIA','4','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('14','ANTIINFLAMATORIO','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('15','CREMAS','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('16','SANITARIOS','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('17','IDENTIFICACION','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('18','BEBEDEROS Y COMEDEROS','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('19','REGALERIA','4','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('20','TRANSPORTADORES','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('21','BOZALES','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('22','COLLARES-CORREAS-PRETALES POLIPROPILENO','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('23','CADENAS','2','0');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('24','CADENAS','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('25','PRETALES','2','0');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('26','VITAMINAS','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('27','CANINO','3','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('28','FELINO','3','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('29','HORMIGAS','5','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('30','INSECTICIDA','5','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('31','GOLOSINAS ','3','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('32','FERTILIZANTES','6','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('33','ANTIDIARREICOS','1','0');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('34','SEGURIDAD','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('35','DIURETICOS','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('36','RATONES','5','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('37','BABOSAS Y CARACOLES','5','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('38','CUCARACHAS','5','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('39','HERBICIDA','5','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('40','HAMSTER','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('41','AVES','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('42','ANTIMICOTICO','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('43','GASTROINTESTINALES','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('44','SANITARIOS','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('45','CUCHILLOS','4','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('46','COLLARES-CORREAS-PRETALES CUERO','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('47','VARIOS','2','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('48','ANTIARTROSICOS','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('49','LECHE','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('50','ANOVULATORIOS','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('51','SEMILLAS','6','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('52','HORMONALES','1','1');
INSERT INTO `subrubro` (`idSubRubro`,`nombre`,`rubro_idRubro`,`estado`) VALUES
('53','OFTALMOLOGICOS','1','1');



-- -------------------------------------------
-- TABLE DATA tipoconsulta
-- -------------------------------------------
INSERT INTO `tipoconsulta` (`idtipoConsulta`,`nombre`,`estado`) VALUES
('1','CONSULTA','0');
INSERT INTO `tipoconsulta` (`idtipoConsulta`,`nombre`,`estado`) VALUES
('2','CONSULTA GENERAL','1');
INSERT INTO `tipoconsulta` (`idtipoConsulta`,`nombre`,`estado`) VALUES
('3','VACUNACION','1');
INSERT INTO `tipoconsulta` (`idtipoConsulta`,`nombre`,`estado`) VALUES
('4','DESPARASITACIÓN','1');
INSERT INTO `tipoconsulta` (`idtipoConsulta`,`nombre`,`estado`) VALUES
('5','INTERNACIÓN','1');
INSERT INTO `tipoconsulta` (`idtipoConsulta`,`nombre`,`estado`) VALUES
('6','CIRUGÍA','1');
INSERT INTO `tipoconsulta` (`idtipoConsulta`,`nombre`,`estado`) VALUES
('7','CONTROL','1');
INSERT INTO `tipoconsulta` (`idtipoConsulta`,`nombre`,`estado`) VALUES
('8','ANOVULATORIO','1');



-- -------------------------------------------
-- TABLE DATA tipodocumento
-- -------------------------------------------
INSERT INTO `tipodocumento` (`idtipoDocumento`,`nombre`,`estado`) VALUES
('4','DNI','1');
INSERT INTO `tipodocumento` (`idtipoDocumento`,`nombre`,`estado`) VALUES
('5','CUIT','1');
INSERT INTO `tipodocumento` (`idtipoDocumento`,`nombre`,`estado`) VALUES
('6','CUIL','1');



-- -------------------------------------------
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
COMMIT;
-- -------------------------------------------
-- -------------------------------------------
-- END BACKUP
-- -------------------------------------------
