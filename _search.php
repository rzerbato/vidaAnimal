<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

<div class="row">
	<div class="col-md-2 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'codigo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>20)))); ?>
	</div>
	<div class="col-md-3 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
	</div>
	<div class="col-md-3 col-md-offset-1 col-xs-12">
		<?php #echo $form->textFieldGroup($model,'rubro_idRubro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
			$rubros = array('' => 'Seleccionar Rubro');
			$rubros = $rubros + Rubro::getListadoRubros('nombre');

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
