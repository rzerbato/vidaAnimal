<?php
$this->breadcrumbs=array(
	'Tipos de Consultas'=>array('admin'),
	'Administrar',
);

$this->menu=array(
//array('label'=>'List TipoConsulta','url'=>array('index')),
//array('label'=>'Create TipoConsulta','url'=>array('create')),
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Tipo Consulta','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('tipo-consulta-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Administrar Tipo Consultas</h1>

<p>
	Opcionalmente puedes utilizar operadores de comparación (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>
		&lt;&gt;</b>
		or <b>=</b>) al incio de cada campo de búsqueda para especificar cómo se debe realizar la comparación.
	</p>

<?php #echo CHtml::link('Advanced Search','#',array('class'=>'search-button btn')); ?>
<div class="search-form">
	<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('booster.widgets.TbGridView',array(
'id'=>'tipo-consulta-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'type' => 'striped bordered condensed',
'template' => "{summary}{items}{pager}",
'columns'=>array(
		//'idtipoConsulta',
		'nombre',
		//'estado',
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>
