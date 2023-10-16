<?php
$this->breadcrumbs=array(
	'Clientes',
);

$this->menu=array(
array('label'=>'Create Cliente','url'=>array('create')),
array('label'=>'Manage Cliente','url'=>array('admin')),
);
?>

<h1>Clientes</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
