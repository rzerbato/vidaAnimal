<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

		<?php #echo $form->textFieldGroup($model,'idpaciente',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
<div class="row">
	<div class="col-md-4 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'cliente_idcliente',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	</div>
	<div class="col-md-4 col-md-offset-2 col-xs-12">
		<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
	</div>
</div>
<div class="row">
	<div class="col-md-2 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'especie_idespecie',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	</div>
	<div class="col-md-2 col-md-offset-2 col-xs-12">

		<?php echo $form->textFieldGroup($model,'sexo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>9)))); ?>
	</div>
<div class="col-md-3 col-md-offset-1 col-xs-12">
		<?php #echo $form->datePickerGroup($model,'fechaNacimiento',array('widgetOptions'=>array('options'=>array('autoclose' => true, 'todayHighlight' => true,'format' => 'dd/mm/yyyy',),'htmlOptions'=>array('class'=>'span5')), 'prepend'=>'<i class="glyphicon glyphicon-calendar"></i>')); ?>
		<?php echo $form->textFieldGroup($model,'señaParticular',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>100)))); ?>
</div>
</div>
		<?php #echo $form->textAreaGroup($model,'observacion', array('widgetOptions'=>array('htmlOptions'=>array('rows'=>6, 'cols'=>50, 'class'=>'span8')))); ?>

		<?php #echo $form->textFieldGroup($model,'señaParticular',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>100)))); ?>

		<?php #echo $form->textFieldGroup($model,'foto',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<?php #echo $form->textFieldGroup($model,'estado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
		<div class="row">
			<div class="col-md-5 col-md-offset-1 col-xs-12">
	<div class="form-actions">
		<?php $this->widget('booster.widgets.TbButton', array(
			'buttonType' => 'submit',
			'context'=>'primary',
			'label'=>'Buscar',
		)); ?>
	</div>
	</div>
</div>
<?php $this->endWidget(); ?>
