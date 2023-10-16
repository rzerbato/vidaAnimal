<?php
$this->breadcrumbs=array(
	'Pacientes'=>array('admin'),
	'Administrar',
);

$this->menu=array(
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Paciente','url'=>array('create')),
/*
array('label'=>'List Paciente','url'=>array('index')),
array('label'=>'Create Paciente','url'=>array('create')),
*/
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
$('.search-form').toggle();
return false;
});
$('.search-form form').submit(function(){
$.fn.yiiGridView.update('paciente-grid', {
data: $(this).serialize()
});
return false;
});
");
?>

<h1>Administrar Pacientes</h1>

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
'id'=>'paciente-grid',
'dataProvider'=>$model->search(),
'filter'=>$model,
'type' => 'striped bordered condensed',
'template' => "{summary}{items}{pager}",
'columns'=>array(
		//'idpaciente',

		//'cliente_idcliente',
		array (
			'name'=>'cliente_idcliente',
			'value'=>'$data->clienteIdcliente->nombre',
			'type'=>'text',
		),
		'nombre',
		//'pacientecol',
		//'especie_idespecie',
		array (
			'name'=>'especie_idespecie',
			'value'=>'$data->especieIdespecie->nombre',
			'type'=>'text',
			
		),
		//'raza_idraza',
		array (
			'name'=>'raza_idraza',
			'value'=>'$data->razaIdraza->nombre',
			'type'=>'text',
		),
		
		'sexo',
		array(
			'name'=>'señaParticular',
    		'value' => '$data->señaParticular',
		),
		/*array(
			'name'=>'fechaNacimiento',
    		'value' => 'date("d/m/Y", strtotime($data->fechaNacimiento))'
		),
		'observacion',
		'señaParticular',
		'foto',
		'estado',
		*/
array(
'class'=>'booster.widgets.TbButtonColumn',
'htmlOptions'=>array('style'=>'width: 7%'),
),
),
)); ?>
