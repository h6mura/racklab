<?php
//incluir arquivo e fazer a conexão
include ("..//Connections/conn_produtos.php");
// Selecionar os dados
$consulta = "
            SELECT *
            FROM    tbusuarios
            ORDER BY id_usuario DESC;
            ";
// Fazer uma lista completa dos dados
$lista      =   $conn_produtos->query($consulta);
//separa os dados em linhas (row)
$row     =   $lista->fetch_assoc();
// contar o total de linhas 
$totalRows  =   ($lista)->num_rows;
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Usuários Lista</title>
</head>
<body>
    <main>
        <h1>Lista de Usuários</h1>
        <div>
            Total de usuarios:
            <small><?php echo $totalRows?></small> 
        </div>
    <table border = '1'>
        <thead>
            <tr>
                <th>ID</th>
                <th>LOGIN</th>
                <th>NIVEL</th>
                <th>ALTERAR|EXCLUIR</th>
            </tr>
        </thead>
        <tbody>
        <?php do {?> <!-- abre estrutura de repetição -->
            <tr>
                <td><?php echo $row['id_usuario'];?></td>
                <td><?php echo $row['login_usuario'];?></td>
                <td><?php echo $row['nivel_usuario'];?></td>
                <td>ALTERAR|EXCLUIR</td>
            </tr>
            <?php }while($row = $lista->fetch_assoc());  ?>
        </tbody>
    </table>
    </main>
    
</body>
</html>
<?php mysqli_free_result($lista);?>