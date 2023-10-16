<?php
$this->breadcrumbs=array(
	'Rubros',
);

$this->menu=array(
array('label'=>'Create Rubro','url'=>array('create')),
array('label'=>'Manage Rubro','url'=>array('admin')),
);
?>

<h1>Rubros</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
