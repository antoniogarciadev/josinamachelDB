-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 08/03/2026 às 14:05
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `medsys`
--
CREATE DATABASE IF NOT EXISTS `medsys` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `medsys`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `blood_type`
--

CREATE TABLE `blood_type` (
  `id` int(11) NOT NULL,
  `name` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `blood_type`:
--

--
-- Despejando dados para a tabela `blood_type`
--

INSERT INTO `blood_type` (`id`, `name`) VALUES
(1, 'A+'),
(2, 'A-'),
(3, 'B+'),
(4, 'B-'),
(5, 'AB+'),
(6, 'AB-'),
(7, 'O+'),
(8, 'O-');

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulta`
--

CREATE TABLE `consulta` (
  `id` int(11) NOT NULL,
  `id_triagem` int(11) NOT NULL,
  `id_medico` int(11) NOT NULL,
  `data_consulta` date NOT NULL,
  `hora_marcada` time NOT NULL,
  `status` enum('marcada','em_andamento','finalizada','cancelada') NOT NULL DEFAULT 'marcada',
  `observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `consulta`:
--   `id_triagem`
--       `triagem` -> `id`
--   `id_medico`
--       `medico` -> `id`
--

--
-- Despejando dados para a tabela `consulta`
--

INSERT INTO `consulta` (`id`, `id_triagem`, `id_medico`, `data_consulta`, `hora_marcada`, `status`, `observacoes`) VALUES
(1, 1, 1, '2026-03-05', '09:00:00', 'marcada', 'Primeira consulta'),
(2, 2, 2, '2026-03-05', '10:00:00', 'finalizada', 'Paciente medicado');

-- --------------------------------------------------------

--
-- Estrutura para tabela `diagnostico`
--

CREATE TABLE `diagnostico` (
  `id` int(11) NOT NULL,
  `id_consulta` int(11) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `observacao` text DEFAULT NULL,
  `data_diagnostico` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `diagnostico`:
--   `id_consulta`
--       `consulta` -> `id`
--

--
-- Despejando dados para a tabela `diagnostico`
--

INSERT INTO `diagnostico` (`id`, `id_consulta`, `descricao`, `observacao`, `data_diagnostico`) VALUES
(1, 1, 'Gripe', 'Caso leve', '2026-03-08 13:02:21'),
(2, 2, 'Infecção', 'Precisa antibiótico', '2026-03-08 13:02:21');

-- --------------------------------------------------------

--
-- Estrutura para tabela `especialidade`
--

CREATE TABLE `especialidade` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `descricao` text DEFAULT 'Para pesquisar'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `especialidade`:
--

--
-- Despejando dados para a tabela `especialidade`
--

INSERT INTO `especialidade` (`id`, `name`, `descricao`) VALUES
(1, 'Acilo Facial', 'Para pesquisar'),
(2, 'Alergia e Imunologia', 'Alergia e Imunologia é a área especialisada que foca no diagnóstico e no tratamento de doenças alérgicas. Os profissionais trabalham com o sistema imune e com o diagnóstico e identificação das patologias e seus diferentes graus no organismo dos pacientes.'),
(3, 'Anestesiologia', 'Anestesiologia é a área especialisada que atuam no pré e no pós-operatório, trabalhando com a aplicação de medicamentos que mitiguem os efeitos da dor durante os procedimentos.'),
(4, 'Audiologia', 'Para pesquisar'),
(5, 'Cardiologia', 'Cardiologista é a área especialisada focado no diagnóstico precoce de doenças no coração, atuando na prevenção de doenças no sistema circulatório como um todo, na musculatura cardíaca e no próprio coração.'),
(6, 'Cirurgia Plástica', 'Cirurgia Plástica é a área especialisada que trabalha com alterações na aparência física dos pacientes em diferentes regiões do corpo, e atuam em procedimentos de reparação, reconstrução de trauma, patologias e na área estética.'),
(7, 'Cuidados Intensivos', 'Para pesquisar'),
(8, 'Dermatologia', 'Dermatologia é a área especialisada responsável por procedimentos clínicos e cirúrgicos nos tecidos do corpo como pele, cabelos e unhas. Essa área exige grande contato com pacientes e possui atuação em diferentes locais, incluindo hospitais, ambulatórios, consultórios e clínicas.'),
(9, 'Endocrinologia', 'Para pesquisar'),
(10, 'Estomatologia', 'Para pesquisar'),
(11, 'Farmácia', 'Para pesquisar'),
(12, 'Fisioterapia', 'Para pesquisar'),
(13, 'Gastroenterologia', 'Para pesquisar'),
(14, 'Hematologia', 'Para pesquisar'),
(15, 'Imagiologia', 'Para pesquisar'),
(16, 'Medicina Interna', 'Para pesquisar'),
(17, 'Nefrologia Hemodiálise', 'Para pesquisar'),
(18, 'Neurologia', 'Neurologia é a área especialisada que trabalha com as patologias e condições ligadas ao sistema nervoso, sendo essa uma das atuações mais delicadas e com maior exigência de precisão e treinamento.'),
(19, 'Oftalmologia', 'Oftalmologista é a área especialisada que estuda e tratam as doenças e patologias relacionadas ao olho, nervo óptico, à refração, e aos anexos do sistema de visão. Os oftalmologistas podem realizar cirurgias, prescrever tratamentos e realizar correções em distúrbios de visão.'),
(20, 'ORL', 'Para pesquisar'),
(21, 'Ortopedia', 'Ortopedia é a área que trabalha no movimento e sustentação do corpo com especial atenção para articulações, músculos, nervos, ligamentos, tendões e ossos.'),
(22, 'Pedriatria', 'Pediatria é á área especialisada no atendimento e assistência às crianças e adolescentes dentro da atuação preventiva e curativa. Atuam em hospitais, clínicas e consultórios.'),
(23, 'Pneumologia', 'Para pesquisar'),
(24, 'Psicologia', 'Para pesquisar'),
(25, 'Urologia', 'Urologista é a área especialisada que trabalha com o trato urinário de homens e mulheres e do sistema reprodutor de pessoas do sexo masculino. Os urologistas tratam e acompanham os pacientes com distúrbios urológicos, doenças no trato urinário, doenças sexualmente transmissíveis e mais.');

-- --------------------------------------------------------

--
-- Estrutura para tabela `exame`
--

CREATE TABLE `exame` (
  `id` int(11) NOT NULL,
  `id_consulta` int(11) DEFAULT NULL,
  `id_tipo_exame` int(11) NOT NULL,
  `data_exame` datetime NOT NULL,
  `resultado` text NOT NULL DEFAULT 'Exames Negativos'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `exame`:
--   `id_consulta`
--       `consulta` -> `id`
--   `id_tipo_exame`
--       `tipo_exame` -> `id`
--

--
-- Despejando dados para a tabela `exame`
--

INSERT INTO `exame` (`id`, `id_consulta`, `id_tipo_exame`, `data_exame`, `resultado`) VALUES
(1, 1, 1, '2026-03-05 11:00:00', 'Resultados normais'),
(2, 2, 2, '2026-03-05 12:00:00', 'Sinais de infecção pulmonar');

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionario`
--

CREATE TABLE `funcionario` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `cargo` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `funcionario`:
--   `uid`
--       `usuario` -> `uid`
--

--
-- Despejando dados para a tabela `funcionario`
--

INSERT INTO `funcionario` (`id`, `uid`, `name`, `cargo`) VALUES
(1, 3, 'funcionario1', 'recepcionista'),
(2, 4, 'funcionario2', 'emfermeiro');

-- --------------------------------------------------------

--
-- Estrutura para tabela `internamento`
--

CREATE TABLE `internamento` (
  `id` int(11) NOT NULL,
  `i_dconsulta` int(11) NOT NULL,
  `id_quarto` int(11) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_saida` date NOT NULL,
  `tipo_alta` enum('Alta medica','Transferencia','Obito','Abandono') DEFAULT 'Alta medica',
  `observacao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `internamento`:
--   `i_dconsulta`
--       `consulta` -> `id`
--   `id_quarto`
--       `quarto` -> `id`
--

--
-- Despejando dados para a tabela `internamento`
--

INSERT INTO `internamento` (`id`, `i_dconsulta`, `id_quarto`, `data_entrada`, `data_saida`, `tipo_alta`, `observacao`) VALUES
(1, 1, 1, '2026-03-05', '2026-03-08', 'Alta medica', NULL),
(2, 2, 2, '2026-03-06', '2026-03-09', 'Transferencia', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `medico`
--

CREATE TABLE `medico` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `id_especialidade` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `medico`:
--   `uid`
--       `usuario` -> `uid`
--   `id_especialidade`
--       `especialidade` -> `id`
--

--
-- Despejando dados para a tabela `medico`
--

INSERT INTO `medico` (`id`, `uid`, `id_especialidade`, `name`) VALUES
(1, 5, 1, 'medico1'),
(2, 6, 4, 'medico2');

-- --------------------------------------------------------

--
-- Estrutura para tabela `paciente`
--

CREATE TABLE `paciente` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `id_blood_type` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `genero` enum('m','f') NOT NULL,
  `bi_passaporte` varchar(14) NOT NULL,
  `data_nascimento` date NOT NULL,
  `alergias` text DEFAULT 'Nenhuma',
  `endereco` text NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `paciente`:
--   `uid`
--       `usuario` -> `uid`
--   `id_blood_type`
--       `blood_type` -> `id`
--

--
-- Despejando dados para a tabela `paciente`
--

INSERT INTO `paciente` (`id`, `uid`, `id_blood_type`, `name`, `telefone`, `genero`, `bi_passaporte`, `data_nascimento`, `alergias`, `endereco`) VALUES
(1, 1, 2, 'paciente1', '+244900000001', 'm', 'bi00001', '2000-02-10', 'Nenhuma', 'Luanda'),
(2, 2, 8, 'paciente2', '+244900000002', 'f', 'bi00002', '1995-06-15', 'Penicilina', 'Benguela'),
(3, NULL, 4, 'paciente1', '+244928740538', 'm', 'bi00003', '1980-07-30', 'Nenhuma', 'Luanda-Angola'),
(4, NULL, 4, 'paciente2', '+244928740538', 'f', 'bi00004', '1994-10-15', 'Poeira', 'Gamek-Luanda'),
(5, NULL, 4, 'paciente3', '+244928740538', 'f', 'bi00005', '2000-04-06', 'Lactose', 'Luanda-Angola'),
(6, NULL, 4, 'paciente4', '+244928740538', 'm', 'bi00006', '1995-10-20', 'Nenhuma', 'Gamek-Luanda');

-- --------------------------------------------------------

--
-- Estrutura para tabela `prontuarios`
--

CREATE TABLE `prontuarios` (
  `id` int(11) NOT NULL,
  `id_consulta` int(11) DEFAULT NULL,
  `sintomas` text DEFAULT NULL,
  `diagnostico` text DEFAULT NULL,
  `tratamento` text DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `data_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `prontuarios`:
--   `id_consulta`
--       `consulta` -> `id`
--

--
-- Despejando dados para a tabela `prontuarios`
--

INSERT INTO `prontuarios` (`id`, `id_consulta`, `sintomas`, `diagnostico`, `tratamento`, `observacoes`, `data_registro`) VALUES
(1, 1, 'Febre e tosse', 'Gripe', 'Antitérmico', 'Retorno em 3 dias', '2026-03-08 13:02:21'),
(2, 2, 'Dor abdominal', 'Infecção', 'Antibiótico', 'Monitorar', '2026-03-08 13:02:21');

-- --------------------------------------------------------

--
-- Estrutura para tabela `quarto`
--

CREATE TABLE `quarto` (
  `id` int(11) NOT NULL,
  `id_especialidade` int(11) DEFAULT NULL,
  `leitos` int(11) NOT NULL,
  `piso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `quarto`:
--   `id_especialidade`
--       `especialidade` -> `id`
--

--
-- Despejando dados para a tabela `quarto`
--

INSERT INTO `quarto` (`id`, `id_especialidade`, `leitos`, `piso`) VALUES
(1, 1, 4, 1),
(2, 3, 5, 2),
(3, 4, 6, 3),
(4, 20, 4, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `receita`
--

CREATE TABLE `receita` (
  `id` int(11) NOT NULL,
  `id_diagnostico` int(11) DEFAULT NULL,
  `id_medico` int(11) DEFAULT NULL,
  `data_receita` timestamp NOT NULL DEFAULT current_timestamp(),
  `obsercacao` text NOT NULL,
  `remedios` text NOT NULL,
  `dosagem` text NOT NULL,
  `frequencia` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `receita`:
--   `id_diagnostico`
--       `diagnostico` -> `id`
--   `id_medico`
--       `medico` -> `id`
--

--
-- Despejando dados para a tabela `receita`
--

INSERT INTO `receita` (`id`, `id_diagnostico`, `id_medico`, `data_receita`, `obsercacao`, `remedios`, `dosagem`, `frequencia`) VALUES
(1, 1, 1, '2026-03-08 13:02:21', 'Tomar por 5 dias', 'Paracetamol', '500mg', '8/8h'),
(2, 2, 2, '2026-03-08 13:02:21', 'Tomar por 7 dias', 'Amoxicilina', '500mg', '12/12h');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_exame`
--

CREATE TABLE `tipo_exame` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `tipo_exame`:
--

--
-- Despejando dados para a tabela `tipo_exame`
--

INSERT INTO `tipo_exame` (`id`, `name`, `descricao`) VALUES
(1, 'Hemograma Completo', 'Exame de sangue que avalia os componentes do sangue, como glóbulos vermelhos, glóbulos brancos e plaquetas.'),
(2, 'Raio-X de Tórax', 'Exame de imagem que utiliza radiação para visualizar os órgãos e estruturas do tórax, como pulmões, coração e costelas.'),
(3, 'Ultrassonografia Abdominal', 'Exame de imagem que utiliza ondas sonoras para criar imagens dos órgãos abdominais, como fígado, rins e vesícula biliar.'),
(4, 'Eletrocardiograma (ECG)', 'Exame que registra a atividade elétrica do coração para avaliar o ritmo cardíaco e detectar possíveis anormalidades.'),
(5, 'Teste de Função Pulmonar', 'Exame que mede a capacidade pulmonar e a função respiratória para diagnosticar doenças pulmonares.'),
(6, 'Endoscopia Digestiva Alta', 'Exame que utiliza um endoscópio para visualizar o interior do esôfago, estômago e duodeno, auxiliando no diagnóstico de problemas gastrointestinais.'),
(7, 'Ressonância Magnética (RM)', 'Exame de imagem que utiliza campos magnéticos e ondas de rádio para criar imagens detalhadas dos órgãos e tecidos do corpo.'),
(8, 'Tomografia Computadorizada (TC)', 'Exame de imagem que utiliza raios-X para criar imagens transversais do corpo, auxiliando no diagnóstico de diversas condições médicas.'),
(9, 'Teste de Glicemia', 'Exame que mede os níveis de glicose no sangue para diagnosticar e monitorar o diabetes.'),
(10, 'Exame de Urina', 'Exame que analisa a composição da urina para detectar infecções, doenças renais e outras condições médicas.');

-- --------------------------------------------------------

--
-- Estrutura para tabela `triagem`
--

CREATE TABLE `triagem` (
  `id` int(11) NOT NULL,
  `id_funcionario` int(11) DEFAULT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `peso` double NOT NULL,
  `temperatura` double NOT NULL,
  `observacoes` text DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `triagem`:
--   `id_funcionario`
--       `funcionario` -> `id`
--   `id_paciente`
--       `paciente` -> `id`
--

--
-- Despejando dados para a tabela `triagem`
--

INSERT INTO `triagem` (`id`, `id_funcionario`, `id_paciente`, `peso`, `temperatura`, `observacoes`, `data`) VALUES
(1, 1, 1, 70.5, 36.5, 'Normal', '2026-03-08 13:02:18'),
(2, 2, 2, 65.2, 37.8, 'Febre leve', '2026-03-08 13:02:18');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `uid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `genero` enum('m','f') NOT NULL,
  `endereco` text NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL,
  `profile` enum('admin','doctor','employee','patient') NOT NULL DEFAULT 'patient',
  `data_criacao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- RELACIONAMENTOS PARA TABELAS `usuario`:
--

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`uid`, `name`, `email`, `telefone`, `genero`, `endereco`, `password`, `profile`, `data_criacao`) VALUES
(1, 'funcionario1', 'funcionario1@gmail.com', '+244928740538', 'm', '', '12345', 'employee', '2026-03-08 13:02:16'),
(2, 'funcionario2', 'funcionario2@gmail.com', '+244928740538', 'f', '', '12345', 'employee', '2026-03-08 13:02:16'),
(3, 'doc1', 'doc1@gmail.com', '+244928740538', 'm', '', '12345', 'doctor', '2026-03-08 13:02:16'),
(4, 'doc2', 'doc2@gmail.com', '+244928740538', 'f', '', '12345', 'doctor', '2026-03-08 13:02:16'),
(5, 'paciente1', 'paciente1@gmail.com', '+244928740538', 'm', 'Luanda-Angola', '12345', 'patient', '2026-03-08 13:02:16'),
(6, 'paciente2', 'paciente2@gmail.com', '+244928740538', 'f', 'Gamek-Luanda', '12345', 'patient', '2026-03-08 13:02:16'),
(7, 'paciente3', 'paciente3@gmail.com', '+244928740538', 'm', 'Luanda-Angola', '12345', 'patient', '2026-03-08 13:02:16'),
(8, 'paciente4', 'paciente4@gmail.com', '+244928740538', 'f', 'Gamek-Luanda', '12345', 'patient', '2026-03-08 13:02:16');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `blood_type`
--
ALTER TABLE `blood_type`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `consulta`
--
ALTER TABLE `consulta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_triagem` (`id_triagem`),
  ADD KEY `id_medico` (`id_medico`);

--
-- Índices de tabela `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_consulta` (`id_consulta`);

--
-- Índices de tabela `especialidade`
--
ALTER TABLE `especialidade`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `exame`
--
ALTER TABLE `exame`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_consulta` (`id_consulta`),
  ADD KEY `id_tipo_exame` (`id_tipo_exame`);

--
-- Índices de tabela `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`);

--
-- Índices de tabela `internamento`
--
ALTER TABLE `internamento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `i_dconsulta` (`i_dconsulta`),
  ADD KEY `id_quarto` (`id_quarto`);

--
-- Índices de tabela `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`),
  ADD KEY `id_especialidade` (`id_especialidade`);

--
-- Índices de tabela `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bi_passaporte` (`bi_passaporte`),
  ADD UNIQUE KEY `uid` (`uid`),
  ADD KEY `id_blood_type` (`id_blood_type`);

--
-- Índices de tabela `prontuarios`
--
ALTER TABLE `prontuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_consulta` (`id_consulta`);

--
-- Índices de tabela `quarto`
--
ALTER TABLE `quarto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_especialidade` (`id_especialidade`);

--
-- Índices de tabela `receita`
--
ALTER TABLE `receita`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_diagnostico` (`id_diagnostico`),
  ADD KEY `id_medico` (`id_medico`);

--
-- Índices de tabela `tipo_exame`
--
ALTER TABLE `tipo_exame`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `triagem`
--
ALTER TABLE `triagem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_funcionario` (`id_funcionario`),
  ADD KEY `id_paciente` (`id_paciente`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `blood_type`
--
ALTER TABLE `blood_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `consulta`
--
ALTER TABLE `consulta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `diagnostico`
--
ALTER TABLE `diagnostico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `especialidade`
--
ALTER TABLE `especialidade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de tabela `exame`
--
ALTER TABLE `exame`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `funcionario`
--
ALTER TABLE `funcionario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `internamento`
--
ALTER TABLE `internamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `medico`
--
ALTER TABLE `medico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `prontuarios`
--
ALTER TABLE `prontuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `quarto`
--
ALTER TABLE `quarto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `receita`
--
ALTER TABLE `receita`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `tipo_exame`
--
ALTER TABLE `tipo_exame`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `triagem`
--
ALTER TABLE `triagem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `consulta`
--
ALTER TABLE `consulta`
  ADD CONSTRAINT `consulta_ibfk_1` FOREIGN KEY (`id_triagem`) REFERENCES `triagem` (`id`),
  ADD CONSTRAINT `consulta_ibfk_2` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id`);

--
-- Restrições para tabelas `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD CONSTRAINT `diagnostico_ibfk_1` FOREIGN KEY (`id_consulta`) REFERENCES `consulta` (`id`);

--
-- Restrições para tabelas `exame`
--
ALTER TABLE `exame`
  ADD CONSTRAINT `exame_ibfk_1` FOREIGN KEY (`id_consulta`) REFERENCES `consulta` (`id`),
  ADD CONSTRAINT `exame_ibfk_2` FOREIGN KEY (`id_tipo_exame`) REFERENCES `tipo_exame` (`id`);

--
-- Restrições para tabelas `funcionario`
--
ALTER TABLE `funcionario`
  ADD CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `usuario` (`uid`);

--
-- Restrições para tabelas `internamento`
--
ALTER TABLE `internamento`
  ADD CONSTRAINT `internamento_ibfk_1` FOREIGN KEY (`i_dconsulta`) REFERENCES `consulta` (`id`),
  ADD CONSTRAINT `internamento_ibfk_2` FOREIGN KEY (`id_quarto`) REFERENCES `quarto` (`id`);

--
-- Restrições para tabelas `medico`
--
ALTER TABLE `medico`
  ADD CONSTRAINT `medico_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `usuario` (`uid`),
  ADD CONSTRAINT `medico_ibfk_2` FOREIGN KEY (`id_especialidade`) REFERENCES `especialidade` (`id`);

--
-- Restrições para tabelas `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `paciente_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `usuario` (`uid`) ON DELETE SET NULL,
  ADD CONSTRAINT `paciente_ibfk_2` FOREIGN KEY (`id_blood_type`) REFERENCES `blood_type` (`id`);

--
-- Restrições para tabelas `prontuarios`
--
ALTER TABLE `prontuarios`
  ADD CONSTRAINT `prontuarios_ibfk_1` FOREIGN KEY (`id_consulta`) REFERENCES `consulta` (`id`);

--
-- Restrições para tabelas `quarto`
--
ALTER TABLE `quarto`
  ADD CONSTRAINT `quarto_ibfk_1` FOREIGN KEY (`id_especialidade`) REFERENCES `especialidade` (`id`);

--
-- Restrições para tabelas `receita`
--
ALTER TABLE `receita`
  ADD CONSTRAINT `receita_ibfk_1` FOREIGN KEY (`id_diagnostico`) REFERENCES `diagnostico` (`id`),
  ADD CONSTRAINT `receita_ibfk_2` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id`);

--
-- Restrições para tabelas `triagem`
--
ALTER TABLE `triagem`
  ADD CONSTRAINT `triagem_ibfk_1` FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id`),
  ADD CONSTRAINT `triagem_ibfk_2` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
