<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'sub-rubro-form',
	'enableAjaxValidation'=>true,
)); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<?php echo $form->errorSummary($model); ?>

<?php #echo $form->textFieldGroup($model,'rubro_idRubro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
<div class="row">
	<div class="col-md-5 col-md-offset-1 col-xs-12">
		<?php
		$rubros = array(0 => 'Seleccionar Rubro');
		$rubros = $rubros + Rubro::getListaRubros('idrubro');

		echo $form->dropDownListGroup(
			$model,
			'rubro_idRubro',
			array(
				'widgetOptions' => array(
					'data' => $rubros,
				)
			)
		);
		?>
</div>
		</div>

<div class="row">
	<div class="col-md-5 col-md-offset-1 col-xs-12">
	<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
</div>
</div>


	<?php #echo $form->textFieldGroup($model,'estado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	<div class="row">
		<div class="col-md-5 col-md-offset-1 col-xs-12">
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
