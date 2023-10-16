<?php
$this->breadcrumbs=array(
	'Sub Rubros'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
/*array('label'=>'List SubRubro','url'=>array('index')),
array('label'=>'Create SubRubro','url'=>array('create')),
array('label'=>'Update SubRubro','url'=>array('update','id'=>$model->idSubRubro)),
array('label'=>'Delete SubRubro','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idSubRubro),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage SubRubro','url'=>array('admin')),*/
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Subrubro','url'=>array('create')),
array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Subrubro','url'=>array('update','id'=>$model->idSubRubro)),
array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Subrubro','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idSubRubro),'confirm'=>'¿Está seguro que desea eliminar el Subrubro?')),
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Subrubros','url'=>array('admin')),
);
?>

<h1>Ver Subrubro <?php #echo $model->idSubRubro; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		//'idSubRubro',
		array(
        'label'=>'Rubro',
        'value'=>CHtml::encode($model->rubroIdRubro->nombre),
    ),//'rubro_idRubro',
		'nombre',
		//'estado',
),
)); ?>
