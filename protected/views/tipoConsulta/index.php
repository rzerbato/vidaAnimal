<?php
$this->breadcrumbs=array(
	'Tipo Consultas',
);

$this->menu=array(
array('label'=>'Create TipoConsulta','url'=>array('create')),
array('label'=>'Manage TipoConsulta','url'=>array('admin')),
);
?>

<h1>Tipo Consultas</h1>

<?php $this->widget('booster.widgets.TbListView',array(
'dataProvider'=>$dataProvider,
'itemView'=>'_view',
)); ?>
