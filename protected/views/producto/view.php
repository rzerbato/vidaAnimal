<?php
$this->breadcrumbs=array(
	'Productos'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Producto','url'=>array('create')),
	array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Producto','url'=>array('update','id'=>$model->idproducto)),
	array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Producto','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idproducto),'confirm'=>'¿Está seguro que desea eliminar el producto?')),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Productos','url'=>array('admin')),
);
?>

<h1>Ver Producto <?php #echo $model->idproducto; ?></h1>

<?php $this->widget('booster.widgets.TbDetailView',array(
'data'=>$model,
'attributes'=>array(
		//'idproducto',
		'codigo',
		'nombre',
		//'rubro_idRubro',
		array(
        'label'=>'Rubro',
        'value'=>CHtml::encode($model->rubroIdRubro->nombre),
    ),
		//'subRubro_idSubRubro',
		array(
        'label'=>'Subrubro',
        'value'=>CHtml::encode($model->subRubroIdSubRubro->nombre),
    ),
		//'marca_idmarca',
		array(
        'label'=>'Marca',
        'value'=>CHtml::encode($model->marcaIdmarca->nombre),
    ),
		//'precioCosto',
		array(
        'label'=>'Precio Costo',
        'value'=>'$ '.CHtml::encode($model->precioCosto),
    ),
		//'precioEfectivo',
		array(
        'label'=>'Precio Efectivo',
        'value'=>'$ '.CHtml::encode($model->precioEfectivo),
    ),
		//'precio2',
		array(
        'label'=>'Precio 2',
        'value'=>'$ '.CHtml::encode($model->precio2),
    ),
		//'precio3',
		array(
        'label'=>'Precio 3',
        'value'=>'$ '.CHtml::encode($model->precio3),
    ),
		//'estado',
),
)); ?>
