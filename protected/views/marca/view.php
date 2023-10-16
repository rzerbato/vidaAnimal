<?php
$this->breadcrumbs=array(
	'Marcas'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
/*array('label'=>'List Marca','url'=>array('index')),
array('label'=>'Create Marca','url'=>array('create')),
array('label'=>'Update Marca','url'=>array('update','id'=>$model->idmarca)),
array('label'=>'Delete Marca','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idmarca),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Marca','url'=>array('admin')),*/
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Marca','url'=>array('create')),
array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Marca','url'=>array('update','id'=>$model->idmarca)),
array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Marca','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idmarca),'confirm'=>'¿Está seguro que desea eliminar la marca?')),
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Marcas','url'=>array('admin')),
);
?>

<h1>Ver Marca <?php #echo $model->idmarca; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		//'idmarca',
		//'rubro_idRubro',
		array(
        'label'=>'Rubro',
        'value'=>CHtml::encode($model->rubroIdRubro->nombre),
    ),
		'nombre',
		//'estado',
),
)); ?>
