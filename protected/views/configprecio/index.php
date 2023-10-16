<?php
$this->breadcrumbs=array(
	'Configprecios',
);

$this->menu=array(
array('label'=>'Create Configprecio','url'=>array('create')),
array('label'=>'Manage Configprecio','url'=>array('admin')),
);
?>

<h1>Configprecios</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
