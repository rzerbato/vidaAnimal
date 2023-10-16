<?php
$this->breadcrumbs=array(
	'Sub Rubros',
);

$this->menu=array(
array('label'=>'Create SubRubro','url'=>array('create')),
array('label'=>'Manage SubRubro','url'=>array('admin')),
);
?>

<h1>Sub Rubros</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
