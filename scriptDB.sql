DROP DATABASE IF EXISTS `josinamachel`;
CREATE DATABASE `josinamachel`
DEFAULT COLLATE utf8_general_ci;

USE `josinamachel`;

-- Especialidades médicas para os médicos, para facilitar a organização e a identificação dos profissionais de saúde de acordo com suas áreas de atuação. Isso é importante para direcionar os pacientes ao especialista adequado e para a gestão interna do hospital.
DROP TABLE IF EXISTS `specialty`;
CREATE TABLE `specialty` (
    `id` INT AUTO_INCREMENT, -- Identificador único da especialidade
    `name` VARCHAR(100) NOT NULL UNIQUE, -- Nome da especialidade
    `descricao` TEXT DEFAULT 'Para pesquisar', -- Descrição da especialidade
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
DROP TABLE IF EXISTS `blood_type`;
CREATE TABLE `blood_type` (
    `id` INT AUTO_INCREMENT, -- Identificador único do tipo sanguíneo
    `name` VARCHAR(3) NOT NULL, -- Código do tipo sanguíneo (ex.: A+, O-)
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `blood_type` (`name`) 
VALUES ('A+'), ('A-'), ('B+'), ('B-'), ('AB+'), ('AB-'), ('O+'), ('O-');


-- Tabela de usuários para o sistema, para armazenar as informações dos diferentes tipos de usuários (administradores, médicos, funcionários e pacientes) e facilitar a autenticação e a gestão de acesso ao sistema.
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `uid` INT AUTO_INCREMENT, -- Identificador único do usuário
    `name` VARCHAR(100) NOT NULL, -- Nome do Usuário
    `surname` VARCHAR(100) NOT NULL, -- surname do Usuário
    `bi_passport` VARCHAR(14) NOT NULL UNIQUE, -- BI ou passaporte
    `email` VARCHAR(100) NOT NULL UNIQUE, -- Email do Usuário usado para login
    `phone` VARCHAR(20) NOT NULL, -- Número de phone para contato
    `birth_date` DATE NOT NULL, -- Data de nascimento
    `gender` ENUM('m', 'f') NOT NULL, -- Gênero do usuário (m = masculino ou f = femenino)
    `has_disability` TINYINT(1) NOT NULL DEFAULT 0, -- Deficiência 0 = Não é / 1 = é deficiente
    `disability_type` VARCHAR(100) NOT NULL DEFAULT 'Nenhuma',
    `nacionality` TEXT NOT NULL DEFAULT 'Angolana', -- Nacionalidade do paciente
    `address` TEXT NOT NULL DEFAULT 'Desconhecido', -- Endereço residencial
    `provincia` TEXT NOT NULL DEFAULT 'Luanda', -- Endereço residencial
    `password` VARCHAR(255) NOT NULL, -- Senha criptografada
    `profile` ENUM('admin', 'doctor', 'employee', 'patient') NOT NULL DEFAULT 'patient', -- Perfil de acesso do usuário
    `status` ENUM('ativo','bloqueado','inativo') NOT NULL DEFAULT 'ativo',
    `data_desligamento` DATE NULL,
    `create_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data de criação/última modificação
    `reset_token` VARCHAR(255) DEFAULT NULL, -- Data de criação/última modificação
    `token_expira` VARCHAR(255) DEFAULT NULL, -- Data de criação/última modificação
    PRIMARY KEY(`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` ( `name`, `surname`, `bi_passport`, `email`, `phone`, `birth_date`, `gender`, `address`, `password`, `profile`)
VALUES
('António', 'Garcia', '000000000LA000', 'antonio.garcia@gmail.com', '+244928740538', '2006-06-15', 'm', DEFAULT, '$2y$10$OtIVTQA1bNVHZ.wcrhkM8O/Bx6skQNWYeCcX/o76Sz3wBSN4wEYca', 'admin'), 
('Feliciana', 'David', '000000000LA001', 'feliciana.david@gmail.com', '+244928740538', '2006-06-15', 'f', DEFAULT, '$2y$10$NQem3qD7nQv6Xh/c3zBQteX594SkCHjZi76u2Z65mjnXYbtYXyWLu', 'admin'), 		
('João', 'Silva', '000000000LA002', 'joao.silva@gmail.com', '+244928740538', '1995-06-15', 'm', DEFAULT, '$2y$10$mJhLcXLi/SgKjiHsMj79buyPz5r6Gcy9odoN6BSF84GCzBI1luzT6', 'employee'),
('Maria', 'Santos', '000000000LA003', 'maria.santos@gmail.com', '+244928740539', '1980-06-22', 'f', DEFAULT, '$2y$10$ei2yCiodjuoq35XYbT6h6er1TOP0mRTTZ2tJn6z0ow0CPlShBM1i.', 'employee'),
('Deusa', 'Piris', '000000000LA004', 'deusa.piris@gmail.com', '+244928740539', '1980-06-22', 'f', DEFAULT, '$2y$10$/m/Ku0M3xvfCbzr8.i45M.2SjUHx5ocqNMVwCEYEOYuNjNYfROvwi', 'employee'),
('Carlos', 'Pereira', '000000000LA005', 'carlos.pereira@gmail.com', '+244928740540', '1990-01-05', 'm', DEFAULT, '$2y$10$HdUjbmyl3Vo4W0CeVn4cxOMmZL4lkrEKRJyvMGd7CgUk0MoaA5Itm', 'doctor'),
('Ana', 'Oliveira', '000000000LA006', 'ana.oliveira@gmail.com', '+244928740541', '1985-12-30', 'f', DEFAULT, '$2y$10$es4hXiaoNs8BSLGBxzf5reD6q9yAtr3OcZ7n.jOsQIlWlkZRguNea', 'doctor'),
('David', 'Maia', '000000000LA007', 'david.maia@gmail.com', '+244928740541', '1985-12-30', 'm', DEFAULT, '$2y$10$6cIaf4xKPbL5LPNhdYYOaO7t7kM4oVkNHE7LAr/KScBn3WlFBOr1O', 'doctor'),
('Frederico', 'Pimenta', '000000000LA008', 'frederico.pimenta@gmail.com', '+244928740541', '1985-12-30', 'm', DEFAULT, '$2y$10$KbzeKzvNAIHpiYygREyNfeWS2..wzw.iNTmniFOJ3AqFQK3j6mZuO', 'doctor'),
('Pedro', 'Costa', '000000000LA009', 'pedro.costa@gmail.com', '+244928740542', '1989-07-15', 'm', 'Luanda-Angola', '$2y$10$THy2.PnsEJF1ov/XYzIFG.yK61eLcAt78v37ci4BtrOvh5iA6bYsa', 'patient'),
('Sofia', 'Rodrigues', '000000000LA010', 'sofia.rodrigues@gmail.com', '+244928740543', '2000-08-28', 'f', 'Gamek-Luanda', '$2y$10$clOyZpo5Km5nZQkLYsvbNu2T5o8G2Pm3NolurJ2DM3Tytdpd/Vmrq', 'patient'),
('Miguel', 'Ferreira', '000000000LA011', 'miguel.ferreira@gmail.com', '+244928740544', '2001-09-14', 'm', 'Luanda-Angola', '$2y$10$oaw0.sXGX1Qi2grUrT1zN.Ksie75NqjD3rFaVtm7qgFH3sbhpLGjK', 'patient'),
('Beatriz', 'Almeida', '000000000LA012', 'beatriz.almeida@gmail.com', '+244928740545', '1997-04-26', 'f', 'Gamek-Luanda', '$2y$10$YXlvbhaoQwe2WPwIJvtJFudsv/7rxK0CJgb88XzuYAwn8msN6aow.', 'patient');

-- Tabela de funcionários para o hospital, para armazenar as informações dos funcionários, incluindo o cargo e a associação com o usuário correspondente na tabela de usuários. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
    `id` INT PRIMARY KEY,
    `cargo` VARCHAR(100) NOT NULL,
    FOREIGN KEY (`id`) REFERENCES `users`(`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `employee` (`id`, `cargo`)
VALUES 	( 3, 'recepcionista'),
		( 4, 'enfermeiro'),
		( 5, 'enfermeiro');
        
  
-- Tabela de médicos para o hospital, para armazenar as informações dos médicos, incluindo a especialidade e a associação com o usuário correspondente na tabela de usuários. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor` (
    `id` INT PRIMARY KEY, -- Referência ao usuário correspondente
    `id_specialty` INT, -- Especialidade médica (fk de especialidade)
    FOREIGN KEY(`id`) REFERENCES `users`(`uid`),
    FOREIGN KEY(`id_specialty`) REFERENCES `specialty`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `doctor` (`id`, `id_specialty`)
VALUES 	(6, 1),
		(7, 4),      
		(8, 5),      
		(9, 7);      
	

-- Tabela de pacientes para o hospital, para armazenar as informações dos pacientes, incluindo o tipo sanguíneo, alergias e a associação com o usuário correspondente na tabela de usuários. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient` (
    `id` INT AUTO_INCREMENT, -- Identificador único do paciente
    `uid` INT NULL UNIQUE NULL, -- Referência ao usuário (pode ser nulo)
    `id_blood_type` INT, -- Tipo sanguíneo (fk de blood_type)
    `full_name` VARCHAR(100) NOT NULL, -- Nome completo do paciente
    `bi_passport` VARCHAR(14) NOT NULL UNIQUE, -- BI ou passaporte
    `phone` VARCHAR(20) NOT NULL, -- phone de contato
    `gender` ENUM('m', 'f') NOT NULL, -- Gênero do paciente
    `status` ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    `birth_date` DATE NOT NULL, -- Data de nascimento
    `death_date` DATE NULL, -- Data de nascimento
    `alergias` TEXT NULL DEFAULT 'Nenhuma', -- Alergias conhecidas
    `has_disability` TINYINT(1) NOT NULL DEFAULT 0, -- Deficiência 0 = Não é / 1 = é deficiente
    `disability_type` VARCHAR(100) NOT NULL DEFAULT 'Nenhuma', -- Tipo de deficiência
    `nacionality` TEXT NOT NULL DEFAULT 'Angolana', -- Nacionalidade do paciente
    `provincia` TEXT NOT NULL DEFAULT 'Luanda', -- Endereço residencial
    `address` TEXT NOT NULL DEFAULT 'Desconhecido', -- Endereço residencial
    `register_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`uid`) REFERENCES `users`(`uid`) ON DELETE SET NULL,
    FOREIGN KEY(`id_blood_type`) REFERENCES `blood_type`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `patient` 
(`uid`, `id_blood_type`, `full_name`, `bi_passport`, `phone`, `gender`, `status`, `birth_date`, `alergias`, `address`, `provincia`)
VALUES
(10, 2, 'Pedro Costa', '000000000LA013', '+244900000001', 'm', DEFAULT, '2000-02-10', DEFAULT, 'Maianga', DEFAULT),
( 11, 8, 'Sofia Rodrigues', '000000000LA014', '+244900000002', 'f', DEFAULT, '1995-06-15', 'Penicilina', 'Catumbela', 'Benguela'),
(NULL, 8, 'Inês Martins', '000000000LA015', '+244928740538', 'f', DEFAULT, '1994-10-15', 'Poeira', 'Gamek', DEFAULT),
(NULL, 6, 'Rui Lopes', '000000000LA016', '+244928740538', 'm', DEFAULT, '2000-04-06', 'Lactose', 'Rangel', DEFAULT),
(NULL, 3, 'Catarina Sousa', '000000000LA017', '+244928740538', 'f', DEFAULT, '1995-10-20', DEFAULT, 'Catete', 'Icolo e Bengo'),
(12, 1, 'Miguel Ferreira', '000000000LA018', '+244928740538', 'm', DEFAULT, '1995-10-20', DEFAULT, DEFAULT, 'Bie');

-- Pacientes com deficiência 
INSERT INTO `patient` 
(`uid`, `id_blood_type`, `full_name`, `bi_passport`, `phone`, `gender`, `status`, `birth_date`, `alergias` , `has_disability`, `disability_type`, `address`, `provincia`)
VALUES
(NULL, 3, 'Serafim Costa', '000000000LA019', '+244900000001', 'm', DEFAULT, '2000-12-12', DEFAULT, 1, 'Visual', 'Caquaco', DEFAULT),
( NULL, 8, 'Lola Ramos', '000000000LA020', '+244900000002', 'f', DEFAULT, '1995-06-15', DEFAULT, 1, 'Física', 'Cidade de Malanje', 'Malanje');

-- Pacientes falecidos
INSERT INTO `patient` 
(`uid`, `id_blood_type`, `full_name`, `bi_passport`, `phone`, `gender`, `status`, `birth_date`, `death_date`,  `alergias`, `address`)
VALUES
(NULL, 4, 'Marcoa Ascensio', '000000000LA021', '+244928740538', 'm', 'inactive', '1980-07-30', '2021-03-20', DEFAULT, DEFAULT),
(NULL, 5, 'Luís Gomes', '000000000LA022', '+244928740538', 'm', 'inactive', '1980-07-30', '2024-07-13', DEFAULT, 'Viana');

-- Tabela de triagem para o hospital, para armazenar as informações das triagens realizadas pelos funcionários, incluindo o peso, a temperatura e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
-- 1. Recriação da tabela com as colunas de suporte à vida
DROP TABLE IF EXISTS `triagem`;
CREATE TABLE `triagem` (
    `id` INT AUTO_INCREMENT,
    `id_employee` INT, 
    `id_patient` INT, 
    `id_specialty` INT NOT NULL,
    `peso` DOUBLE NULL, 
    `pressao` VARCHAR(20) NULL, 
    `temperatura` DOUBLE NULL, 
    `freq_cardiaca` INT NULL,
    `clinical_risk` ENUM('Vermelho(Emergência)', 'Laranja(Muito Urgente)', 'Amarelo(Urgente)', 'Verde(Pouco Urgente)', 'Azul(Não Urgente)') NULL,
    `queixa_principal` TEXT NULL,
    `status` ENUM('pendente', 'em_espera', 'concluida') NOT NULL DEFAULT 'pendente',
    `data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_employee`) REFERENCES `employee`(`id`),
    FOREIGN KEY(`id_patient`) REFERENCES `patient`(`id`),
    FOREIGN KEY(`id_specialty`) REFERENCES `specialty`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 3. Inserts Atualizados (Incluindo a Especialidade)
INSERT INTO `triagem` 
(`id_employee`, `id_patient`, `id_specialty`, `peso`, `pressao`, `temperatura`, `freq_cardiaca`, `clinical_risk`, `queixa_principal`, `status`)
VALUES 
-- Crítico (Cardiologia)
(4, 4, 1, 75.0, '8/5', 35.5, 135, 'Vermelho(Emergência)', 'Paciente inconsciente, possível paragem cardiorrespiratória.', 'concluida'),
-- Muito Urgente (Medicina Geral)
(4, 2, 4, 65.2, '16/10', 38.8, 105, 'Laranja(Muito Urgente)', 'Dor torácica intensa e dificuldade respiratória.', 'concluida'),
-- Urgente (Pediatria)
(3, 5, 1, 82.0, '14/9', 39.0, 95, 'Amarelo(Urgente)', 'Febre alta e desidratação.', 'concluida'),
-- Pouco Urgente (Ortopedia)
(3, 1, 5, 70.0, '12/8', 36.6, 72, 'Verde(Pouco Urgente)', 'Entorse no tornozelo sem deformidade.', 'concluida'),
-- Não Urgente (Medicina Geral)
(3, 6, 4, 60.5, '11/7', 36.2, 80, 'Azul(Não Urgente)', 'Dores musculares leves há 3 dias.', 'concluida');

-- 4. Query de Listagem Inteligente (Por Risco e agora mostrando a Especialidade)
SELECT
    t.id,
    p.full_name,
    t.clinical_risk,
    t.queixa_principal,
    s.name AS especialidade,
    t.data
FROM triagem t
JOIN patient p
    ON p.id = t.id_patient
JOIN specialty s
    ON s.id = t.id_specialty
ORDER BY FIELD(
    t.clinical_risk,
    'Vermelho(Emergência)',
    'Laranja(Muito Urgente)',
    'Amarelo(Urgente)',
    'Verde(Pouco Urgente)',
    'Azul(Não Urgente)'
),
t.data ASC;

DROP TABLE IF EXISTS `emergency`;
CREATE TABLE emergency (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_triagem INT NOT NULL,
    id_doctor INT NULL,
    id_employee INT NULL,
    entry_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    first_attendance DATETIME NULL,
    discharge_datetime DATETIME NULL,
    immediate_conduct TEXT NULL,
    observations TEXT NULL,
    priority_level ENUM('Vermelho(Emergência)', 'Laranja(Muito Urgente)', 'Amarelo(Urgente)', 'Verde(Pouco Urgente)', 'Azul(Não Urgente)') NULL,
    status ENUM(
        'aguardando_medico',
        'em_atendimento',
        'internado',
        'alta',
        'obito'
    ) DEFAULT 'aguardando_medico',
    destination ENUM(
        'Consulta',
        'Internamento',
        'Cirurgia',
        'Alta',
        'Transferência',
        'Óbito'
    ) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_emergency_triagem
    FOREIGN KEY(id_triagem) REFERENCES triagem(id) ON DELETE RESTRICT,
    CONSTRAINT fk_emergency_employee FOREIGN KEY(id_employee) REFERENCES employee(id) ON DELETE SET NULL,
    CONSTRAINT fk_emergency_doctor FOREIGN KEY(id_doctor) REFERENCES doctor(id) ON DELETE SET NULL
);
-- 3. Inserts Atualizados (Incluindo a Especialidade)
INSERT INTO emergency
(
    id_triagem,
    id_doctor,
    id_employee,
    priority_level,
    status,
    immediate_conduct
)
VALUES

(1,NULL,4, 'Vermelho(Emergência)','aguardando_medico',NULL),

(2,NULL,5, 'Laranja(Muito Urgente)','aguardando_medico',NULL),

(3,6, 5,'Amarelo(Urgente)','em_atendimento','Administração de oxigênio'),

(4,7, 4, 'Vermelho(Emergência)','internado','Internamento imediato'),

(5,8, 5, 'Azul(Não Urgente)','alta','Paciente estabilizado');

SELECT 
    p.full_name AS Paciente,
    t.clinical_risk AS Prioridade,
    e.status AS Situacao,
    ue.name AS Funcionario_Responsavel,
    e.immediate_conduct AS Conduta,
    u.name AS Medico_Responsavel
FROM emergency e
JOIN triagem t ON e.id_triagem = t.id
JOIN patient p ON t.id_patient = p.id
JOIN employee emp ON e.id_employee = emp.id
JOIN users ue ON emp.id = ue.uid
LEFT JOIN users u ON e.id_doctor = u.uid
ORDER BY FIELD(t.clinical_risk, 'Vermelho(Emergência)', 'Laranja(Muito Urgente)', 'Amarelo(Urgente)');
-- Tabela de consultas para o hospital, para armazenar as informações das consultas realizadas pelos médicos, incluindo a data, a hora marcada, o status e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.

DROP TABLE IF EXISTS emergency_procedure;

CREATE TABLE emergency_procedure (

    id INT AUTO_INCREMENT PRIMARY KEY,

    id_emergency INT NOT NULL,

    procedure_name VARCHAR(100) NOT NULL,

    description TEXT,

    performed_by INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,


    FOREIGN KEY(id_emergency)
    REFERENCES emergency(id),

    FOREIGN KEY(performed_by)
    REFERENCES employee(id)

);

INSERT INTO emergency_procedure
(
id_emergency,
procedure_name,
description,
performed_by
)
VALUES

(1,'Oxigênio',
'Administração de oxigênio por máscara',
4),

(1,'Reanimação',
'Manobras de suporte básico de vida',
4);

DROP TABLE IF EXISTS emergency_medication;


CREATE TABLE emergency_medication(

id INT AUTO_INCREMENT PRIMARY KEY,

id_emergency INT NOT NULL,

medication VARCHAR(100),

dose VARCHAR(50),

administration_time DATETIME,

id_employee INT,


FOREIGN KEY(id_emergency)
REFERENCES emergency(id),

FOREIGN KEY(id_employee)
REFERENCES employee(id)

);

INSERT INTO emergency_medication
(
id_emergency,
medication,
dose,
administration_time,
id_employee
)

VALUES

(1,
'Adrenalina',
'1mg',
NOW(),
4);

DROP TABLE IF EXISTS `consulta`;
CREATE TABLE `consulta` (
    `id` INT AUTO_INCREMENT, -- Identificador da consulta
    `id_triagem` INT NOT NULL, -- Triagem associada à consulta
    `id_specialty` INT NOT NULL, -- Especalidade da consulta
    `id_doctor` INT NULL, -- Médico responsável pela consulta
    `data_consulta` DATE NOT NULL, -- Data agendada da consulta
    `hora_marcada` TIME NOT NULL, -- Hora marcada para a consulta
    `origin` ENUM('Agendada', 'Emergência') NOT NULL DEFAULT 'Agendada',
    `status` ENUM(
        'pendente',
        'confirmada',
        'em_andamento',
        'finalizada',
        'cancelada',
        'nao_compareceu') NOT NULL DEFAULT 'pendente', -- Situação da consulta
    `observacoes` TEXT DEFAULT '', -- Observações feitas pelo médico ou funcionário
    `lembrete_enviado` INT(11) DEFAULT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_triagem`) REFERENCES `triagem`(`id`),
    FOREIGN KEY(`id_specialty`) REFERENCES `specialty`(`id`),
    FOREIGN KEY(`id_doctor`) REFERENCES `doctor`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `consulta`
(`id_triagem`, `id_specialty`, `id_doctor`, `data_consulta`, `hora_marcada`, `status`, `observacoes`)
VALUES
(1, 1, 6, '2026-03-05', '09:00:00', 'finalizada', 'Primeira consulta'),
(2, 4, 7, '2026-03-05', '10:00:00', 'finalizada', 'Paciente medicado'),
(3, 1, 6, '2026-07-05', '12:00:00', 'confirmada', DEFAULT);


-- Tabela de tipos de exames para o hospital, para armazenar as informações dos diferentes tipos de exames disponíveis, incluindo a descrição. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde, além de fornecer informações claras aos pacientes sobre os exames realizados.
DROP TABLE IF EXISTS `tipo_exame`;
CREATE TABLE tipo_exame (
    `id` INT AUTO_INCREMENT, -- Identificador do tipo de exame
    `name` VARCHAR(100) NOT NULL UNIQUE, -- Nome do tipo de exame
    `descricao` TEXT, -- Descrição detalhada do exame
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tipo_exame`
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
DROP TABLE IF EXISTS `exame`;
CREATE TABLE `exame` (
    `id` INT AUTO_INCREMENT, -- Identificador único do exame
    `id_consulta` INT, -- Consulta que originou o exame
    `id_tipo_exame` INT NOT NULL, -- Tipo de exame realizado
    `data_exame` DATETIME NOT NULL, -- Data e hora em que o exame foi feito
    `resultado` TEXT NOT NULL DEFAULT 'Exames Negativos', -- Resultado do exame
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_consulta`) REFERENCES `consulta`(`id`),
    FOREIGN KEY(`id_tipo_exame`) REFERENCES `tipo_exame`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO exame
(`id_consulta`, `id_tipo_exame`, `data_exame`, `resultado`)
VALUES 
(1, 1, '2026-03-05 11:00:00', 'Resultados normais'),
(2, 2, '2026-03-05 12:00:00', 'Sinais de infecção pulmonar');


-- Tabela de receitas para o hospital, para armazenar as informações das receitas prescritas pelos médicos, incluindo	 os remédios, a dosagem, a frequência e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
DROP TABLE IF EXISTS `receita`;
CREATE TABLE `receita` (
    `id` INT AUTO_INCREMENT, -- Identificador único da receita
    `id_consulta` INT, -- Médico que emitiu a receita
    `data_receita` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data da emissão da receita
    `observacao` TEXT NOT NULL, -- Observações gerais (typo intencional conservado)
    `remedios` TEXT NOT NULL, -- Medicamentos prescritos
    `dosagem` TEXT NOT NULL, -- Dosagem indicada
    `frequencia` TEXT NOT NULL, -- Frequência de uso dos remédios
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_consulta`) REFERENCES `consulta`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `receita`
(`id_consulta`, `data_receita`, `observacao`, `remedios`, `dosagem`, `frequencia`)
VALUES
( 1, NOW(), 'Tomar por 5 dias', 'Paracetamol', '500mg', '8/8h'),
( 2, NOW(), 'Tomar por 7 dias', 'Amoxicilina', '500mg', '12/12h'),
( 3, NOW(), 'Tomar por 15 dias', 'Paracetamol, metro', '500mg', '8/8h');


-- Tabela de prontuários para o hospital, para armazenar as informações dos prontuários dos pacientes, incluindo os sintomas, o diagnóstico, o tratamento e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
DROP TABLE IF EXISTS `prontuarios`;
CREATE TABLE `prontuarios`(
    `id` INT AUTO_INCREMENT, -- Identificador único do prontuário
    `id_consulta` INT UNIQUE, -- Consulta vinculada ao prontuário
    `sintomas` TEXT, -- Sintomas relatados pelo paciente
    `diagnostico` LONGBLOB, -- Diagnóstico final registrado
    `tratamento` TEXT, -- Tratamento recomendado
    `observacoes` TEXT, -- Observações adicionais
    `data_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data de criação do prontuário
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_consulta`) REFERENCES `consulta`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `prontuarios`
(`id_consulta`, `sintomas`, `diagnostico`, `tratamento`, `observacoes`)
VALUES
(1, 'Febre e tosse', '9Ch8JhUMgdkUB79g4vsDttLJ2Wn09Oraxa4KlW215CTPi1tqVByPIb4SVWsa', 'Antitérmico', 'Retorno em 3 dias'),
(2, 'Dor abdominal', 'xYFSzLVSlMhnqDCMQNr99tRM4vvdIvzftqVO7wKFCV2t7mKZJPq0Z7wI7AnOVG8hesYpB6CqJVzgjTW0', 'Antibiótico', 'Monitorar');


-- Tabela de quartos para o hospital, para armazenar as informações dos quartos disponíveis, incluindo a especialidade associada, o número de leitos e o piso. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
    `id` INT AUTO_INCREMENT, -- Identificador único do quarto
    `id_specialty` INT, -- Especialidade à qual o quarto pertence
    `piso` INT, -- Piso onde o quarto está localizado
    `leitos` INT NOT NULL, -- Quantidade de leitos no quarto
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_specialty`) REFERENCES `specialty`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `room`
 (`id_specialty`, `piso`, `leitos`)
VALUES
(1, 1, 4),
(3, 2, 5),
(4, 3, 6),
(20, 4, 4);


-- Tabela de internamentos para o hospital, para armazenar as informações dos internamentos dos pacientes, incluindo a consulta associada, o quarto, as datas de entrada e saída, o tipo de alta e as observações. Isso facilita a gestão interna do hospital e a organização dos profissionais de saúde.
DROP TABLE IF EXISTS `hospitalization`;
CREATE TABLE `hospitalization` (
    `id` INT AUTO_INCREMENT, -- Identificador único do internamento
    `id_consulta` INT NOT NULL, -- Identificador da consulta que originou o internamento
    `id_room` INT NOT NULL, -- Quarto onde o paciente ficará
    `bed_number` VARCHAR(20) NULL,
	`clinical_state` ENUM('Estável', 'Estável Grave', 'Instável', 'Gravíssimo') NOT NULL, -- Estado do internamento
    `data_entrada` DATE NOT NULL, -- Data de entrada no internamento
    `data_alta` DATE NULL, -- Data de saída do internamento (Pode ser NULL se ativo)
    `tipo_alta` ENUM('Alta hospitalar', 'Alta não hospitalar') DEFAULT NULL, -- Tipo de alta
    `observacao` TEXT, -- Observações do internamento
    PRIMARY KEY(`id`),
    FOREIGN KEY(`id_consulta`) REFERENCES `consulta`(`id`),
    FOREIGN KEY(`id_room`) REFERENCES `room`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `hospitalization`
(`id_consulta`, `id_room`, `bed_number`, `clinical_state`, `data_entrada`, `data_alta`, `tipo_alta`, `observacao`)
VALUES
(1, 1, 'Leito 1', 'Estável', '2026-03-05', '2026-03-08', 'Alta hospitalar', 'Paciente apresentou melhoras progressivas nas primeiras 48h.'),
(2, 2, 'Leito 2', 'Instável', '2026-03-06', '2026-03-09', 'Alta não hospitalar', 'Transferido para Hospital Geral');

SELECT p.full_name AS patient, CONCAT(u.name,' ',u.surname) AS doctor, c.data_consulta
FROM consulta c
JOIN triagem t ON t.id = c.id_triagem
JOIN patient p ON p.id = t.id_patient
JOIN doctor m ON m.id = c.id_doctor
JOIN users u ON u.uid = m.id;

SELECT p.full_name AS patient, CONCAT(u.name,' ',u.surname) AS doctor, c.data_consulta
FROM hospitalization h
JOIN room r ON r.id = h.id_room
JOIN specialty s ON s.id = r.id_specialty
JOIN consulta c ON c.id = h.id_consulta
JOIN triagem t ON t.id = c.id_triagem
JOIN patient p ON p.id = t.id_patient
JOIN doctor m ON m.id = c.id_doctor
JOIN users u ON u.uid = m.id;

	
SELECT p.full_name AS patient, CONCAT(u.name,' ',u.surname) AS doctor, c.data_consulta
FROM consulta c
JOIN triagem t ON t.id = c.id_triagem JOIN patient p ON p.id = t.id_patient JOIN doctor m ON m.id = c.id_doctor JOIN users u ON u.uid = m.id;


-- ======================================================
-- CONSULTAS PENDENTES PARA TESTE DO SISTEMA
-- Triagem pendente + Consulta pendente sem médico
-- ======================================================


-- Paciente Pedro Costa (patient.id = 1, uid = 10)
-- Especialidade Cardiologia (id = 5)

INSERT INTO triagem
(
    id_employee,
    id_patient,
    id_specialty,
    peso,
    pressao,
    temperatura,
    freq_cardiaca,
    clinical_risk,
    queixa_principal,
    status
)
VALUES
(
    NULL,
    1,
    5,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'pendente'
);



-- Consulta pendente sem médico

INSERT INTO consulta
(
    id_triagem,
    id_specialty,
    id_doctor,
    data_consulta,
    hora_marcada,
    status,
    observacoes
)
VALUES
(
    LAST_INSERT_ID(),
    5,
    NULL,
    '2026-07-15',
    '09:00:00',
    'pendente',
    'Aguardando associação de médico responsável'
);



------------------------------------------------------



-- Paciente Sofia Rodrigues (patient.id = 2, uid = 11)
-- Especialidade Medicina Interna (id = 17)

INSERT INTO triagem
(
    id_employee,
    id_patient,
    id_specialty,
    peso,
    pressao,
    temperatura,
    freq_cardiaca,
    clinical_risk,
    queixa_principal,
    status
)
VALUES
(
    NULL,
    2,
    17,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'pendente'
);



INSERT INTO consulta
(
    id_triagem,
    id_specialty,
    id_doctor,
    data_consulta,
    hora_marcada,
    status,
    observacoes
)
VALUES
(
    LAST_INSERT_ID(),
    17,
    NULL,
    '2026-07-16',
    '10:30:00',
    'pendente',
    'Paciente aguardando triagem e definição médica'
);



------------------------------------------------------


-- Mais duas consultas para os mesmos pacientes


-- Pedro - Ortopedia
INSERT INTO triagem
(
    id_patient,
    id_specialty,
    status
)
VALUES
(
    1,
    20,
    'pendente'
);


INSERT INTO consulta
(
    id_triagem,
    id_specialty,
    id_doctor,
    data_consulta,
    hora_marcada,
    status,
    observacoes
)
VALUES
(
    LAST_INSERT_ID(),
    20,
    NULL,
    '2026-07-18',
    '14:00:00',
    'pendente',
    'Consulta criada pelo paciente online'
);



-- Sofia - Pediatria (exemplo)
INSERT INTO triagem
(
    id_patient,
    id_specialty,
    status
)
VALUES
(
    2,
    21,
    'pendente'
);


INSERT INTO consulta
(
    id_triagem,
    id_specialty,
    id_doctor,
    data_consulta,
    hora_marcada,
    status,
    observacoes
)
VALUES
(
    LAST_INSERT_ID(),
    21,
    NULL,
    '2026-07-20',
    '08:30:00',
    'pendente',
    'Consulta online aguardando confirmação'
);


-- ======================================================
-- CONSULTAS CANCELADAS COM TRIAGEM CONCLUÍDA
-- ======================================================


-- ======================================================
-- 1) PACIENTE SEM UID
-- Paciente: Inês Martins (patient.id = 3)
-- ======================================================


INSERT INTO triagem
(
    id_employee,
    id_patient,
    id_specialty,
    peso,
    pressao,
    temperatura,
    freq_cardiaca,
    clinical_risk,
    queixa_principal,
    status
)
VALUES
(
    4,
    3,
    17,
    62.5,
    '12/8',
    36.5,
    78,
    'Verde(Pouco Urgente)',
    'Dor de cabeça frequente e tonturas.',
    'concluida'
);



INSERT INTO consulta
(
    id_triagem,
    id_specialty,
    id_doctor,
    data_consulta,
    hora_marcada,
    status,
    observacoes
)
VALUES
(
    LAST_INSERT_ID(),
    17,
    NULL,
    '2026-07-12',
    '11:00:00',
    'cancelada',
    'Consulta cancelada pelo paciente após realização da triagem'
);



-- ======================================================
-- 2) PACIENTE COM UID
-- Paciente: Miguel Ferreira
-- uid = 12
-- patient.id = 6
-- ======================================================


INSERT INTO triagem
(
    id_employee,
    id_patient,
    id_specialty,
    peso,
    pressao,
    temperatura,
    freq_cardiaca,
    clinical_risk,
    queixa_principal,
    status
)
VALUES
(
    5,
    6,
    5,
    80.0,
    '13/9',
    37.2,
    90,
    'Amarelo(Urgente)',
    'Dor no peito durante esforço físico.',
    'concluida'
);



INSERT INTO consulta
(
    id_triagem,
    id_specialty,
    id_doctor,
    data_consulta,
    hora_marcada,
    status,
    observacoes
)
VALUES
(
    LAST_INSERT_ID(),
    5,
    NULL,
    '2026-07-13',
    '15:30:00',
    'cancelada',
    'Consulta cancelada devido indisponibilidade do paciente'
);

SELECT 
    c.id,
    p.full_name AS paciente,
    p.uid,
    s.name AS especialidade,
    t.status AS triagem,
    c.status AS consulta,
    c.data_consulta
FROM consulta c

JOIN triagem t 
ON t.id = c.id_triagem

JOIN patient p
ON p.id = t.id_patient

JOIN specialty s
ON s.id = c.id_specialty

WHERE c.status='cancelada';