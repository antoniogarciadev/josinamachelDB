CREATE DATABASE medsys
DEFAULT COLLATE utf8_general_ci;

CREATE TABLE Usuario (
	`uid` INT AUTO_INCREMENT,
	`name` VARCHAR(45) NOT NULL,
	`email` VARCHAR(45) NOT NULL,
	`bi_passaporte` VARCHAR(14) NOT NULL,
	`data_nascimento` DATE NOT NULL,
	`password` VARCHAR(10) NOT NULL UNIQUE,
	`profile` VARCHAR(45) NOT NULL DEFAULT 'Paciente',
    `data_criacao` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(`uid`)    
)CHAR SET utf_8;

-- INSERT INTO `usuario` ( `uname`, `uemail`, `usenha`, `genero`)
-- VALUES (`Paciente`, `paciente@gmail.com`, `12345`, );
  
  CREATE TABLE Funcionario (
	id INT AUTO_INCREMENT,
	uid INT,
	name VARCHAR(45) NOT NULL,
	contacto INT(12) NOT NULL,
    email VARCHAR(45) NOT NULL,
    cargo VARCHAR(45),
	PRIMARY KEY(id),
    FOREIGN KEY(uid) REFERENCES Usuario(uid)
)CHAR SET utf_8;
  
CREATE TABLE Medico (
	id INT AUTO_INCREMENT,
    uid INT,
	name VARCHAR(45) NOT NULL,
	cargo VARCHAR(45) NOT NULL,
    especialidade VARCHAR(45),
	contacto INT(12) NOT NULL,
    email VARCHAR(40) NOT NULL,
	PRIMARY KEY(id),
    FOREIGN KEY(uid) REFERENCES Usuario(uid)
)CHAR SET utf_8;

CREATE TABLE Paciente (
	id INT AUTO_INCREMENT,
	uid INT, -- Chave estrangeira
    name VARCHAR(40) NOT NULL,
    genero VARCHAR(1) NOT NULL,
    grupo_sanguineo VARCHAR(3),
	alergias VARCHAR(45),
    data_nascimento DATE NOT NULL,
    bi VARCHAR(14) NOT NULL UNIQUE,
	contacto INT(13) NOT NULL,
    email VARCHAR(45) NOT NULL,
    endereco VARCHAR(45),
    PRIMARY KEY(id),
    FOREIGN KEY(uid) REFERENCES Usuario(uid)
)CHAR SET utf_8;
    
CREATE TABLE Triagem (
	id INT AUTO_INCREMENT,
	idfuncionario INT,
    idpaciente INT,
	peso DOUBLE NOT NULL,
	temperatura DOUBLE NOT NULL,
	observacoes VARCHAR(45),
	data_triagem DATETIME NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(idmedico) REFERENCES Medico(id),
	FOREIGN KEY(idpaciente) REFERENCES paciente(id)
)CHAR SET utf_8;

CREATE TABLE Consulta (
	id INT AUTO_INCREMENT,
	idtriagem INT NOT NULL,
	idpaciente INT NOT NULL,
	idmedico INT NOT NULL,
	data_consulta DATE NOT NULL,
    hora_marcada TIME NOT NULL,
	status VARCHAR(45) NOT NULL,
    observacoes VARCHAR(45),
	PRIMARY KEY(id),
	FOREIGN KEY(idtriagem) REFERENCES Triagem(id),
    FOREIGN KEY(idmedico) REFERENCES Medico(id),
	FOREIGN KEY(idpaciente) REFERENCES Paciente(id)
)CHAR SET utf_8;

CREATE TABLE Exame (
	id INT AUTO_INCREMENT,
	idconsulta INT,
	data_exame DATETIME NOT NULL,
    tipo_exame VARCHAR(100),
    resultado VARCHAR(100),
	PRIMARY KEY(id),
    FOREIGN KEY(idconsulta) REFERENCES Consulta(id)
)CHAR SET utf_8;

CREATE TABLE Diagnostico (
	id INT AUTO_INCREMENT,
	idconsulta INT,
	descricao VARCHAR(45) NOT NULL,
    observacao VARCHAR(45),
    data_diagnostico DATETIME NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(idconsulta) REFERENCES Consulta(id)
)CHAR SET utf_8;

CREATE TABLE Receitas(
	id INT AUTO_INCREMENT,
	iddiagnostico INT,
	idmedico INT,
	data_receita DATETIME NOT NULL,
	obsercacao VARCHAR(100) NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(iddiagnostico) REFERENCES Consulta(id),
    FOREIGN KEY(idmedico) REFERENCES Medico(id),
	-- adicionar paciente
)CHAR SET utf_8;

CREATE TABLE Items_receita(
	id INT AUTO_INCREMENT,
	idreceita INT,
	remedios VARCHAR(100) NOT NULL,
	dosagem VARCHAR(45) NOT NULL,
	frequencia VARCHAR(45) NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(idreceita) REFERENCES Receita(id)
)CHAR SET utf_8;

CREATE TABLE Quarto(
	id INT AUTO_INCREMENT,
    leitos INT NOT NULL,
	area VARCHAR(45),
    piso INT,
    PRIMARY KEY(id_quarto)
)CHAR SET utf_8;

CREATE TABLE Internamento (
	id INT AUTO_INCREMENT,
	-- idpaceinte INT NOT NULL,
	idconsulta INT NOT NULL,
    idquarto INT NOT NULL,
    data_entrada DATE NOT NULL,
    data_saida DATE NOT NULL,
	tipo_alta VARCHAR(20) NOT NULL,
    PRIMARY KEY(id),
	FOREIGN KEY(idpaceinte) REFERENCES paciente(id),
    FOREIGN KEY(idconsulta) REFERENCES Consulta(id),
    FOREIGN KEY(idquarto) REFERENCES Quarto(id)
)CHAR SET utf_8;