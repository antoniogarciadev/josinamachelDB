DROP DATABASE IF EXISTS `josinamachel`;

CREATE DATABASE `josinamachel`
DEFAULT COLLATE utf8_general_ci;

USE `josinamachel`;

-- Especialidades médicas para os médicos, para facilitar a organização e a identificação dos profissionais de saúde de acordo com suas áreas de atuação. Isso é importante para direcionar os pacientes ao especialista adequado e para a gestão interna do hospital.
CREATE TABLE `specialty` (
    `id` INT AUTO_INCREMENT, -- Identificador único da especialidade
    `name` VARCHAR(100) NOT NULL UNIQUE, -- Nome da especialidade
    `descricao` TEXT DEFAULT 'Para pesquisar', -- Descrição da especialidade
    PRIMARY KEY(`id`)
) CHAR SET utf8;

INSERT INTO `specialty` (`name`, `descricao`)
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
    `id` INT AUTO_INCREMENT, -- Identificador único do tipo sanguíneo
    `name` VARCHAR(3) NOT NULL, -- Código do tipo sanguíneo (ex.: A+, O-)
    PRIMARY KEY(`id`)
)CHAR SET utf8;

INSERT INTO `blood_type` (`name`) 
VALUES ('A+'), ('A-'), ('B+'), ('B-'), ('AB+'), ('AB-'), ('O+'), ('O-');


-- Tabela de usuários para o sistema, para armazenar as informações dos diferentes tipos de usuários (administradores, médicos, funcionários e pacientes) e facilitar a autenticação e a gestão de acesso ao sistema.

CREATE TABLE `users` (
    `uid` INT AUTO_INCREMENT, -- Identificador único do usuário
    `name` VARCHAR(100) NOT NULL, -- Nome do Usuário
    `surname` VARCHAR(100) NOT NULL, -- surname do Usuário
    `email` VARCHAR(100) NOT NULL UNIQUE, -- Email do Usuário usado para login
    `phone` VARCHAR(20) NOT NULL, -- Número de phone para contato
    `brith_date` DATE NOT NULL, -- Data de nascimento
    `gender` ENUM('m', 'f') NOT NULL, -- Gênero do usuário (m = masculino ou f = femenino)
    `address` TEXT NOT NULL DEFAULT '', -- Endereço residencial
    `password` VARCHAR(255) NOT NULL, -- Senha criptografada
    `profile` ENUM('admin', 'doctor', 'employee', 'patient') NOT NULL DEFAULT 'patient',
    -- Perfil de acesso do usuário
    `create_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    -- Data de criação/última modificação
    PRIMARY KEY(`uid`)
)CHAR SET utf8;

INSERT INTO users ( `name`, `surname`, `email`, `phone`, `brith_date`, `gender`, `address`, `password`, `profile`)
VALUES 	
('João', 'Silva', 'joao.silva@gmail.com', '+244928740538', '1995-06-15', 'm', DEFAULT, '$2y$10$mJhLcXLi/SgKjiHsMj79buyPz5r6Gcy9odoN6BSF84GCzBI1luzT6', 'employee'),
('Maria', 'Santos', 'maria.santos@gmail.com', '+244928740539', '1980-06-22', 'f', DEFAULT, '$2y$10$ei2yCiodjuoq35XYbT6h6er1TOP0mRTTZ2tJn6z0ow0CPlShBM1i.', 'employee'),
('Carlos', 'Pereira', 'carlos.pereira@gmail.com', '+244928740540', '1990-01-05', 'm', DEFAULT, '$2y$10$HdUjbmyl3Vo4W0CeVn4cxOMmZL4lkrEKRJyvMGd7CgUk0MoaA5Itm', 'doctor'),
('Ana', 'Oliveira', 'ana.oliveira@gmail.com', '+244928740541', '1985-12-30', 'f', DEFAULT, '$2y$10$es4hXiaoNs8BSLGBxzf5reD6q9yAtr3OcZ7n.jOsQIlWlkZRguNea', 'doctor'),
('Pedro', 'Costa', 'pedro.costa@gmail.com', '+244928740542', '1989-07-15', 'm', 'Luanda-Angola', '$2y$10$THy2.PnsEJF1ov/XYzIFG.yK61eLcAt78v37ci4BtrOvh5iA6bYsa', 'patient'),
('Sofia', 'Rodrigues', 'sofia.rodrigues@gmail.com', '+244928740543', '2000-08-28', 'f', 'Gamek-Luanda', '$2y$10$clOyZpo5Km5nZQkLYsvbNu2T5o8G2Pm3NolurJ2DM3Tytdpd/Vmrq', 'patient'),
('Miguel', 'Ferreira', 'miguel.ferreira@gmail.com', '+244928740544', '2001-09-14', 'm', 'Luanda-Angola', '$2y$10$oaw0.sXGX1Qi2grUrT1zN.Ksie75NqjD3rFaVtm7qgFH3sbhpLGjK', 'patient'),
('Beatriz', 'Almeida', 'beatriz.almeida@gmail.com', '+244928740545', '1997-04-26', 'f', 'Gamek-Luanda', '$2y$10$YXlvbhaoQwe2WPwIJvtJFudsv/7rxK0CJgb88XzuYAwn8msN6aow.', 'patient'),
('António', 'Garcia', 'antonio.garcia@gmail.com', '+244928740538', '2006-06-15', 'm', DEFAULT, '$2y$10$OtIVTQA1bNVHZ.wcrhkM8O/Bx6skQNWYeCcX/o76Sz3wBSN4wEYca', 'admin'), 
('David', 'Maia', 'devmaia@gmail.com', '+244928740538', '2006-06-15', 'f', DEFAULT, '$2y$10$NQem3qD7nQv6Xh/c3zBQteX594SkCHjZi76u2Z65mjnXYbtYXyWLu', 'admin'); 		



-- Tabela de funcionários para o hospital, para armazenar as informações dos funcionários, incluindo o cargo e a associação com o usuário correspondente na tabela de usuários. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `funcionario` (
    `id` INT AUTO_INCREMENT, -- Identificador único do funcionário
    `uid` INT UNIQUE, -- Referência ao usuário associado
    `cargo` VARCHAR(100) NOT NULL DEFAULT '', -- Cargo ou função exercida
    PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `users`(`uid`)
)CHAR SET utf8;

INSERT INTO `funcionario` (`uid`, `cargo`)
VALUES 	( 1, 'recepcionista'),
		( 2, 'emfermeiro');
  
-- Tabela de médicos para o hospital, para armazenar as informações dos médicos, incluindo a especialidade e a associação com o usuário correspondente na tabela de usuários. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `medico` (
    `id` INT AUTO_INCREMENT, -- Identificador único do médico
    `uid` INT UNIQUE, -- Referência ao usuário correspondente
    `id_specialty` INT, -- Especialidade médica (fk de especialidade)
    PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `users`(`uid`),
    FOREIGN KEY(`id_specialty`) REFERENCES `specialty`(`id`)
)CHAR SET utf8;

INSERT INTO `medico` (`uid`, `id_specialty`)
VALUES 	(3, 1),
		(4, 4);      
	

-- Tabela de pacientes para o hospital, para armazenar as informações dos pacientes, incluindo o tipo sanguíneo, alergias e a associação com o usuário correspondente na tabela de usuários. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `patient` (
    `id` INT AUTO_INCREMENT, -- Identificador único do paciente
    `uid` INT NULL UNIQUE , -- Referência ao usuário (pode ser nulo)
    `id_blood_type` INT, -- Tipo sanguíneo (fk de blood_type)
    `full_name` VARCHAR(100) NOT NULL, -- Nome completo do paciente
    `phone` VARCHAR(20) NOT NULL, -- phone de contato
    `gender` ENUM('m', 'f') NOT NULL, -- Gênero do paciente
    `bi_passaporte` VARCHAR(14) NOT NULL UNIQUE, -- BI ou passaporte
    `brith_date` DATE NOT NULL, -- Data de nascimento
    `alergias` TEXT NULL DEFAULT 'Nenhuma', -- Alergias conhecidas
    `address` TEXT NOT NULL DEFAULT '', -- Endereço residencial
    PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `users`(`uid`) ON DELETE SET NULL,
    FOREIGN KEY(`id_blood_type`) REFERENCES `blood_type`(`id`)
)CHAR SET utf8;

INSERT INTO patient 
(`uid`, `id_blood_type`, `full_name`, `phone`, `gender`, `bi_passaporte`, `brith_date`, `alergias`, `address`)
VALUES
(1, 2, 'Anselmo Vidal', '+244900000001', 'm', 'bi00001', '2000-02-10', DEFAULT, 'Luanda'),
( 2, 8, 'Maria Silva', '+244900000002', 'f', 'bi00002', '1995-06-15', 'Penicilina', 'Benguela'),
(NULL, 4, 'Luís Gomes', '+244928740538', 'm', 'bi00003', '1980-07-30', DEFAULT, 'Luanda-Angola'),
(NULL, 4, 'Inês Martins', '+244928740538', 'f', 'bi00004', '1994-10-15', 'Poeira', 'Gamek-Luanda'),
(NULL, 4, 'Rui Lopes', '+244928740538', 'm', 'bi00005', '2000-04-06', 'Lactose', 'Luanda-Angola'),
(NULL, 4, 'Catarina Sousa', '+244928740538', 'f', 'bi00006', '1995-10-20', DEFAULT, 'Gamek-Luanda');


-- Tabela de triagem para o hospital, para armazenar as informações das triagens realizadas pelos funcionários, incluindo o peso, a temperatura e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `triagem` (
    `id` INT AUTO_INCREMENT, -- Identificador da triagem
    `id_funcionario` INT, -- Funcionário que realizou a triagem
    `id_patient` INT, -- Paciente triado
    `peso` DOUBLE NOT NULL, -- Peso em kg
    `temperatura` DOUBLE NOT NULL, -- Temperatura corporal em °C
    `observacoes` TEXT, -- Observações adicionais da triagem
    `data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora da triagem
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_funcionario`) REFERENCES `funcionario`(`id`),
    FOREIGN KEY(`id_patient`) REFERENCES `patient`(`id`)
)CHAR SET utf8;

INSERT INTO triagem
(`id_funcionario`, `id_patient`, `peso`, `temperatura`, `observacoes`, `data`)
VALUES (1, 1, 70.5, 36.5, 'Normal', NOW()),
	   (2, 2, 65.2, 37.8, 'Febre leve', NOW());

-- Tabela de consultas para o hospital, para armazenar as informações das consultas realizadas pelos médicos, incluindo a data, a hora marcada, o status e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `consulta` (
    `id` INT AUTO_INCREMENT, -- Identificador da consulta
    `id_triagem` INT NOT NULL, -- Triagem associada à consulta
    `id_medico` INT NOT NULL, -- Médico responsável pela consulta
    `data_consulta` DATE NOT NULL, -- Data agendada da consulta
    `hora_marcada` TIME NOT NULL, -- Hora marcada para a consulta
    `status` ENUM('marcada', 'em_andamento', 'finalizada', 'cancelada') NOT NULL DEFAULT 'marcada', -- Situação da consulta
    `observacoes` TEXT, -- Observações feitas pelo médico ou funcionário
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
    `id` INT AUTO_INCREMENT, -- Identificador do tipo de exame
    `name` VARCHAR(100) NOT NULL UNIQUE, -- Nome do tipo de exame
    `descricao` TEXT, -- Descrição detalhada do exame
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
    `id` INT AUTO_INCREMENT, -- Identificador único do exame
    `id_consulta` INT, -- Consulta que originou o exame
    `id_tipo_exame` INT NOT NULL, -- Tipo de exame realizado
    `data_exame` DATETIME NOT NULL, -- Data e hora em que o exame foi feito
    `resultado` TEXT NOT NULL DEFAULT 'Exames Negativos', -- Resultado do exame
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
    `id` INT AUTO_INCREMENT, -- Identificador único do diagnóstico
    `id_consulta` INT, -- Consulta relacionada ao diagnóstico
    `descricao` TEXT, -- Descrição do diagnóstico
    `observacao` TEXT, -- Observações do médico
    `data_diagnostico` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data em que o diagnóstico foi registrado
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
    `id` INT AUTO_INCREMENT, -- Identificador único da receita
    `id_diagnostico` INT, -- Diagnóstico que gerou a receita
    `id_medico` INT, -- Médico que emitiu a receita
    `data_receita` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data da emissão da receita
    `obsercacao` TEXT NOT NULL, -- Observações gerais (typo intencional conservado)
    `remedios` TEXT NOT NULL, -- Medicamentos prescritos
    `dosagem` TEXT NOT NULL, -- Dosagem indicada
    `frequencia` TEXT NOT NULL, -- Frequência de uso dos remédios
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
    `id` INT AUTO_INCREMENT, -- Identificador único do prontuário
    `id_consulta` INT UNIQUE, -- Consulta vinculada ao prontuário
    `sintomas` TEXT, -- Sintomas relatados pelo paciente
    `diagnostico` TEXT, -- Diagnóstico final registrado
    `tratamento` TEXT, -- Tratamento recomendado
    `observacoes` TEXT, -- Observações adicionais
    `data_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data de criação do prontuário
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_consulta`) REFERENCES `consulta`(`id`)
)CHAR SET utf8;

INSERT INTO prontuarios
(id_consulta, sintomas, diagnostico, tratamento, observacoes)
VALUES
(1, 'Febre e tosse', 'Gripe', 'Antitérmico', 'Retorno em 3 dias'),
(2, 'Dor abdominal', 'Infecção', 'Antibiótico', 'Monitorar');


-- Tabela de quartos para o hospital, para armazenar as informações dos quartos disponíveis, incluindo a especialidade associada, o número de leitos e o piso. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `room` (
    `id` INT AUTO_INCREMENT, -- Identificador único do quarto
    `id_specialty` INT, -- Especialidade à qual o quarto pertence
    `leitos` INT NOT NULL, -- Quantidade de leitos no quarto
    `piso` INT, -- Piso onde o quarto está localizado
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_specialty`) REFERENCES `specialty`(`id`)
)CHAR SET utf8;

INSERT INTO room
(`id_specialty`, `piso`, `leitos`)
VALUES
(1, 1, 4),
(3, 2, 5),
(4, 3, 6),
(20, 4, 4);


-- Tabela de internamentos para o hospital, para armazenar as informações dos internamentos dos pacientes, incluindo a consulta associada, o quarto, as datas de entrada e saída, o tipo de alta e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
CREATE TABLE `internamento` (
    `id` INT AUTO_INCREMENT, -- Identificador único do internamento
    `i_dconsulta` INT NOT NULL, -- Identificador da consulta que originou o internamento
    `id_room` INT NOT NULL, -- Quarto onde o paciente ficará
	`estado` TEXT NOT NULL, -- Estado do internamento
    `data_entrada` DATE NOT NULL, -- Data de entrada no internamento
    `data_alta` DATE NULL, -- Data de saída do internamento (Pode ser NULL se ativo)
    `tipo_alta` ENUM('Alta medica', 'Transferencia', 'Obito', 'Abandono') DEFAULT NULL, -- Tipo de alta
    `evolucao` TEXT, -- Histórico de evolução clínica
    `observacao` TEXT, -- Observações do internamento
    PRIMARY KEY(`id`),
    FOREIGN KEY(`i_dconsulta`) REFERENCES `consulta`(`id`),
    FOREIGN KEY(`id_room`) REFERENCES `room`(`id`)
)CHAR SET utf8;

INSERT INTO internamento
(i_dconsulta, id_room, estado, data_entrada, data_alta, tipo_alta, evolucao, observacao)
VALUES
(1, 1, 'Alta', '2026-03-05', '2026-03-08', 'Alta medica', 'Paciente apresentou melhoras progressivas nas primeiras 48h.', 'Sem observações'),
(2, 2, 'Alta', '2026-03-06', '2026-03-09', 'Transferencia', 'Estabilizado para transferência.', 'Transferido para Hospital Geral');


SELECT 
    p.full_name AS patient,
    CONCAT(u.name,' ',u.surname) AS medico,
    c.data_consulta
FROM consulta c
JOIN triagem t ON t.id = c.id_triagem
JOIN patient p ON p.id = t.id_patient
JOIN medico m ON m.id = c.id_medico
JOIN users u ON u.uid = m.uid;