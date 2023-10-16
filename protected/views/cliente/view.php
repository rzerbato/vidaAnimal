<?php
$this->breadcrumbs=array(
	'Clientes'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
/*array('label'=>'List Cliente','url'=>array('index')),
array('label'=>'Create Cliente','url'=>array('create')),
array('label'=>'Update Cliente','url'=>array('update','id'=>$model->idcliente)),
array('label'=>'Delete Cliente','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idcliente),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Cliente','url'=>array('admin')),*/
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Cliente','url'=>array('create')),
array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Cliente','url'=>array('update','id'=>$model->idcliente)),
array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Cliente','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idcliente),'confirm'=>'¿Está seguro que desea eliminar el cliente?')),
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Clientes','url'=>array('admin')),
);
?>

<h1>Ver Cliente<?php #echo $model->idcliente; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		//'idcliente',
		//'tipoDocumento_idtipoDocumento',
		array(
        'label'=>'Tipo Doc.',
        'value'=>CHtml::encode($model->tipoDocumentoIdtipoDocumento->nombre),
    ),
		'numeroDocumento',
		'nombre',
		'direccion',
		//'localidad_idlocalidad',
		array(
        'label'=>'Localidad',
        'value'=>CHtml::encode($model->localidadIdlocalidad->nombre),
    ),
		//'provincia_idprovincia',
		array(
        'label'=>'Provincia',
        'value'=>CHtml::encode($model->provinciaIdprovincia->nombre),
    ),
		'telefonoFijo',
		'telefonoCelular',
		'email',
		//'estado',
),
)); ?>
