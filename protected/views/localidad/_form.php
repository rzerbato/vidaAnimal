<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'localidad-form',
	'enableAjaxValidation'=>true,
)); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<?php echo $form->errorSummary($model); ?>
<div class="row">
	<div class="col-md-4 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'codigoPostal',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	</div>
	<div class="col-md-4 col-md-offset-1 col-xs-12">
		<?php # echo $form->textFieldGroup($model,'provincia_idprovincia',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>


		<?php
		$provincias = array(0 => 'Seleccionar Provincia');
		$provincias = $provincias + Provincia::getListaProvincias('idprovincia');

		echo $form->dropDownListGroup(
			$model,
			'provincia_idprovincia',
			array(
				'widgetOptions' => array(
					'data' => $provincias,
				)
			)
		);
		?>
	</div>
</div>
<div class="row">
	<div class="col-md-9 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
	</div>
</div>

<div class="row">
	<div class="col-md-9 col-md-offset-1 col-xs-12">
		<div class="form-actions">
			<?php $this->widget('booster.widgets.TbButton', array(
				'buttonType'=>'submit',
				'context'=>'primary',
				'label'=>$model->isNewRecord ? 'Crear' : 'Actualizar',
			)); ?>
		</div>
	</div>
</div>

<?php $this->endWidget(); ?>
