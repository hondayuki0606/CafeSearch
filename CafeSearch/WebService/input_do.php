//
//  saveBoy.php
//  CafeSearch
//
//  Created by 本田尚行 on 2020/09/10.
//  Copyright © 2020 本田尚行. All rights reserved.
//
<?php
require_once 'config.php';
$link = mysqli_connect($db_host, $db_user, $db_password, $db_name);
// 接続チェックを行います。
if (mysqli_connect_errno()) {
die(mysqli_connect_error());
}
mysqli_select_db( $link ,$db_name);
mysqli_query( $link ,'SET NAMES UTF8');
$id = mysqli_real_escape_string( $link ,$_POST['id']);
$address = mysqli_real_escape_string( $link ,$_POST['address']);
$sex = mysqli_real_escape_string( $link ,$_POST['sex']);
$age = mysqli_real_escape_string( $link ,$_POST['age']);
$sql = "INSERT INTO $table_name (id, address, sex, age) VALUES ($id, $address, $sex, $age)";
$result_flag = mysqli_query( $link ,$sql);
if (!$result_flag) {
die('INSERTクエリーが失敗しました。'.mysql_error());
}
?>
