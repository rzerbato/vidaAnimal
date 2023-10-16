<?php
$this->breadcrumbs=array(
	'Razas'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
/*array('label'=>'List Raza','url'=>array('index')),
array('label'=>'Create Raza','url'=>array('create')),
array('label'=>'Update Raza','url'=>array('update','id'=>$model->idraza)),
array('label'=>'Delete Raza','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idraza),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Raza','url'=>array('admin')),*/
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Raza','url'=>array('create')),
array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Raza','url'=>array('update','id'=>$model->idraza)),
array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Raza','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idraza),'confirm'=>'¿Está seguro que desea eliminar la raza?')),
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Razas','url'=>array('admin')),
);
?>

<h1>Ver Raza <?php #echo $model->idraza; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		//'idraza',
		//'especie_idespecie',
		array(
        'label'=>'Especie',
        'value'=>CHtml::encode($model->especie->nombre),
    ),
		'nombre',
		//'estado',
),
)); ?>
