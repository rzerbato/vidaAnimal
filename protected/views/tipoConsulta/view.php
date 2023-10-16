<?php
$this->breadcrumbs=array(
	'Tipo de Consultas'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
/*array('label'=>'List TipoConsulta','url'=>array('index')),
array('label'=>'Create TipoConsulta','url'=>array('create')),
array('label'=>'Update TipoConsulta','url'=>array('update','id'=>$model->idtipoConsulta)),
array('label'=>'Delete TipoConsulta','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idtipoConsulta),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage TipoConsulta','url'=>array('admin')),*/
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Tipo de Consulta','url'=>array('create')),
array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Tipo de Consulta','url'=>array('update','id'=>$model->idtipoConsulta)),
array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Tipo de Consulta','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idtipoConsulta),'confirm'=>'¿Está seguro que desea eliminar el tipo de consulta?')),
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Tipos de Consulta','url'=>array('admin')),
);
?>

<h1>Ver Tipo de Consulta</h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		//'idtipoConsulta',
		'nombre',
		//'estado',
),
)); ?>
