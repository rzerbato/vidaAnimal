<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'especie-form',
	'enableAjaxValidation'=>true,
)); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<?php echo $form->errorSummary($model); ?>

<div class="row">
	<div class="col-md-8 col-md-offset-1 col-xs-12">
	<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
	</div>
		</div>
	<?php #echo $form->textFieldGroup($model,'estado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	<div class="row">
		<div class="col-md-8 col-md-offset-1 col-xs-12">
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
