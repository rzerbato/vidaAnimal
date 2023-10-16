<?php
$this->breadcrumbs=array(
	'Administrar'=>array('index'),
);?>
<h1> Administrar Backups </h1>

<?php $this->renderPartial('_list', array(
		'dataProvider'=>$dataProvider,
));
?>
