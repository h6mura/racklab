DROP USER IF EXISTS 'racklab_ti19'@'localhost';

-- Criar o usuário iwanez83_ti19 se ele não existir
CREATE USER IF NOT EXISTS 'racklab_ti19'@'localhost'
    IDENTIFIED BY 'senacti19';
GRANT ALL PRIVILEGES ON *.* TO 'racklab_ti19'@'localhost'
    WITH GRANT OPTION;
    FLUSH PRIVILEGES;

-- Excluir o banco de dados racklab_ti19 caso ele exista
DROP DATABASE IF EXISTS racklab_ti19;

-- Criar o banco de dados racklab_ti19 se ele não existir
CREATE DATABASE IF NOT EXISTS racklab_ti19
    DEFAULT CHARACTER SET utf8
    COLLATE utf8_general_ci;

USE racklab_ti19

-- Estrutura da tabela tbtipos
CREATE TABLE tbtipos(
    id_tipo INT(11) NOT NULL,
    sigla_tipo VARCHAR(3) NOT NULL,
    rotulo_tipo VARCHAR(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Extraindo dados da tabela tbtipos
INSERT INTO tbtipos(id_tipo,sigla_tipo,rotulo_tipo) VALUES
 

-- Estrutura da tabela tbprodutos
CREATE TABLE tbprodutos(
    id_produto INT(11) NOT NULL,
    id_tipo_produto INT(11) NOT NULL,
    descri_produto VARCHAR(100) NOT NULL,
    resumo_produto VARCHAR(1000) NULL,
    valor_produto DECIMAL(9,2) NULL,
    imagem_produto VARCHAR(50) NULL,
    destaque_produto enum('Sim','Não') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Extraindo dados da tabela `tbprodutos`
INSERT INTO tbprodutos (id_produto, id_categoria, nome_produto, descricao_produto, resumo_produto, 
aplicacao_produto, nivel_dificuldade, valor_produto, arquivo_principal, imagem_demonstrativa, formato_arquivo, 
tamanho_arquivo, tags, destaque_produto) VALUES
(1, 1, 'Rack 19" 42U', 'Modelo educativo de rack para data center', 'Rack completo para ensino de organização', 
'Aula de data centers', 'Iniciante', 45.90, 'rack_42u.stl', 'rack.jpg', 'STL', '8.5 MB', 'rack, data center', 'Sim'),

(2, 2, 'Switch Cisco 2960', 'Switch layer 2 para demonstrações', 'Equipamento para configuração de redes', 
'Aulas de switches', 'Intermediário', 89.90, 'switch_cisco.obj', 'switch.jpg', 'OBJ', '12.7 MB', 'switch, cisco', 'Sim'),

(3, 3, 'Conector RJ45', 'Modelo educativo de conector de rede', 'Visualização interna para crimpagem', 
'Aulas de cabos', 'Iniciante', 8.90, 'rj45.stl', 'conector.jpg', 'STL', '1.1 MB', 'rj45, conector', 'Não');

-- Criar tabela `tbusuarios`
CREATE TABLE tbusuarios (
    id_usuario INT NOT NULL,
    login_usuario VARCHAR(30) NOT NULL,
    senha_usuario VARCHAR(8) NOT NULL,
    nivel_usuario ENUM('sup','com') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Inserir dados na tabela `tbusuarios`
INSERT INTO tbusuarios (id_usuario, login_usuario, senha_usuario, nivel_usuario) 
    VALUES
    (1, 'senac', '1234', 'sup'),
    (2, 'joao', '456', 'com'),
    (3, 'maria', '789', 'com'),
    (4, 'iwanezuk', '1234', 'sup');

-- ------ CHAVES ------
ALTER TABLE tbprodutos
    ADD PRIMARY KEY (id_produto),
    ADD KEY id_tipo_produto_fk(id_tipo_produto);

ALTER TABLE tbtipos
    ADD PRIMARY KEY (id_tipo);

-- Índices para tabela tbusuarios
ALTER TABLE tbusuarios	
    ADD   PRIMARY KEY (id_usuario),
    ADD   UNIQUE KEY login_usuario_uniq(login_usuario);

-- ----- AUTO INCREMENTS -----
ALTER TABLE tbprodutos
    MODIFY id_produto INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE tbtipos
    MODIFY id_tipo INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE tbusuarios
    MODIFY id_usuario INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- Limitadores e referências da Chave Estrangeira
ALTER TABLE tbprodutos
    ADD CONSTRAINT id_tipo_produto_fk FOREIGN KEY(id_tipo_produto)
        REFERENCES tbtipos(id_tipo)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;

-- -------- VIEW --------
-- Criando a view vw_tbprodutos
CREATE VIEW vw_tbprodutos as
    SELECT  p.id_produto,
            p.id_tipo_produto,
            t.sigla_tipo,
            t.rotulo_tipo,
            p.descri_produto,
            p.resumo_produto,
            p.valor_produto,
            p.imagem_produto,
            p.destaque_produto
    FROM    tbprodutos p JOIN tbtipos t
    WHERE   p.id_tipo_produto=t.id_tipo;