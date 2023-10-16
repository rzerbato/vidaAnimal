<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>


<div class="row">
	<div class="col-md-2 col-md-offset-1 col-xs-12">

		<?php

			$tipoDocumentos = array('' => 'Selec. Tipo');
			$tipoDocumentos = $tipoDocumentos + TipoDocumento::getListaTipoDocumento('nombre');

			echo $form->dropDownListGroup(
				$model,
				'tipoDocumento_idtipoDocumento',
				array(
					'widgetOptions' => array(
						'data' => $tipoDocumentos,

					)

				)
			);
		?>
	</div>

	<div class="col-md-4 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'numeroDocumento',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
</div>
</div>
<div class="row">
	<div class="col-md-7 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>80)))); ?>
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
