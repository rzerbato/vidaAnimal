<?php
$this->breadcrumbs=array(
	'Razas'=>array('admin'),
	'Administrar',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Raza','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('raza-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Administrar Razas</h1>

<p>
	Opcionalmente puedes utilizar operadores de comparación (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>
		&lt;&gt;</b>
		or <b>=</b>) al incio de cada campo de búsqueda para especificar cómo se debe realizar la comparación.
	</p>

<?php # echo CHtml::link('Advanced Search','#',array('class'=>'search-button btn')); ?>
<div class="search-form">
	<?php $this->renderPartial('_search',array(
	'model'=>$model,'modeloEspecie'=>$modeloEspecie
)); ?>
</div><!-- search-form -->

<?php $this->widget('booster.widgets.TbGridView',array(
'id'=>'raza-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'type' => 'striped bordered condensed',
'template' => "{summary}{items}{pager}",
'columns'=>array(
		//'idraza',
		//'especie_idespecie',
		array (
				'name'=>'especie_idespecie',
				'value'=>'$data->especie->nombre',
				'type'=>'text',
			),
		'nombre',
		# 'estado',
array(
'class'=>'booster.widgets.TbButtonColumn',
),
),
)); ?>

<script>
/*$(document).ready(function(){
    var elDiv = document.querySelector('.keys');
    elDiv.setAttribute('title', '/veterinaria/index.php/especie/admin');	
});*/

</script>