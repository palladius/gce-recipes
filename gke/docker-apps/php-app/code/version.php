<?php include_once('header.php'); ?>
<h1>VERSION</h1>
<?php  
echo "Version: " ;
echo file_get_contents('VERSION');
?>  
<?php
include_once('footer.php');
?>
