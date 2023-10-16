<?php
$this->breadcrumbs=array(
	'Productos'=>array('admin'),
	'Administrar',
);

$this->menu=array(
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Producto','url'=>array('create')),
array('label'=>'<i class="fa fa-print fa-fw"></i> Imprimir Lista de Precios','url'=>array('print')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('producto-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Administrar Productos</h1>

<p>
	Opcionalmente puedes utilizar operadores de comparación (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>
		&lt;&gt;</b>
		or <b>=</b>) al incio de cada campo de búsqueda para especificar cómo se debe realizar la comparación.
	</p>


<div class="search-form" >
	<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('booster.widgets.TbGridView',array(
'id'=>'producto-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'type' => 'striped bordered condensed',
'template' => "{summary}{items}{pager}",
'columns'=>array(
		//'idproducto',
		array(
				'name'=>'codigo',
				'htmlOptions'=>array('width'=>'10%')
		),
		'nombre',
		//'rubro_idRubro',
		array (
				'name'=>'rubro_idRubro',
				'value'=>'$data->rubroIdRubro->nombre',
				'type'=>'text',
			),
		//'subRubro_idSubRubro',
		array (
				'name'=>'subRubro_idSubRubro',
				'value'=>'$data->subRubroIdSubRubro->nombre',
				'type'=>'text',
			),
		//'marca_idmarca',
		array (
				'name'=>'marca_idmarca',
				'value'=>'$data->marcaIdmarca->nombre',
				'type'=>'text',
			),
		//'precioCosto',
		
		array(
				'name'=>'precioEfectivo',
				'htmlOptions'=>array('width'=>'10%')
		),
		array(
				'name'=>'precio2',
				'htmlOptions'=>array('width'=>'6%')
		),
		array(
				'name'=>'precio3',
				'htmlOptions'=>array('width'=>'6%')
		),
		array(
			'name'=>'precioCosto',
			'htmlOptions'=>array('width'=>'8%')
		),	
		/*
		'estado',
		*/
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
