<?php
$this->breadcrumbs=array(
	'Marcas'=>array('admin'),
	'Administrar',
);

$this->menu=array(
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Marca','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('marca-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Administrar Marcas</h1>

<p>
	Opcionalmente puedes utilizar operadores de comparación (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>
		&lt;&gt;</b>
		or <b>=</b>) al incio de cada campo de búsqueda para especificar cómo se debe realizar la comparación.
	</p>


<div class="search-form" >
	<?php $this->renderPartial('_search',array(
	'model'=>$model, 'modelRubro'=>$modelRubro,
)); ?>
</div><!-- search-form -->

<?php $this->widget('booster.widgets.TbGridView',array(
'id'=>'marca-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'type' => 'striped bordered condensed',
'template' => "{summary}{items}{pager}",
'columns'=>array(
		//'idmarca',
		///'rubro_idRubro',
		array (
			'name'=>'rubro_idRubro',
			'value'=>'$data->rubroIdRubro->nombre',
			'type'=>'text',
			'htmlOptions'=>array('style'=>'width: 40%'),
		),
		'nombre',
		//'estado',
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
