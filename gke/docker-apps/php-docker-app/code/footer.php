<?php
	$version = file_get_contents('VERSION');
?>
<hr/>

Riccardo first PHP app (beware!) v.<?= $version ?>

[
   <a href='/'>Home</a> 
	|
   <a href='/phpinfo.php'>PhPInfo</a> 
	|
   <a href='/version.php'>Version</a> 
]
