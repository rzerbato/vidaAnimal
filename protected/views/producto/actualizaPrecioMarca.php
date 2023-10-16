<?php
$this->breadcrumbs=array(
	'Productos'=>array('admin'),
	'Actualizar Precios por Marca',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Productos','url'=>array('admin')),
);
?>

<h1>Actualizar Precios por Marca</h1>

<div class="row">
	<div class="col-md-11 col-md-offset-1 col-xs-12" style="padding-top: 25px;">
		<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>
	</div>
</div>
<div class="tab-content clearfix" style="padding-top: 25px;">
	<div class="tab-pane active fade in active" id="1b">
		<?php
			$form = $this->beginWidget(
				'booster.widgets.TbActiveForm',
				array(
					'id' => 'ActualizaPreciosMarca',
					'enableClientValidation'=>true,
				)
			);
		?>
		<div class="row">
			<div class="col-md-10 col-md-offset-1 col-xs-12">
				<?php echo $form->errorSummary($model); ?>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3 col-md-offset-3 col-xs-12">
				<?php
				$marcas = array('' => 'Seleccionar Marca');
				$marcas = $marcas + $listaMarcas;
				
				echo $form->dropDownListGroup(
					$model,
					'marca_idmarca',
					array(
						'widgetOptions' => array(
							'data' => $marcas,
						)
					)
				);
				?>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3 col-md-offset-3 col-xs-12">
				<?php echo $form->textFieldGroup($model,'porcIncremento',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>20)))); ?>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3 col-md-offset-3 col-xs-12">
				<?php
				$modos = array('' => 'Seleccionar Modo');
				$modos = $modos + array('0' => 'Modo Prueba');
				$modos = $modos + array('1' => 'Modo Final');
				echo $form->dropDownListGroup(
					$model,
					'modo',
					array(
						'widgetOptions' => array(
							'data' => $modos,
						)
					)
				);
				?>

			</div>
		</div>

		<div class="row">
			<div class="col-md-2 col-md-offset-3 col-xs-12">
				<div class="form-actions">
					<?php $this->widget('booster.widgets.TbButton', array(
						'buttonType'=>'submit',
						'context'=>'primary',
						'label'=>'Actualizar',
					)); ?>
				</div>
			</div>
			<?php
				$this->endWidget();

			?>
		</div>
	</div>
</div>
