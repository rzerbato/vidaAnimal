<?php
$this->breadcrumbs=array(
	'Clientes'=>array('admin'),
	'Administrar',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Cliente','url'=>array('create')),
/*array('label'=>'List Cliente','url'=>array('index')),
array('label'=>'Create Cliente','url'=>array('create')),*/
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('cliente-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Administrar Clientes</h1>

<p>
	Opcionalmente puedes utilizar operadores de comparación (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>
		&lt;&gt;</b>
		or <b>=</b>) al incio de cada campo de búsqueda para especificar cómo se debe realizar la comparación.
	</p>


<?php #echo CHtml::link('Advanced Search','#',array('class'=>'search-button btn')); ?>
<div class="search-form" >
	<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('booster.widgets.TbGridView',array(
'id'=>'cliente-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'type' => 'striped bordered condensed',
'template' => "{summary}{items}{pager}",
'columns'=>array(
		#'idcliente',
		//'tipoDocumento_idtipoDocumento',
		array (
				'name'=>'tipoDocumento_idtipoDocumento',
				'value'=>'$data->tipoDocumentoIdtipoDocumento->nombre',
				'type'=>'text',
				'htmlOptions'=>array('style'=>'width: 8%; text-align: center'),
			),
		array (
				'name'=>'numeroDocumento',
				'value'=>'$data->numeroDocumento',
				'type'=>'text',
				'htmlOptions'=>array('style'=>'width: 10%'),
			),
		//'numeroDocumento',
		'nombre',
		//'provincia_idprovincia',
		array (
				'name'=>'provincia_idprovincia',
				'value'=>'$data->provinciaIdprovincia->nombre',
				'type'=>'text',
				'htmlOptions'=>array('style'=>'width: 15%'),	
			),
		array (
				'name'=>'localidad_idlocalidad',
				'value'=>'$data->localidadIdlocalidad->nombre',
				'type'=>'text',
				'htmlOptions'=>array('style'=>'width: 15%'),	
			),
		'direccion',
		/*
		'localidad_idlocalidad',
		'telefonoFijo',
		'telefonoCelular',
		'email',
		'estado',
		*/
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
