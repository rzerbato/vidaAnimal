<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

		<?php #echo $form->textFieldGroup($model,'idlocalidad',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
		<div class="row">
			<div class="col-md-3 col-md-offset-1 col-xs-12">
				<?php echo $form->textFieldGroup($model,'codigoPostal',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
			</div>
			<div class="col-md-6 col-md-offset-1 col-xs-12">
				<?php # echo $form->textFieldGroup($model,'provincia_idprovincia',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
				<?php
					/*$provincias = Provincia::getListaProvincias('nombre');
					array_unshift($provincias, 'Seleccionar Provincia');
					echo $form->dropDownListGroup(
						$model,
						'provincia_idprovincia',
						array(
							'widgetOptions' => array(
								'data' => $provincias,
							),
						)
					);
					*/
				?>
				<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
			</div>
		</div>
	<!--	<div class="row">
			<div class="col-md-9 col-md-offset-1 col-xs-12">
				<?php # echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
			</div>
		</div> -->
		<div class="row">
			<div class="col-md-9 col-md-offset-1 col-xs-12">
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
