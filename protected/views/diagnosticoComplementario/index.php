<?php
/* @var $this DiagnosticocomplementarioController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Diagnosticocomplementarios',
);

$this->menu=array(
	array('label'=>'Create Diagnosticocomplementario', 'url'=>array('create')),
	array('label'=>'Manage Diagnosticocomplementario', 'url'=>array('admin')),
);
?>

<h1>Diagnosticocomplementarios</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
