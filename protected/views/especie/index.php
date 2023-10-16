<?php
$this->breadcrumbs=array(
	'Especies',
);

$this->menu=array(
array('label'=>'Create Especie','url'=>array('create')),
array('label'=>'Manage Especie','url'=>array('admin')),
);
?>

<h1>Especies</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
