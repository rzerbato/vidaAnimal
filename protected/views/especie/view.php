<?php
$this->breadcrumbs=array(
	'Especies'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
/*array('label'=>'List Especie','url'=>array('index')),
array('label'=>'Create Especie','url'=>array('create')),
array('label'=>'Update Especie','url'=>array('update','id'=>$model->idespecie)),
array('label'=>'Delete Especie','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idespecie),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Especie','url'=>array('admin')),*/
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Especie','url'=>array('create')),
array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Especie','url'=>array('update','id'=>$model->idespecie)),
array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Especie','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idespecie),'confirm'=>'¿Está seguro que desea eliminar la especie?')),
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Especies','url'=>array('admin')),
);
?>

<h1>Ver Especie <?php # echo $model->idespecie; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		//'idespecie',
		'nombre',
		//'estado',
),
)); ?>
