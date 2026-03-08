CREATE DATABASE `medsys`
DEFAULT COLLATE utf8_general_ci;

USE `medsys`;
-- DROP DATABASE medsys;


-- Especialidades médicas para os médicos, para facilitar a organização e a identificação dos profissionais de saúde de acordo com suas áreas de atuação. Isso é importante para direcionar os pacientes ao especialista adequado e para a gestão interna do hospital.
CREATE TABLE `especialidade` (
	`id` INT AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL UNIQUE,
	`descricao` TEXT DEFAULT 'Para pesquisar',
    PRIMARY KEY(`id`)
) CHAR SET utf8;

INSERT INTO `especialidade` (`name`, `descricao`)
VALUES 	
('Acilo Facial', DEFAULT), ('Alergia e Imunologia', 'Alergia e Imunologia é a área especialisada que foca no diagnóstico e no tratamento de doenças alérgicas. Os profissionais trabalham com o sistema imune e com o diagnóstico e identificação das patologias e seus diferentes graus no organismo dos pacientes.'),
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


-- Grupo sanguineo para os pacientes, para facilitar a identificação e o tratamento em casos de transfusão ou outras necessidades médicas relacionadas ao sangue.
CREATE TABLE `blood_type` (
	`id` INT AUTO_INCREMENT,
    `name` VARCHAR(3) NOT NULL,
    PRIMARY KEY(`id`)
)CHAR SET utf8;

INSERT INTO `blood_type` (`name`) 
VALUES ('A+'), ('A-'), ('B+'), ('B-'), ('AB+'), ('AB-'), ('O+'), ('O-');


-- Tabela de usuários para o sistema, para armazenar as informações dos diferentes tipos de usuários (administradores, médicos, funcionários e pacientes) e facilitar a autenticação e a gestão de acesso ao sistema.
CREATE TABLE `usuario` (
	`uid` INT AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL,
	`email` VARCHAR(100) NOT NULL UNIQUE,
    `telefone` VARCHAR(20) NOT NULL,
    `genero` ENUM('m', 'f') NOT NULL,
	`endereco` TEXT NOT NULL DEFAULT '',
	`password` VARCHAR(255) NOT NULL,
	`profile` ENUM('admin', 'doctor', 'employee', 'patient') NOT NULL DEFAULT 'patient',
    `data_criacao` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(`uid`)    
)CHAR SET utf8;

INSERT INTO `usuario` ( `name`, `email`, `telefone`, `genero`, `endereco`, `password`, `profile`)
VALUES 	
('funcionario1', 'funcionario1@gmail.com', '+244928740538', 'm', DEFAULT, '12345', 'employee'),
		('funcionario2', 'funcionario2@gmail.com', '+244928740538', 'f', DEFAULT, '12345', 'employee'),
		('doc1', 'doc1@gmail.com', '+244928740538', 'm', DEFAULT, '12345', 'doctor'),
		('doc2', 'doc2@gmail.com', '+244928740538', 'f', DEFAULT, '12345', 'doctor'),
		('paciente1', 'paciente1@gmail.com', '+244928740538', 'm', 'Luanda-Angola', '12345', 'patient'),
		('paciente2', 'paciente2@gmail.com', '+244928740538', 'f', 'Gamek-Luanda', '12345', 'patient'),
		('paciente3', 'paciente3@gmail.com', '+244928740538', 'm', 'Luanda-Angola', '12345', 'patient'),
		('paciente4', 'paciente4@gmail.com', '+244928740538', 'f', 'Gamek-Luanda', '12345', 'patient');


-- Tabela de funcionários para o hospital, para armazenar as informações dos funcionários, incluindo o cargo e a associação com o usuário correspondente na tabela de usuários. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `funcionario` (
	`id` INT AUTO_INCREMENT,
	`uid` INT UNIQUE,
	`name` VARCHAR(100) NOT NULL,
    `cargo` VARCHAR(100) NOT NULL DEFAULT '',
	PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `usuario`(`uid`)
)CHAR SET utf8;

INSERT INTO `funcionario` (`uid`, `name`, `cargo`)
VALUES 	(3, 'funcionario1', 'recepcionista'),
		(4, 'funcionario2', 'emfermeiro');
  
-- Tabela de médicos para o hospital, para armazenar as informações dos médicos, incluindo a especialidade e a associação com o usuário correspondente na tabela de usuários. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `medico` (
	`id` INT AUTO_INCREMENT,
    `uid` INT UNIQUE,
    `id_especialidade` INT,
	`name` VARCHAR(100) NOT NULL,
	PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `usuario`(`uid`),
    FOREIGN KEY(`id_especialidade`) REFERENCES `especialidade`(`id`)
)CHAR SET utf8;

INSERT INTO `medico` (`uid`, `id_especialidade`, `name`)
VALUES 	(5, 1, 'medico1'),
		(6, 4, 'medico2');      


-- Tabela de pacientes para o hospital, para armazenar as informações dos pacientes, incluindo o tipo sanguíneo, alergias e a associação com o usuário correspondente na tabela de usuários. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `paciente` (
	`id` INT AUTO_INCREMENT, 
	`uid` INT NULL UNIQUE ,
    `id_blood_type` INT,
    `name` VARCHAR(100) NOT NULL,
	`telefone` VARCHAR(20) NOT NULL,
	`genero` ENUM('m', 'f') NOT NULL,
	`bi_passaporte` VARCHAR(14) NOT NULL UNIQUE,
    `data_nascimento` DATE NOT NULL,
	`alergias` TEXT NULL DEFAULT 'Nenhuma',
	`endereco` TEXT NOT NULL DEFAULT '',
    PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `usuario`(`uid`) ON DELETE SET NULL,
	FOREIGN KEY(`id_blood_type`) REFERENCES `blood_type`(`id`)
)CHAR SET utf8;

INSERT INTO Paciente 
(`uid`, `id_blood_type`, `name`, `telefone`, `genero`, `bi_passaporte`, `data_nascimento`, `alergias`, `endereco`)
VALUES
(1, 2, 'paciente1', '+244900000001', 'm', 'bi00001', '2000-02-10', DEFAULT, 'Luanda'),
( 2, 8, 'paciente2', '+244900000002', 'f', 'bi00002', '1995-06-15', 'Penicilina', 'Benguela'),
(NULL, 4, 'paciente1',  '+244928740538', 'm', 'bi00003', '1980-07-30', DEFAULT, 'Luanda-Angola'),
(NULL, 4, 'paciente2', '+244928740538', 'f', 'bi00004', '1994-10-15', 'Poeira', 'Gamek-Luanda'),
(NULL, 4, 'paciente3', '+244928740538', 'f', 'bi00005', '2000-04-06', 'Lactose', 'Luanda-Angola'),
(NULL, 4, 'paciente4', '+244928740538', 'm', 'bi00006', '1995-10-20', DEFAULT, 'Gamek-Luanda');

-- Tabela de triagem para o hospital, para armazenar as informações das triagens realizadas pelos funcionários, incluindo o peso, a temperatura e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `triagem` (
	`id` INT AUTO_INCREMENT,
	`id_funcionario` INT,
    `id_paciente` INT,
	`peso` DOUBLE NOT NULL,
	`temperatura` DOUBLE NOT NULL,
	`observacoes` TEXT,
	`data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`id_funcionario`) REFERENCES `funcionario`(`id`),
	FOREIGN KEY(`id_paciente`) REFERENCES `paciente`(`id`)
)CHAR SET utf8;

INSERT INTO triagem
(`id_funcionario`, `id_paciente`, `peso`, `temperatura`, `observacoes`, `data`)
VALUES (1, 1, 70.5, 36.5, 'Normal', NOW()),
	   (2, 2, 65.2, 37.8, 'Febre leve', NOW());

-- Tabela de consultas para o hospital, para armazenar as informações das consultas realizadas pelos médicos, incluindo a data, a hora marcada, o status e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `consulta` (
	`id` INT AUTO_INCREMENT,
	`id_triagem` INT NOT NULL,
	`id_medico` INT NOT NULL,
	`data_consulta` DATE NOT NULL,
    `hora_marcada` TIME NOT NULL,
	`status` ENUM('marcada', 'em_andamento', 'finalizada', 'cancelada') NOT NULL DEFAULT 'marcada',
    `observacoes` TEXT,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`id_triagem`) REFERENCES `triagem`(`id`),
    FOREIGN KEY(`id_medico`) REFERENCES `medico`(`id`)
)CHAR SET utf8;

INSERT INTO consulta
(`id_triagem`, `id_medico`, `data_consulta`, `hora_marcada`, `status`, `observacoes`)
VALUES
(1, 1, '2026-03-05', '09:00:00', 'marcada', 'Primeira consulta'),
(2, 2, '2026-03-05', '10:00:00', 'finalizada', 'Paciente medicado');


-- Tabela de tipos de exames para o hospital, para armazenar as informações dos diferentes tipos de exames disponíveis, incluindo a descrição. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde, além de fornecer informações claras aos pacientes sobre os exames realizados.
CREATE TABLE tipo_exame (
	`id` INT AUTO_INCREMENT,
	`name` VARCHAR(100) NOT NULL UNIQUE,
	`descricao` TEXT,
	PRIMARY KEY(`id`)
)CHAR SET utf8;

INSERT INTO tipo_exame
(`name`, `descricao`)
VALUES 
('Hemograma Completo', 'Exame de sangue que avalia os componentes do sangue, como glóbulos vermelhos, glóbulos brancos e plaquetas.'),
('Raio-X de Tórax', 'Exame de imagem que utiliza radiação para visualizar os órgãos e estruturas do tórax, como pulmões, coração e costelas.'),
('Ultrassonografia Abdominal', 'Exame de imagem que utiliza ondas sonoras para criar imagens dos órgãos abdominais, como fígado, rins e vesícula biliar.'),
('Eletrocardiograma (ECG)', 'Exame que registra a atividade elétrica do coração para avaliar o ritmo cardíaco e detectar possíveis anormalidades.'),
('Teste de Função Pulmonar', 'Exame que mede a capacidade pulmonar e a função respiratória para diagnosticar doenças pulmonares.'),
('Endoscopia Digestiva Alta', 'Exame que utiliza um endoscópio para visualizar o interior do esôfago, estômago e duodeno, auxiliando no diagnóstico de problemas gastrointestinais.'),
('Ressonância Magnética (RM)', 'Exame de imagem que utiliza campos magnéticos e ondas de rádio para criar imagens detalhadas dos órgãos e tecidos do corpo.'),
('Tomografia Computadorizada (TC)', 'Exame de imagem que utiliza raios-X para criar imagens transversais do corpo, auxiliando no diagnóstico de diversas condições médicas.'),
('Teste de Glicemia', 'Exame que mede os níveis de glicose no sangue para diagnosticar e monitorar o diabetes.'),
('Exame de Urina', 'Exame que analisa a composição da urina para detectar infecções, doenças renais e outras condições médicas.');


-- Tabela de exames para o hospital, para armazenar as informações dos exames realizados pelos médicos, incluindo a data do exame, o tipo de exame e o resultado. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `exame` (
	`id` INT AUTO_INCREMENT,
	`id_consulta` INT,
	`id_tipo_exame` INT NOT NULL,
	`data_exame` DATETIME NOT NULL,
    `resultado` TEXT NOT NULL DEFAULT 'Exames Negativos',
	PRIMARY KEY(`id`),
    FOREIGN KEY(`id_consulta`) REFERENCES `consulta`(`id`),
    FOREIGN KEY(`id_tipo_exame`) REFERENCES `tipo_exame`(`id`)
)CHAR SET utf8;

INSERT INTO exame
(`id_consulta`, `id_tipo_exame`, `data_exame`, `resultado`)
VALUES 
(1, 1, '2026-03-05 11:00:00', 'Resultados normais'),
(2, 2, '2026-03-05 12:00:00', 'Sinais de infecção pulmonar');


-- Tabela de diagnósticos para o hospital, para armazenar as informações dos diagnósticos realizados pelos médicos, incluindo a descrição do diagnóstico, as observações e a data do diagnóstico. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `diagnostico` (
	`id` INT AUTO_INCREMENT,
	`id_consulta` INT,
	`descricao` TEXT,
    `observacao` TEXT,
    `data_diagnostico` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`id_consulta`) REFERENCES `consulta`(`id`)
)CHAR SET utf8;

INSERT INTO diagnostico
(id_consulta, descricao, observacao, data_diagnostico)
VALUES
(1, 'Gripe', 'Caso leve', NOW()),
(2, 'Infecção', 'Precisa antibiótico', NOW());


-- Tabela de receitas para o hospital, para armazenar as informações das receitas prescritas pelos médicos, incluindo os remédios, a dosagem, a frequência e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `receita` (
	`id` INT AUTO_INCREMENT,
	`id_diagnostico` INT,
	`id_medico` INT,
	`data_receita` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`obsercacao` TEXT NOT NULL,
	`remedios` TEXT NOT NULL,
	`dosagem` TEXT NOT NULL,
	`frequencia` TEXT NOT NULL,
	PRIMARY KEY(`id`),
	FOREIGN KEY(`id_diagnostico`) REFERENCES `diagnostico`(`id`),
    FOREIGN KEY(`id_medico`) REFERENCES `medico`(`id`)
)CHAR SET utf8;

INSERT INTO receita
(id_diagnostico, id_medico, data_receita, obsercacao, remedios, dosagem, frequencia)
VALUES
(1, 1, NOW(), 'Tomar por 5 dias', 'Paracetamol', '500mg', '8/8h'),
(2, 2, NOW(), 'Tomar por 7 dias', 'Amoxicilina', '500mg', '12/12h');


-- Tabela de prontuários para o hospital, para armazenar as informações dos prontuários dos pacientes, incluindo os sintomas, o diagnóstico, o tratamento e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `prontuarios`(
	`id` INT AUTO_INCREMENT,
    `id_consulta` INT UNIQUE,
    `sintomas` TEXT,
    `diagnostico` TEXT,
    `tratamento` TEXT,
    `observacoes` TEXT,
    `data_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_consulta`) REFERENCES `consulta`(`id`)
)CHAR SET utf8;

INSERT INTO prontuarios
(id_consulta, sintomas, diagnostico, tratamento, observacoes)
VALUES
(1, 'Febre e tosse', 'Gripe', 'Antitérmico', 'Retorno em 3 dias'),
(2, 'Dor abdominal', 'Infecção', 'Antibiótico', 'Monitorar');


-- Tabela de quartos para o hospital, para armazenar as informações dos quartos disponíveis, incluindo a especialidade associada, o número de leitos e o piso. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `quarto` (
	`id` INT AUTO_INCREMENT,
	`id_especialidade` INT, 
    `leitos` INT NOT NULL,
    `piso` INT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_especialidade`) REFERENCES `especialidade`(`id`)
)CHAR SET utf8;

INSERT INTO quarto
(`id_especialidade`, `piso`, `leitos`)
VALUES
(1, 1, 4),
(3, 2, 5),
(4, 3, 6),
(20, 4, 4);


-- Tabela de internamentos para o hospital, para armazenar as informações dos internamentos dos pacientes, incluindo a consulta associada, o quarto, as datas de entrada e saída, o tipo de alta e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `internamento` (
	`id` INT AUTO_INCREMENT,
	`i_dconsulta` INT NOT NULL,
    `id_quarto` INT NOT NULL,
    `data_entrada` DATE NOT NULL,
    `data_saida` DATE NOT NULL,
	`tipo_alta` ENUM('Alta medica', 'Transferencia', 'Obito', 'Abandono') DEFAULT 'Alta medica',
    `observacao` TEXT,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`i_dconsulta`) REFERENCES `consulta`(`id`),
    FOREIGN KEY(`id_quarto`) REFERENCES `quarto`(`id`)
)CHAR SET utf8;

INSERT INTO internamento
(i_dconsulta, id_quarto, data_entrada, data_saida, tipo_alta)
VALUES
(1, 1, '2026-03-05', '2026-03-08', 'Alta medica'),
(2, 2, '2026-03-06', '2026-03-09', 'Transferencia');