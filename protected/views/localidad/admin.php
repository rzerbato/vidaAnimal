<?php
$this->breadcrumbs=array(
	'Localidades'=>array('admin'),
	'Administrar',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Localidad','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('localidad-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Administrar Localidades</h1>

<p>
	Opcionalmente puedes utilizar operadores de comparación (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>
		&lt;&gt;</b>
		or <b>=</b>) al incio de cada campo de búsqueda para especificar cómo se debe realizar la comparación.
	</p>

	<?php #echo CHtml::link('Advanced Search','#',array('class'=>'search-button btn')); ?>
	<div class="search-form" ">
		<?php $this->renderPartial('_search',array(
			'model'=>$model,
		)); ?>
	</div><!-- search-form -->

	<?php $this->widget('booster.widgets.TbGridView',array(
		'id'=>'localidad-grid',
		'dataProvider'=>$model->search(),
		'filter'=>$model,
		'type' => 'striped bordered condensed',
		'template' => "{summary}{items}{pager}",
		'columns'=>array(
			//'idlocalidad',
			//'codigoPostal',
			array(
				'name' =>'codigoPostal',
				'htmlOptions'=>array('style'=>'width: 15%'),
			),

			'nombre',
			//'provincia_idprovincia',
			array (
				'name'=>'provincia_idprovincia',
				'value'=>'$data->provincia->nombre',
				'type'=>'text',
				'htmlOptions'=>array('style'=>'width: 25%'),
			),

			array(
				'class'=>'booster.widgets.TbButtonColumn',
			),
		),
	)); ?>
