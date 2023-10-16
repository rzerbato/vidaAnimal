<?php
$this->breadcrumbs=array(
	'Rubros'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
/*array('label'=>'List Rubro','url'=>array('index')),
array('label'=>'Create Rubro','url'=>array('create')),
array('label'=>'Update Rubro','url'=>array('update','id'=>$model->idRubro)),
array('label'=>'Delete Rubro','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idRubro),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Rubro','url'=>array('admin')),*/
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Rubro','url'=>array('create')),
array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Rubro','url'=>array('update','id'=>$model->idRubro)),
array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Rubro','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idRubro),'confirm'=>'¿Está seguro que desea eliminar la Rubro?')),
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Rubros','url'=>array('admin')),
);
?>

<h1>Ver Rubro <?php #echo $model->idRubro; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		#'idRubro',
		'nombre',
		#'estado',
),
)); ?>
