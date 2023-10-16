<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'configprecio-form',
	'enableAjaxValidation'=>true,
)); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<?php echo $form->errorSummary($model); ?>
	<div class="row">
		<div class="col-md-3 col-md-offset-2 col-xs-12">
			<?php echo $form->textFieldGroup($model,'incrementoPrecio2',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
		</div>
		<div class="col-md-3 col-md-offset-2 col-xs-12">
			<?php echo $form->textFieldGroup($model,'incrementoPrecio3',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
		</div>
	</div>
	

	<div class="row">
		<div class="col-md-2 col-md-offset-2 col-xs-12" style="margin-top: 20px;">
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
