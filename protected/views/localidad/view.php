<?php
$this->breadcrumbs=array(
	'Localidades'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
//array('label'=>'List Localidad','url'=>array('index')),
//array('label'=>'Create Localidad','url'=>array('create')),
//array('label'=>'Update Localidad','url'=>array('update','id'=>$model->idlocalidad)),
//array('label'=>'Manage Localidad','url'=>array('admin')),
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Localidad','url'=>array('create')),
array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Localidad','url'=>array('update','id'=>$model->idlocalidad)),
array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Localidad','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idlocalidad),'confirm'=>'¿Está seguro que desea eliminar la localidad?')),
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Localidades','url'=>array('admin')),
);
?>

<h1>Ver Localidad</h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		//'idlocalidad',
		'codigoPostal',
		#'provincia_idprovincia',
		'nombre',
		//'provincia_idprovincia',
		array(
        'label'=>'Provincia',
        'value'=>CHtml::encode($model->provincia->nombre),
    ),
),
)); ?>
