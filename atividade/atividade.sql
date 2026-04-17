CREATE TABLE IF NOT EXISTS clientes(
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  status VARCHAR(20) DEFAULT 'ativo',
  limite NUMERIC(10,2) CHECK (LIMITE >=0),
  criado_em TIMESTAMPTZ DEFAULT NOW()
);

-- Tabela pai
CREATE TABLE IF NOT EXISTS autores (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT null
);

-- Depois a tabela filha (que faz a referência)
CREATE TABLE IF NOT EXISTS livros(
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  preco NUMERIC(10,2) NOT NULL,
  autor_id INTEGER REFERENCES autores(id) ON DELETE RESTRICT
);-- Na tabela track a coluna album_id uma foreign key se conecta a tabela album onde o pk é o album_id e a tabela album se conecta com a tabela artist pelo artist_id que é o foreign key com a tabela artist que tem a pk como artist_id

ALTER TABLE livros ALTER COLUMN titulo type VARCHAR(200);