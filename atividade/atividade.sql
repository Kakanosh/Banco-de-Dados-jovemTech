--select = seleciona as tabela
--from = é de onde ele vai puxar
--"*" = seleciona todos as colunas 
--limit = ele limita a quantidade de itens que serão mostrados
--"," ele separa cada item ou elementos que você for puxar

--select * from customer limit 5

--select first_name, country from customer limit 6

-- eu consigo puxar as colunas pondo os nomes delas entre from e limit

-- select first_name, last_name, city, email, phone from customer 

-- IF NOT EXISTS = serve para criar a tabela caso ela não exita. Isso garante que não quebre seu codigo.

--PK(Primary Key) chave única ou identificador único

-- fg(foreign key) Chave filho que herda da chave pk pai

--Serial auto incrementa ids
CREATE TABLE IF NOT EXISTS clientes (

id SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL,
status VARCHAR(20) DEFAULT 'ativo',
limite NUMERIC (10,2) CHECK (limite >= 0),
criado_em TIMESTAMPTZ DEFAULT NOW()
);


--PRIMEIRO CRIA A TABELA PAI
CREATE TABLE  IF NOT EXISTS autores (
   id SERIAL PRIMARY KEY,
   nome VARCHAR(100) NOT NULL
);

--Depois a tabela filha (que faz referência)
CREATE TABLE  IF NOT EXISTS livros (
   id SERIAL PRIMARY KEY,
   titulo VARCHAR(150) NOT NULL,
   preco NUMERIC(10,2) NOT NULL,
   autor_id INTEGER REFERENCES autores(id) ON DELETE RESTRICT
);

-- atividade: Tabela Sistema de clínica Médica [SABOTAGEM 1]
CREATE TABLE consultas (
    id INTEGER,
    paciente VARCHAR(100),
    medico VARCHAR(100),
    data_consulta TIMESTAMP,
    valor REAL,
    status VARCHAR(20) DEFAULT "ativo",
);
CREATE TABLE consultas_certas (
    id SERIAL PRIMARY KEY,
    paciente_id VARCHAR REFERENCES paciente(id) ON DELETE RESTRICT,
    medico_id INTEGER REFERENCES medico(id) ON DELETE RESTRICT,
    data_consulta TIMESTAMPTZ DEFAULT NOW(),
    valor NUMERIC(10,2) NOT NULL,
    status VARCHAR(50)
)

CREATE TABLE paciente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE medico (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
);

-- Segunda atividade [SABOTAGEM 2]

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY ,
    cliente_id INTEGER REFERENCES clientes(id) NOT NULL,
    total DOUBLE PRECISION,
    desconto NUMERIC(10,2),
    criado_em TIMESTAMP
    status VARCHAR(20) DEFAULT 'pendente'
)

-- esquema da aula 2

CREATE TABLE artistas_caju (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    criado_em TIMESTAMPTZ DEFAULT NOW(),
    pais_origem VARCHAR(50,)
);

CREATE TABLE albuns_caju (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    ano INTEGET NOT NULL CHECK (ano > 1850),
    preco NUMERIC(10,2) CHECK (preco > 0),
    artista_id INTEGER NOT NULL REFERENCES artistas_caju(id),
);

CREATE TABLE faixas_caju (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    duracao INTEGER NOT NULL CHECK (duracao > 0),
    album_id INTEGER NOT NULL REFERENCES albuns_caju(id),
);

ALTER TABLE albuns_caju ADD COLUMN genero_musical TYPE VARCHAR(50) CHECK (genero_musical IN ('Rock', 'Pop', 'Rap', 'Samba', 'MPB'))

--Comando para adicionar uma coluna de uma tabela criada
ALTER TABLE livros ADD COLUMN paginas integer;
-- Comando para deletar uma coluna de uma tabela
ALTER TABLE livros DROP COLUMN paginas;
-- Comando para alterar tipo de uma coluna de uma tabela especifica
ALTER TABLE livros ALTER COLUMN titulo TYPE VARCHAR(200);