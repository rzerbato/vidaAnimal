<?php
$this->breadcrumbs=array(
	'Configuración de Precios'
	/*'Configprecios'=>array('index'),
	$model->idConfigPrecio=>array('view','id'=>$model->idConfigPrecio),
	'Update',*/
);

	$this->menu=array(
	array('label'=>'','url'=>'#'),
	/*array('label'=>'Create Configprecio','url'=>array('create')),
	array('label'=>'View Configprecio','url'=>array('view','id'=>$model->idConfigPrecio)),
	array('label'=>'Manage Configprecio','url'=>array('admin')),*/
	);
	?>

	<h1>Configuración de Precios <?php #echo $model->idConfigPrecio; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>