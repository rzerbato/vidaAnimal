<?php
/* @var $this ConsultaController */
/* @var $model Consulta */
/* @var $form CActiveForm */
?>

<div class="wide form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model,'idconsulta'); ?>
		<?php echo $form->textField($model,'idconsulta'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'fecha'); ?>
		<?php echo $form->textField($model,'fecha'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'cliente_idcliente'); ?>
		<?php echo $form->textField($model,'cliente_idcliente'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'paciente_idpaciente'); ?>
		<?php echo $form->textField($model,'paciente_idpaciente'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'tipoConsulta_idtipoConsulta'); ?>
		<?php echo $form->textField($model,'tipoConsulta_idtipoConsulta'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'motivo'); ?>
		<?php echo $form->textArea($model,'motivo',array('rows'=>6, 'cols'=>50)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'estado'); ?>
		<?php echo $form->textField($model,'estado'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton('Search'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->