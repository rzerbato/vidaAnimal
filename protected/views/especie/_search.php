<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

		<?php #echo $form->textFieldGroup($model,'idespecie',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

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
			'buttonType' => 'submit',
			'context'=>'primary',
			'label'=>'Buscar',
		)); ?>
	</div>
</div>
</div>
<?php $this->endWidget(); ?>
