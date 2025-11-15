<?php
// Definindo variáveis para conexão
$hostname_conn  =   "localhost";
$database_conn  =   "iwanez83_ti19";
$username_conn  =   "iwanez83_ti19";
$password_conn  =   "senacti19";
$charset_conn   =   "utf8";

$conn_produtos  =   
    new mysqli(
        $hostname_conn,
        $username_conn,
        $password_conn,
        $database_conn
    );
// Definir o conjunto de caracteres da conexão
mysqli_set_charset($conn_produtos,$charset_conn);

// Verificando possíveis erros na conexão
if($conn_produtos->connect_error){
    echo "Error: ".$conn_produtos->connect_error;
};
// Não deixar espaços vazios depois do fechamento do PHP pois causa erro HEADER
?>