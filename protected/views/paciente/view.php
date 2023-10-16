<?php
$this->breadcrumbs=array(
	'Pacientes'=>array('admin'),
	$model->nombre,
);

$this->menu=array(
/*array('label'=>'List Paciente','url'=>array('index')),
array('label'=>'Create Paciente','url'=>array('create')),
array('label'=>'Update Paciente','url'=>array('update','id'=>$model->idpaciente)),
array('label'=>'Delete Paciente','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idpaciente),'confirm'=>'Are you sure you want to delete this item?')),
array('label'=>'Manage Paciente','url'=>array('admin')),*/
array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Paciente','url'=>array('create')),
array('label'=>'<i class="fa fa-pencil fa-fw"></i> Actualizar Paciente','url'=>array('update','id'=>$model->idpaciente)),
array('label'=>'<i class="fa fa-trash fa-fw"></i> Eliminar Paciente','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->idpaciente),'confirm'=>'¿Está seguro que desea eliminar el Paciente?')),
array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Pacientes','url'=>array('admin')),
array('label'=>'<i class="fa fa fa-check-square-o"></i> Nueva Consulta','url' => array('consulta/create','idPaciente'=>$model->idpaciente)),
array('label'=>'<i class="fa fa fa-print"></i> Imprimir Historia Clinica','url' => array('imprimirHistoria','idPaciente'=>$model->idpaciente)),);

?>

<h1>Ver Paciente<?php #echo $model->idpaciente; ?></h1>


<div class="row">
	<div class="col-md-4 col-xs-12">
		<?php				
			$newDate = date("d/m/Y", strtotime( $model->fechaNacimiento));
			//$model->fechaNacimiento = $newDate;				
			$this->widget('booster.widgets.TbDetailView',array(
			'data'=>$model,
			'attributes'=>array(
				//'idpaciente',
				//'cliente_idcliente',
				array(
						'label'=>'Cliente',
						'value'=>CHtml::encode($model->clienteIdcliente->nombre),
				),
				'nombre',
				//'pacientecol',
				//'especie_idespecie',
				array(
						'label'=>'Especie',
						'value'=>CHtml::encode($model->especieIdespecie->nombre),
				),
				//'raza_idraza',
				array(
						'label'=>'Raza',
						'value'=>CHtml::encode($model->razaIdraza->nombre),
				),
				
			),
			)); 
		?>
	</div>
	<div class="col-md-4 col-xs-12">
		<?php
		$this->widget('booster.widgets.TbDetailView',array(
			'data'=>$model,
			'attributes'=>array(
				'sexo',
				//'fechaNacimiento',
				array(
						'label'=>'Fecha de Nacimiento',
						'value'=>CHtml::encode($newDate),
				),
				'observacion',
				//'señaParticular',
				array(
						'label'=>'Seña Particular',
						'value'=>CHtml::encode($model->señaParticular),
				),
				
			),
			)); 
		?>
	</div>
	<div class="col-md-4 col-xs-12">
		<?php
		$this->widget('booster.widgets.TbDetailView',array(
			'data'=>$model,
			'attributes'=>array(
				//'foto',	
				array( 	 
					'label'=>'Foto',
					'type'=>'raw',
					'value'=>html_entity_decode(CHtml::image(Yii::app()->baseUrl."/images/".$model->foto,'Foto',array('width'=>241,'height'=>132))),	 
				),
				//'estado',
			),
			)); 
		?>
</div>

<div class="row">
	<div class="col-md-12 col-xs-12">
		<?php $this->widget('booster.widgets.TbGridView',array(
			'id'=>'consulta-grid',
			'dataProvider'=>$modelConsulta->search(),
			'filter'=>$modelConsulta,
			'type' => 'striped bordered condensed',
			'template' => "{summary}{items}{pager}",
			'columns'=>array(
				array(
					'header' => '',
					'type'=>'raw',
					'value' => function($data){
						
						if(DiagnosticoComplementario::tieneDiagnosticoComplementario($data->idconsulta)){
							return '<center><i class="fa fa fa-paperclip"></i></center>';
						} else {
							return "";
						} 						
					}		   
				),
				//'idconsulta',
				//'fecha',
				array(
					'name'=>'fecha',
					'value' => 'date("d/m/Y", strtotime($data->fecha))',
					'htmlOptions'=>array('style'=>'width: 10%; text-align:center;')
				),
				//'cliente_idcliente',
				//'paciente_idpaciente',
				//'tipoConsulta_idtipoConsulta',
				array (
					'name'=>'tipoConsulta_idtipoConsulta',
					'value'=>'$data->tipoConsultaIdtipoConsulta->nombre',
					'htmlOptions'=>array('style'=>'width: 30%')
					
				),
				'motivo',
								
				
				
				/*
				'estado',
				*/
				array(
					'class'=>'booster.widgets.TbButtonColumn',
        			'updateButtonUrl'=>'Yii::app()->createUrl("/consulta/update/$data->idconsulta" )', // url de la acción 'update'
					'viewButtonUrl'=>'Yii::app()->createUrl("/consulta/view/$data->idconsulta" )', // url de la acción 'delete'
					'deleteButtonUrl'=>'Yii::app()->createUrl("/consulta/delete/$data->idconsulta" )', // url de la acción 'delete'
					'htmlOptions'=>array('style'=>'width: 7%'),
					),
				),
			)); 
		?>
	</div>
</div>

