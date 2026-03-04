CREATE DATABASE `medsys`
DEFAULT COLLATE utf8_general_ci;

USE `medsys`;
-- DROP DATABASE medsys;
CREATE TABLE `Usuario` (
	`uid` INT AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL,
	`email` VARCHAR(100) NOT NULL UNIQUE,
    `telefone` VARCHAR(20) NOT NULL,
    `genero` ENUM('m', 'f') NOT NULL,
	`password` VARCHAR(255) NOT NULL,
	`profile` ENUM('admin', 'medico', 'funcionario', 'paciente') NOT NULL DEFAULT 'paciente',
    `data_criacao` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(`uid`)    
)CHAR SET utf8;

INSERT INTO `Usuario` ( `name`, `email`, `telefone`,  `genero`, `password`, `profile`)
VALUES 	('paciente1', 'paciente1@gmail.com', '+244928740538', 'm', '12345', 'paciente'),
		('paciente2', 'paciente2@gmail.com', '+244928740538', 'f', '12345', 'paciente'),
		('funcionario1', 'funcionario1@gmail.com', '+244928740538', 'm', '12345', 'funcionario'),
		('funcionario2', 'funcionario2@gmail.com', '+244928740538', 'f', '12345', 'funcionario'),
		('doc1', 'doc1@gmail.com', '+244928740538', 'm', '12345', 'medico'),
		('doc2', 'doc2@gmail.com', '+244928740538', 'f', '12345', 'medico');

  CREATE TABLE `Funcionario` (
	`id` INT AUTO_INCREMENT,
	`uid` INT UNIQUE,
	`name` VARCHAR(100) NOT NULL,
	`bi_passaporte` VARCHAR(14) NOT NULL UNIQUE,
    `cargo` VARCHAR(100) NOT NULL DEFAULT '',
    `endereco` TEXT DEFAULT '',
	PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `Usuario`(`uid`)
)CHAR SET utf8;

INSERT INTO `Funcionario` (`uid`, `name`, `bi_passaporte`, `cargo`)
VALUES 	(3, 'funcionario1', 'bi00003', 'recepcionista'),
		(4, 'funcionario2', 'bi00004', 'emfermeiro');

CREATE TABLE `Grupo_sanguineo` (
	`id` INT AUTO_INCREMENT,
    `name` VARCHAR(3) NOT NULL,
    PRIMARY KEY(`id`)
)CHAR SET utf8;

INSERT INTO `Grupo_sanguineo` (`name`) 
VALUES ('A+'), ('A-'), ('B+'), ('B-'), ('AB+'), ('AB-'), ('O+'), ('O-');

CREATE TABLE `Especialidade` (
	`id` INT AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL UNIQUE,
	`descricao` TEXT DEFAULT 'Para pesquisar',
    PRIMARY KEY(`id`)
) CHAR SET utf8;

INSERT INTO `Especialidade` (`name`, `descricao`)
VALUES 	('Acilo Facial', DEFAULT), ('Alergia e Imunologia', 'Alergia e Imunologia é a área especialisada que foca no diagnóstico e no tratamento de doenças alérgicas. Os profissionais trabalham com o sistema imune e com o diagnóstico e identificação das patologias e seus diferentes graus no organismo dos pacientes.'),
		('Anestesiologia', 'Anestesiologia é a área especialisada que atuam no pré e no pós-operatório, trabalhando com a aplicação de medicamentos que mitiguem os efeitos da dor durante os procedimentos.'),
        ('Audiologia', DEFAULT), ('Cardiologia', 'Cardiologista é a área especialisada focado no diagnóstico precoce de doenças no coração, atuando na prevenção de doenças no sistema circulatório como um todo, na musculatura cardíaca e no próprio coração.'),
        ('Cirurgia Plástica', 'Cirurgia Plástica é a área especialisada que trabalha com alterações na aparência física dos pacientes em diferentes regiões do corpo, e atuam em procedimentos de reparação, reconstrução de trauma, patologias e na área estética.'), 
        ('Cuidados Intensivos', DEFAULT), ('Dermatologia', 'Dermatologia é a área especialisada responsável por procedimentos clínicos e cirúrgicos nos tecidos do corpo como pele, cabelos e unhas. Essa área exige grande contato com pacientes e possui atuação em diferentes locais, incluindo hospitais, ambulatórios, consultórios e clínicas.'),
        ('Endocrinologia', DEFAULT), ('Estomatologia', DEFAULT), ('Farmácia', DEFAULT), ('Fisioterapia', DEFAULT), ('Gastroenterologia', DEFAULT), ('Hematologia', DEFAULT), ('Imagiologia', DEFAULT), ('Medicina Interna', DEFAULT), ('Nefrologia Hemodiálise', DEFAULT), 
        ('Neurologia', 'Neurologia é a área especialisada que trabalha com as patologias e condições ligadas ao sistema nervoso, sendo essa uma das atuações mais delicadas e com maior exigência de precisão e treinamento.'), 
        ('Oftalmologia', 'Oftalmologista é a área especialisada que estuda e tratam as doenças e patologias relacionadas ao olho, nervo óptico, à refração, e aos anexos do sistema de visão. Os oftalmologistas podem realizar cirurgias, prescrever tratamentos e realizar correções em distúrbios de visão.'), 
        ('ORL', DEFAULT), ('Ortopedia', 'Ortopedia é a área que trabalha no movimento e sustentação do corpo com especial atenção para articulações, músculos, nervos, ligamentos, tendões e ossos.'), 
        ('Pedriatria', 'Pediatria é á área especialisada no atendimento e assistência às crianças e adolescentes dentro da atuação preventiva e curativa. Atuam em hospitais, clínicas e consultórios.'), 
        ('Pneumologia', DEFAULT), ('Psicologia', DEFAULT), ('Urologia', 'Urologista é a área especialisada que trabalha com o trato urinário de homens e mulheres e do sistema reprodutor de pessoas do sexo masculino. Os urologistas tratam e acompanham os pacientes com distúrbios urológicos, doenças no trato urinário, doenças sexualmente transmissíveis e mais.');
  
CREATE TABLE `Medico` (
	`id` INT AUTO_INCREMENT,
    `uid` INT UNIQUE,
    `id_especialidade` INT,
	`name` VARCHAR(100) NOT NULL,
    `bi_passaporte` VARCHAR(14) NOT NULL UNIQUE,
    `endereco` TEXT DEFAULT '',
	PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `Usuario`(`uid`),
    FOREIGN KEY(`id_especialidade`) REFERENCES `Especialidade`(`id`)
)CHAR SET utf8;

INSERT INTO `Medico` (`uid`, `id_especialidade`, `name`, `bi_passaporte`, `endereco`)
VALUES 	(5, 1, 'medico1', 'bi00005', 'Luanda'),
		(6, 4, 'medico2', 'bi00006', 'Luanda');      

CREATE TABLE `Paciente` (
	`id` INT AUTO_INCREMENT,
	`uid` INT UNIQUE,
    `gr_sanguineo_id` INT,
    `name` VARCHAR(100) NOT NULL,
	`telefone` VARCHAR(20) NOT NULL,
	`bi_passaporte` VARCHAR(14) NOT NULL UNIQUE,
    `data_nascimento` DATE NOT NULL,
	`alergias` TEXT DEFAULT '',
    `endereco` TEXT DEFAULT '',
    PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `Usuario`(`uid`),
	FOREIGN KEY(`gr_sanguineo_id`) REFERENCES `Grupo_sanguineo`(`id`)
)CHAR SET utf8;

INSERT INTO Paciente 
(`uid`, `gr_sanguineo_id`, `name`, `telefone`, `bi_passaporte`, `data_nascimento`, `alergias`, `endereco`)
VALUES
(1, 2, 'paciente1', '+244900000001', 'bi10001', '2000-02-10', 'nenhuma', 'Luanda'),
( 2, 8, 'paciente2', '+244900000002', 'bi10002', '1995-06-15', 'penicilina', 'Benguela');

CREATE TABLE `Triagem` (
	`id` INT AUTO_INCREMENT,
	`idfuncionario` INT,
    `idpaciente` INT,
	`peso` DOUBLE NOT NULL,
	`temperatura` DOUBLE NOT NULL,
	`observacoes` TEXT,
	`data_triagem` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`idfuncionario`) REFERENCES `Funcionario`(`id`),
	FOREIGN KEY(`idpaciente`) REFERENCES `Paciente`(`id`)
)CHAR SET utf8;

INSERT INTO Triagem
(idfuncionario, idpaciente, peso, temperatura, observacoes, data_triagem)
VALUES (1, 1, 70.5, 36.5, 'Normal', NOW()),
	   (2, 2, 65.2, 37.8, 'Febre leve', NOW());

CREATE TABLE `Consulta` (
	`id` INT AUTO_INCREMENT,
	`idtriagem` INT NOT NULL,
	`idmedico` INT NOT NULL,
	`data_consulta` DATE NOT NULL,
    `hora_marcada` TIME NOT NULL,
	`status` ENUM('marcada', 'em_andamento', 'finalizada', 'cancelada') NOT NULL DEFAULT 'marcada',
    `observacoes` TEXT,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`idtriagem`) REFERENCES `Triagem`(`id`),
    FOREIGN KEY(`idmedico`) REFERENCES `Medico`(`id`)
)CHAR SET utf8;

INSERT INTO Consulta
(`idtriagem`, `idmedico`, `data_consulta`, `hora_marcada`, `status`, `observacoes`)
VALUES
(1, 1, '2026-03-05', '09:00:00', 'marcada', 'Primeira consulta'),
(2, 2, '2026-03-05', '10:00:00', 'finalizada', 'Paciente medicado');

CREATE TABLE `Exame` (
	`id` INT AUTO_INCREMENT,
	`idconsulta` INT,
	`data_exame` DATETIME NOT NULL,
    `tipo_exame` TEXT,
    `resultado` TEXT,
	PRIMARY KEY(`id`),
    FOREIGN KEY(`idconsulta`) REFERENCES `Consulta`(`id`)
)CHAR SET utf8;

CREATE TABLE `Diagnostico` (
	`id` INT AUTO_INCREMENT,
	`idconsulta` INT,
	`descricao` TEXT,
    `observacao` TEXT,
    `data_diagnostico` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`idconsulta`) REFERENCES `Consulta`(`id`)
)CHAR SET utf8;

INSERT INTO Diagnostico
(idconsulta, descricao, observacao, data_diagnostico)
VALUES
(1, 'Gripe', 'Caso leve', NOW()),
(2, 'Infecção', 'Precisa antibiótico', NOW());


CREATE TABLE `Receita` (
	`id` INT AUTO_INCREMENT,
	`id_diagnostico` INT,
	`id_medico` INT,
	`data_receita` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`obsercacao` TEXT NOT NULL,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`id_diagnostico`) REFERENCES `Diagnostico`(`id`),
    FOREIGN KEY(`id_medico`) REFERENCES `Medico`(`id`)
	-- adicionar paciente
)CHAR SET utf8;

INSERT INTO Receita
(id_diagnostico, id_medico, data_receita, obsercacao)
VALUES
(1, 1, NOW(), 'Tomar por 5 dias'),
(2, 2, NOW(), 'Tomar por 7 dias');

CREATE TABLE `Itemsreceita` (
	`id` INT AUTO_INCREMENT,
	`idreceita` INT,
	`remedios` TEXT NOT NULL,
	`dosagem` TEXT NOT NULL,
	`frequencia` TEXT NOT NULL,
	PRIMARY KEY(`id`),
    FOREIGN KEY(`idreceita`) REFERENCES `Receita`(`id`)
)CHAR SET utf8;

INSERT INTO Itemsreceita
(idreceita, remedios, dosagem, frequencia)
VALUES
(1, 'Paracetamol', '500mg', '8/8h'),
(2, 'Amoxicilina', '500mg', '12/12h');

CREATE TABLE `Prontuarios`(
	`id` INT AUTO_INCREMENT,
    `id_consulta` INT UNIQUE,
    `sintomas` TEXT,
    `diagnostico` TEXT,
    `tratamento` TEXT,
    `observacoes` TEXT,
    `data_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_consulta`) REFERENCES `Consulta`(`id`)
)CHAR SET utf8;

INSERT INTO Prontuarios
(id_consulta, sintomas, diagnostico, tratamento, observacoes)
VALUES
(1, 'Febre e tosse', 'Gripe', 'Antitérmico', 'Retorno em 3 dias'),
(2, 'Dor abdominal', 'Infecção', 'Antibiótico', 'Monitorar');

CREATE TABLE `Quarto` (
	`id` INT AUTO_INCREMENT,
    `leitos` INT NOT NULL,
	`especialidade` TEXT,
    `piso` INT,
    PRIMARY KEY(`id`)
)CHAR SET utf8;

INSERT INTO Quarto
(leitos, especialidade, piso)
VALUES
(2, 'Cardiologia', 1),
(1, 'Neurologia', 2),
(3, 'Pediatria', 1),
(2, 'Ortopedia', 3);

CREATE TABLE `Internamento` (
	`id` INT AUTO_INCREMENT,
	-- idpaceinte INT NOT NULL,
	`idconsulta` INT NOT NULL,
    `idquarto` INT NOT NULL,
    `data_entrada` DATE NOT NULL,
    `data_saida` DATE NOT NULL,
	`tipo_alta` ENUM('Alta medica', 'Transferencia', 'Obito', 'Abandono') DEFAULT 'Alta medica',
    `observacao` TEXT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`idconsulta`) REFERENCES `Consulta`(`id`),
    FOREIGN KEY(`idquarto`) REFERENCES `Quarto`(`id`)
)CHAR SET utf8;

INSERT INTO Internamento
(idconsulta, idquarto, data_entrada, data_saida, tipo_alta)
VALUES
(1, 1, '2026-03-05', '2026-03-08', 'Alta medica'),
(2, 2, '2026-03-06', '2026-03-09', 'Transferencia');