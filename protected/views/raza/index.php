<?php
$this->breadcrumbs=array(
	'Razas',
);

$this->menu=array(
array('label'=>'Create Raza','url'=>array('create')),
array('label'=>'Manage Raza','url'=>array('admin')),
);
?>

<h1>Razas</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
