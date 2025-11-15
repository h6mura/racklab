-- Excluir o banco de dados racklab_ti19 caso ele exista
DROP DATABASE IF EXISTS racklab_ti19;

-- Criar o banco de dados racklab_ti19 se ele não existir
CREATE DATABASE IF NOT EXISTS racklab_ti19
    DEFAULT CHARACTER SET utf8
    COLLATE utf8_general_ci;

USE racklab_ti19;

-- Excluir e recriar usuário
DROP USER IF EXISTS 'racklab_ti19'@'localhost';
CREATE USER IF NOT EXISTS 'racklab_ti19'@'localhost'
    IDENTIFIED BY 'senacti19';
GRANT ALL PRIVILEGES ON racklab_ti19.* TO 'racklab_ti19'@'localhost';
FLUSH PRIVILEGES;

-- Estrutura da tabela tbtipos (CATEGORIAS)
CREATE TABLE tbtipos(
    id_tipo INT(11) NOT NULL AUTO_INCREMENT,
    sigla_tipo VARCHAR(3) NOT NULL,
    rotulo_tipo VARCHAR(15) NOT NULL,
    PRIMARY KEY (id_tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Inserir categorias/tipos
INSERT INTO tbtipos (id_tipo, sigla_tipo, rotulo_tipo) VALUES
(1, 'rak', 'Racks'),
(2, 'swi', 'Switches'),
(3, 'cab', 'Cabos');

-- Estrutura da tabela tbprodutos (CORRIGIDA)
CREATE TABLE tbprodutos(
    id_produto INT(11) NOT NULL AUTO_INCREMENT,
    id_tipo_produto INT(11) NOT NULL,
    descri_produto VARCHAR(100) NOT NULL,
    resumo_produto VARCHAR(1000) NULL,
    valor_produto DECIMAL(9,2) NULL,
    imagem_produto VARCHAR(50) NULL,
    destaque_produto ENUM('Sim','Não') NOT NULL DEFAULT 'Não',
    PRIMARY KEY (id_produto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Inserir produtos (CORRIGIDO - seguindo a estrutura da tabela)
INSERT INTO tbprodutos (id_produto, id_tipo_produto, descri_produto, resumo_produto, valor_produto, imagem_produto, destaque_produto) VALUES
(1, 1, 'Rack 19" 42U', 'Modelo educativo de rack para data center - ideal para ensino de organização de infraestrutura', 45.90, 'rack_42u.jpg', 'Sim'),
(2, 2, 'Switch Cisco 2960', 'Switch layer 2 para demonstrações em aula de redes', 89.90, 'switch_cisco.jpg', 'Sim'),
(3, 3, 'Conector RJ45', 'Modelo educativo de conector de rede para ensino de crimpagem', 8.90, 'conector_rj45.jpg', 'Não');

-- Criar tabela tbusuarios
CREATE TABLE tbusuarios (
    id_usuario INT(11) NOT NULL AUTO_INCREMENT,
    login_usuario VARCHAR(30) NOT NULL,
    senha_usuario VARCHAR(8) NOT NULL,
    nivel_usuario ENUM('sup','com') NOT NULL,
    PRIMARY KEY (id_usuario),
    UNIQUE KEY login_usuario_uniq (login_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Inserir usuários
INSERT INTO tbusuarios (id_usuario, login_usuario, senha_usuario, nivel_usuario) VALUES
(1, 'senac', '1234', 'sup'),
(2, 'joao', '456', 'com'),
(3, 'maria', '789', 'com'),
(4, 'admin', '1234', 'sup');

-- Adicionar chave estrangeira
ALTER TABLE tbprodutos
ADD CONSTRAINT fk_tipo_produto
FOREIGN KEY (id_tipo_produto) REFERENCES tbtipos(id_tipo)
ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Criar VIEW
CREATE VIEW vw_tbprodutos AS
SELECT p.id_produto,
       p.id_tipo_produto,
       t.sigla_tipo,
       t.rotulo_tipo,
       p.descri_produto,
       p.resumo_produto,
       p.valor_produto,
       p.imagem_produto,
       p.destaque_produto
FROM tbprodutos p 
JOIN tbtipos t ON p.id_tipo_produto = t.id_tipo;