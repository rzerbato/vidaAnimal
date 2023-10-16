<?php
$this->breadcrumbs=array(
	'Productos'=>array('admin'),
	'Actualizar Precios por Subrubro',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Administrar Productos','url'=>array('admin')),
);
?>

<h1>Actualizar Precios por Subrubro</h1>


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
						'id' => 'actualizaPreciosSubRubro',
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
				<div class="col-md-3 col-md-offset-2 col-xs-12">
					<?php
					$rubros = array(0 => 'Seleccionar Rubro');
					$rubros = $rubros + Rubro::getListaRubros('id');
					echo $form->dropDownListGroup(
						$model,
						'rubro_idRubro',
						array(
							'widgetOptions' => array(
								'data' => $rubros,
								'htmlOptions'=>array(
									'ajax' => array(
									    'type' => 'POST',
									    'url' => CController::createUrl('subRubro/listadodinamico'), // Controlador que devuelve las localidades relacionadas
									    'update' => '#Producto_subRubro_idSubRubro', // id del item que se actualizará
											#'update' => '#localidad_idlocalidad', // id del item que se actualizará
						      )
								),
							)
						)
					);
					?>
				</div>
				<div class="col-md-3 col-md-offset-1 col-xs-12">
					<?php
						#echo $form->textFieldGroup($model,'subRubro_idSubRubro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
						$subrubros = array(0 => 'Seleccionar Subrubro');
						echo $form->dropDownListGroup(
							$model,
							'subRubro_idSubRubro',
							array(
								'widgetOptions' => array(
									'data' => $subrubros,
								)

							)
						);
					?>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3 col-md-offset-2 col-xs-12">
					<?php echo $form->textFieldGroup($model,'porcIncremento',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>20)))); ?>
				</div>
				<div class="col-md-3 col-md-offset-1 col-xs-12">
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
			<div class="row" style="margin-top: 3%;">
				<div class="col-md-2 col-md-offset-5 col-xs-12">
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

		<!-- SOLAPA ACTUALIZA POR SUBRUBRO -->

		<div class="tab-pane fade" id="2b">
			<?php
				$form = $this->beginWidget(
					'booster.widgets.TbActiveForm',
					array(
						'id' => 'ActualizaPrecios',
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
				<div class="col-md-3 col-md-offset-2 col-xs-12">
					<?php
						#echo $form->textFieldGroup($model,'rubro_idRubro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
						$rubros = array(0 => 'Seleccionar Rubro');
						$rubros = $rubros + Rubro::getListaRubros('idrubro');

						echo $form->dropDownListGroup(
							$model,
							'rubro_idRubro',
							array(
								'widgetOptions' => array(
									'data' => $rubros,
									'htmlOptions'=>array(
										'ajax' => array(
										    'type' => 'POST',
										    'url' => CController::createUrl('subRubro/listadodinamico'), // Controlador que devuelve las localidades relacionadas
										    'update' => '#Producto_subRubro_idSubRubro', // id del item que se actualizará
												#'update' => '#localidad_idlocalidad', // id del item que se actualizará
							      )
									),
								)
							)
						);

					?>
				</div>
				<div class="col-md-3 col-md-offset-1 col-xs-12">
					<?php
						#echo $form->textFieldGroup($model,'subRubro_idSubRubro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
						$subrubros = array(0 => 'Seleccionar Subrubro');
						echo $form->dropDownListGroup(
							$model,
							'subRubro_idSubRubro',
							array(
								'widgetOptions' => array(
									'data' => $subrubros,
								)

							)
						);
					?>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3 col-md-offset-2 col-xs-12">
					<?php echo $form->textFieldGroup($model,'porcIncremento',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>20)))); ?>
				</div>
				<div class="col-md-3 col-md-offset-1 col-xs-12">
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


			<div class="row" style="margin-top: 30px">
				<div class="col-md-2 col-md-offset-5 col-xs-12">
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

		<!-- SOLAPA ACTUALIZA POR MARCA -->

		<div class="tab-pane fade" id="3b">
			<?php
				$form = $this->beginWidget(
					'booster.widgets.TbActiveForm',
					array(
						'id' => 'ActualizaPrecios',
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
				<div class="col-md-3 col-md-offset-2 col-xs-12">
					<?php
						#echo $form->textFieldGroup($model,'rubro_idRubro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
						/*$rubros = array(0 => 'Seleccionar Rubro');
						$rubros = $rubros + Rubro::getListaRubros('idrubro');

						echo $form->dropDownListGroup(
							$model,
							'rubro_idRubro',
							array(
								'widgetOptions' => array(
									'data' => $rubros,
									'htmlOptions'=>array(
										'ajax' => array(
										    'type' => 'POST',
										    'url' => CController::createUrl('marca/listadodinamico'), // Controlador que devuelve las localidades relacionadas
										    'update' => '#Producto_marca_idmarca', // id del item que se actualizará
												#'update' => '#localidad_idlocalidad', // id del item que se actualizará
							      )
									),
								)
							)
						);
*/
					?>
				</div>
				<div class="col-md-3 col-md-offset-1 col-xs-12">
					<?php
						#echo $form->textFieldGroup($model,'subRubro_idSubRubro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
						$marca = array(0 => 'Seleccionar Marca');
						echo $form->dropDownListGroup(
							$model,
							'marca_idmarca',
							array(
								'widgetOptions' => array(
									'data' => $marca,
								)

							)
						);
					?>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3 col-md-offset-2 col-xs-12">
					<?php echo $form->textFieldGroup($model,'porcIncremento',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>20)))); ?>
				</div>
				<div class="col-md-3 col-md-offset-1 col-xs-12">
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


			<div class="row" style="margin-top: 30px">
				<div class="col-md-2 col-md-offset-5 col-xs-12">
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



		<div class="tab-pane fade" id="4b">
			<h3>Acá actualizo a mansalva</h3>
		</div>
	</div>
