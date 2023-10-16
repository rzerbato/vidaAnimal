<?php
/* @var $this ConsultaController */
/* @var $model Consulta */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'paciente-form',
	'enableAjaxValidation'=>false,
	'htmlOptions'=>array('enctype'=>'multipart/form-data'),
)); ?>

	<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

	<?php echo $form->errorSummary($model); ?>
	<ul class="nav nav-tabs" role="tablist">
		<li role="presentation" class="active"><a href="#consulta" aria-controls="consulta" role="tab" data-toggle="tab">Consulta</a></li>
		<li role="presentation"><a href="#diagnosticoComplementario" aria-controls="diagnosticoComplementario" role="tab" data-toggle="tab">Diag. Complementario</a></li>
	</ul>
	<div class="tab-content">
  		<div role="tabpanel" class="tab-pane fade in active" id="consulta" style ="padding-top: 3%;">
			<div class="row">
				<div class="col-md-5 col-md-offset-1 col-xs-12">
					<?php #echo $form->labelEx($model,'cliente_idcliente'); ?>
					<label class="control-label" for="cliente_idcliente">Cliente</label>
					<?php #echo $form->textField($model,'cliente_idcliente'); ?>
					<div class="form-group input-group">
						<input name="Consulta[cliente_idcliente]" id="Consulta_cliente_idcliente" <?php echo 'value = "'.$model->cliente_idcliente.'"'; ?> type="text" style="display: none" >
						<?php echo $form->textField($clienteModel,'nombre',array('disabled'=>'disabled')); ?>
					</div>
					<?php #echo $form->error($model,'cliente_idcliente'); ?>
				</div>
				<div class="col-md-3 col-md-offset-1 col-xs-12">
					<?php #echo $form->labelEx($model,'fecha'); ?>
					<?php #echo $form->textField($model,'fecha'); ?>
					<?php #echo $form->error($model,'fecha'); ?>
					<?php
					echo $form->datePickerGroup(
						$model,
						'fecha',
						array('widgetOptions'=>array(
							'options'=>array(
								'autoclose' => true,
								'todayHighlight' => true,
								'format' => 'dd/mm/yyyy',
							),
							'htmlOptions'=>array('class'=>'span5')),
							'prepend'=>'<i class="glyphicon glyphicon-calendar"></i>'
						));



						?>
				</div>
			</div>

			<div class="row">
				<div class="col-md-5 col-md-offset-1 col-xs-12">
					<label class="control-label" for="paciente_idpaciente">Paciente</label>
					<?php #echo $form->labelEx($model,'paciente_idpaciente'); ?>
					<?php #echo $form->textField($model,'paciente_idpaciente'); ?>
					<input name="Consulta[irDiagnosticoComplementario]" id="Consulta_irDiagnosticoComplementario" <?php echo 'value = "'.$model->irDiagnosticoComplementario.'"'; ?> type="text" style="display: none" type="text">
					<div class="form-group input-group">
						<input name="Consulta[paciente_idpaciente]" id="Consulta_paciente_idpaciente" <?php echo 'value = "'.$model->paciente_idpaciente.'"'; ?> type="text" style="display: none" type="text">
						<?php echo $form->textField($pacienteModel,'nombre',array('disabled'=>'disabled')); ?>
					</div>
					<?php echo $form->error($model,'paciente_idpaciente'); ?>
				</div>
				<div class="col-md-4 col-md-offset-1 col-xs-12">
					<?php #echo $form->labelEx($model,'tipoConsulta_idtipoConsulta'); ?>
					<?php #echo $form->textField($model,'tipoConsulta_idtipoConsulta'); ?>
					<?php #echo $form->error($model,'tipoConsulta_idtipoConsulta'); ?>
					<?php
						$tipoConsulta = array('' => 'Seleccionar Tipo Consulta');
						$tipoConsulta = $tipoConsulta + TipoConsulta::getListaTipoConsulta('idtipoConsulta');
						echo $form->dropDownListGroup(
							$model,
							'tipoConsulta_idtipoConsulta',
							array(
								'widgetOptions' => array(
									'data' => $tipoConsulta,
								)
							)
						);

					?>
				</div>
			</div>

			<div class="row">
				<div class="col-md-10 col-md-offset-1 col-xs-12">
					<?php echo $form->textAreaGroup(
						$model,
						'motivo',
						array(
							'wrapperHtmlOptions' => array(
								'class' => 'col-sm-5',
							),
							'widgetOptions' => array(
								'htmlOptions' => array(
									'rows' => 6),
								)
							)
						); ?>
				</div>
			</div>

			<div class="row">
				<?php #echo $form->labelEx($model,'estado'); ?>
				<?php #echo $form->textField($model,'estado'); ?>
				<?php #echo $form->error($model,'estado'); ?>
			</div>

			<div class="row buttons">
				<?php #echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
			</div>
			<div class="row">
				<div class="col-md-7 col-md-offset-1 col-xs-6">
					<div class="form-actions">
						<?php $this->widget('booster.widgets.TbButton', array(
							'buttonType'=>'submit',
							'context'=>'primary',
							'label'=>$model->isNewRecord ? 'Crear' : 'Actualizar',
						)); ?>
					</div>
				</div>
				<div class="col-md-2 col-xs-6">
					<button type="button" class="btn btn-success" onclick = "diagnosticoComplementario()"><i class="fa fa-plus fa-fw"></i> Diagnóstico Complementario</button>
					</div>
			</div>
		</div>
		<div role="tabpanel" class="tab-pane fade" id="diagnosticoComplementario">
			<?php
			$idConsulta = 0;
			if (isset($model->idconsulta)){
				$idConsulta = $model->idconsulta;
			}
			$this->widget('booster.widgets.TbGridView',array(
					'id'=>'diagnostico-complementario-grid',
					'dataProvider'=>$modelDiagnosticoComplementario->search($idConsulta),
					'filter'=>$modelDiagnosticoComplementario,
					'columns'=>array(
							//'iddiagnosticoComplementario',
							//'consulta_idconsulta',
							'descripcion',
							//'archivo',
							//'estado',
							array(
								'class'=>'booster.widgets.TbButtonColumn',
								'template'=>'{view}{delete}', // botones a mostrar
								'deleteButtonUrl'=>'Yii::app()->createUrl("/diagnosticoComplementario/delete/$data->iddiagnosticoComplementario" )', // url de la acción 'delete'
								'viewButtonUrl'=>'Yii::app()->createUrl("/diagnosticoComplementario/view/$data->iddiagnosticoComplementario?vieneDe=update" )', // url de la acción 'view'
							),
						),
				));
			?>
		</div>
	</div>

<?php $this->endWidget();?>

</div><!-- form -->

<script>

function diagnosticoComplementario(){
	$("#Consulta_irDiagnosticoComplementario").val(true);
	$( "form" ).submit();
}
</script>
