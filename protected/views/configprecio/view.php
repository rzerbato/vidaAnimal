<?php
$this->breadcrumbs=array(
	'Configprecios'=>array('index'),
	$model->idConfigPrecio,
);

$this->menu=array(
array('label'=>'List Configprecio','url'=>array('index')),
array('label'=>'Create Configprecio','url'=>array('create')),
array('label'=>'Update Configprecio','url'=>array('update','id'=>$model->idConfigPrecio)),
array('label'=>'Delete Configprecio','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idConfigPrecio),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Configprecio','url'=>array('admin')),
);
?>

<h1>View Configprecio #<?php echo $model->idConfigPrecio; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		'idConfigPrecio',
		'incrementoPrecio2',
		'incrementoPrecio3',
),
)); ?>
