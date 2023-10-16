<?php
$this->breadcrumbs=array(
	'Configprecios'=>array('index'),
	'Create',
);

$this->menu=array(
array('label'=>'List Configprecio','url'=>array('index')),
array('label'=>'Manage Configprecio','url'=>array('admin')),
);
?>

<h1>Create Configprecio</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>