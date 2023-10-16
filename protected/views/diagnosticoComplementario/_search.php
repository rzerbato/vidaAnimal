<?php
/* @var $this DiagnosticocomplementarioController */
/* @var $model Diagnosticocomplementario */
/* @var $form CActiveForm */
?>

<div class="wide form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model,'iddiagnosticoComplementario'); ?>
		<?php echo $form->textField($model,'iddiagnosticoComplementario'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'consulta_idconsulta'); ?>
		<?php echo $form->textField($model,'consulta_idconsulta'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'descripcion'); ?>
		<?php echo $form->textField($model,'descripcion',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'archivo'); ?>
		<?php echo $form->textField($model,'archivo'); ?>
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