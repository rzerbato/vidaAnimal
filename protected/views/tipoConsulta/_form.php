<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'tipo-consulta-form',
	'enableAjaxValidation'=>true,
)); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<?php echo $form->errorSummary($model); ?>

	<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>

	<?php #echo $form->textFieldGroup($model,'estado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<div class="form-actions">
	<?php $this->widget('booster.widgets.TbButton', array(
			'buttonType'=>'submit',
			'context'=>'primary',
			'label'=>$model->isNewRecord ? 'Crear' : 'Actualizar',
		)); ?>
</div>

<?php $this->endWidget(); ?>
