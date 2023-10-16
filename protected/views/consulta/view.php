<?php
/* @var $this ConsultaController */
/* @var $model Consulta */
$newDate = date("d/m/Y", strtotime( $model->fecha));
$this->breadcrumbs=array(
	'Consultas'=>array('paciente/view', 'id'=>$model->paciente_idpaciente),
	$newDate,
);

$this->menu=array(
	/*array('label'=>'List Consulta', 'url'=>array('index')),
	array('label'=>'Create Consulta', 'url'=>array('create')),
	array('label'=>'Update Consulta', 'url'=>array('update', 'id'=>$model->idconsulta)),
	array('label'=>'Delete Consulta', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->idconsulta),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Consulta', 'url'=>array('admin')),*/
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Consulta','url'=>array('create')),
	array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Consulta','url'=>array('update','id'=>$model->idconsulta)),
	//array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Consulta','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idconsulta),'confirm'=>'¿Está seguro que desea eliminar la Consulta?')),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Consultas','url'=>array('paciente/view', 'id'=>$model->paciente_idpaciente)),
	//array('label'=>'<i class="fa fa fa-check-square-o"></i> Nueva Consulta','url' => array('consulta/create','idPaciente'=>$model->idpaciente)),);
);
?>

<h1>Ver Consulta </h1>
<div class="row">
	<div class="col-md-5 col-xs-12">
		<?php $this->widget('zii.widgets.CDetailView', array(
			'data'=>$model,
			'attributes'=>array(
				//'idconsulta',
				//'fecha',
				array(
						'label'=>'Fecha',
						'value'=>CHtml::encode($newDate),
				),
				//'',
				array(
						'label'=>'Cliente',
						'value'=>CHtml::encode($model->clienteIdcliente->nombre),
				),
				//'paciente_idpaciente',
				array(
						'label'=>'Paciente',
						'value'=>CHtml::encode($model->pacienteIdpaciente->nombre),
				),
				//'tipoConsulta_idtipoConsulta',
				//'motivo',
				//'estado',
			),
		)); ?>
	</div>
	<div class="col-md-5 col-xs-12">
		<?php $this->widget('zii.widgets.CDetailView', array(
			'data'=>$model,
			'attributes'=>array(
				//'idconsulta',
				//'fecha',
				//'cliente_idcliente',
				//'paciente_idpaciente',
				//'tipoConsulta_idtipoConsulta',
				array(
						'label'=>'Tipo Consulta',
						'value'=>CHtml::encode($model->tipoConsultaIdtipoConsulta->nombre),
				),
				'motivo',
				//'estado',
			),
		)); ?>
	</div>
</div>

<?php $this->widget('booster.widgets.TbGridView',array(
'id'=>'diagnostico-grid',
'dataProvider'=>$modelDiagnostico->search($model->idconsulta),
'filter'=>$modelDiagnostico,
'type' => 'striped bordered condensed',
'template' => "{summary}{items}{pager}",
	'columns'=>array(
		//'iddiagnosticoComplementario',
		//'consulta_idconsulta',
		'descripcion',
		//'archivo',
		//'estado',
		array(
			'class'=>'booster.widgets.TbButtonColumn',
			'template'=>'{view}', // botones a mostrar
			'viewButtonUrl'=>'Yii::app()->createUrl("/diagnosticoComplementario/view/$data->iddiagnosticoComplementario?vieneDe=view" )', // url de la acción 'view'
		),
	),
)); ?>
