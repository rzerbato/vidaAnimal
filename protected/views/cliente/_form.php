<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'cliente-form',
	'enableAjaxValidation'=>true,
)); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<?php echo $form->errorSummary($model); ?>
<div class="row">
	<div class="col-md-2 col-md-offset-1 col-xs-12">

		<?php
		#echo $form->textFieldGroup($model,'tipoDocumento_idtipoDocumento',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
			$tipoDocumentos = array(0 => 'Selec. Tipo');
			$tipoDocumentos = $tipoDocumentos + TipoDocumento::getListaTipoDocumento('idtipoDocumento');

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
	<div class="col-md-3 col-md-offset-1 col-xs-12">
	<?php #echo $form->textFieldGroup($model,'provincia_idprovincia',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
	$provincias = array(0 => 'Seleccionar Provincia');
	$provincias = $provincias + Provincia::getListaProvincias('idprovincia');

	echo $form->dropDownListGroup(
		$model,
		'provincia_idprovincia',
		array(
			'widgetOptions' => array(
				'data' => $provincias,
				'htmlOptions'=>array(
					'ajax' => array(
					    'type' => 'POST',
					    'url' => CController::createUrl('localidad/listadodinamico'), // Controlador que devuelve las localidades relacionadas
					    'update' => '#Cliente_localidad_idlocalidad', // id del item que se actualizará
							#'update' => '#localidad_idlocalidad', // id del item que se actualizará
		      )
				),
			)
		)
	);
	?>
	</div>
<div class="col-md-3 col-md-offset-1 col-xs-12">
	<?php #echo $form->textFieldGroup($model,'localidad_idlocalidad',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
		$localidades = array(0 => 'Seleccionar Localidad');
		echo $form->dropDownListGroup(
			$model,
			'localidad_idlocalidad',
			array(
				'widgetOptions' => array(
					'data' => $localidades,
				)

			)
		);
	?>
</div>
</div>
<div class="row">
	<div class="col-md-7 col-md-offset-1 col-xs-12">
	<?php echo $form->textFieldGroup($model,'direccion',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50)))); ?>
</div>
</div>
<div class="row">
	<div class="col-md-3 col-md-offset-1 col-xs-12">
	<?php echo $form->textFieldGroup($model,'telefonoFijo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>15)))); ?>
	</div>
<div class="col-md-3 col-md-offset-1 col-xs-12">
	<?php echo $form->textFieldGroup($model,'telefonoCelular',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>15)))); ?>
</div>
</div>
<div class="row">
	<div class="col-md-7 col-md-offset-1 col-xs-12">
	<?php echo $form->textFieldGroup($model,'email',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>50)))); ?>
</div>
</div>
	<?php # echo $form->textFieldGroup($model,'estado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	<div class="row">
		<div class="col-md-7 col-md-offset-1 col-xs-12">
			<input type="text" id="idLocalidad" value="<?php echo $idLocalidad ?>" style="display: none">
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

<script type="text/javascript">
    window.addEventListener('load', init);
		function init()
		{
				var id_seleccionado = $('#Cliente_provincia_idprovincia').val();
				if (id_seleccionado > 0){
	        $.ajax({
	                data: 'idprovincia='+id_seleccionado,
	                url: <?php echo "'".CHtml::normalizeUrl(array('localidad/buscarLocalidades'))."'"; ?>,
	                dataType: 'JSON',
	                type: 'POST',
	                async: true,
	                beforeSend: function(){
	                        $.blockUI({ message: '<h1><img src="../../images/busy.gif" /></h1>' ,
	                        css: { backgroundColor: 'transparent', border: 0} });
	                },
	                complete: function(){
	                        $.unblockUI();
	                },
	                error: function(objeto, quepaso, otroobj){
	                        alert("Estas viendo esto por que fallé");
	                        alert("Pasó lo siguiente: "+ quepaso + " " + otroobj);
	                },
	                success: function(response){
										//Acá debería de armar el combo
										var idLocalidadSeleccionada = $("#idLocalidad").val();
										console.log($("#idLocalidad").val());
										var select = $("#Cliente_localidad_idlocalidad");
										select.empty();
										var option = $('<option value="0">Seleccionar Localidad</option>');
										option.appendTo(select);
										$.each(response, function(i,item){
											if (response[i].idlocalidad == idLocalidadSeleccionada){
													option = $('<option value="'+ response[i].idlocalidad + '" selected>' + response[i].nombre + '</option>');
											}else {
													option = $('<option value="'+ response[i].idlocalidad + '">' + response[i].nombre + '</option>');
											}
											option.appendTo(select);
										})
	                }
	        });
				}
		}

</script>
