<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'producto-form',
	'enableAjaxValidation'=>true,
)); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<?php echo $form->errorSummary($model); ?>

<div class="row">
	<div class="col-md-4 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'codigo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>20)))); ?>
	</div>
	<div class="col-md-6 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
	</div>
</div>
<div class="row">
	<div class="col-md-3 col-md-offset-1 col-xs-12">
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
	<div class="col-md-3 col-md-offset-1 col-xs-12">
		<?php
			#echo $form->textFieldGroup($model,'marca_idmarca',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5'))));
			$subrubros = array(0 => 'Seleccionar Marca');
			echo $form->dropDownListGroup(
				$model,
				'marca_idmarca',
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
	<div class="col-md-5 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'precioCosto',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	</div>
	<div class="col-md-5 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'precioEfectivo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	</div>
</div>
<div class="row">
	<div class="col-md-5 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'precio2',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	</div>
	<div class="col-md-5 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'precio3',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	</div>
</div>
	<?php #echo $form->textFieldGroup($model,'estado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

<div class="row">
	<div class="col-md-5 col-md-offset-1 col-xs-12">
		<input type="text" id="idSubrubro" value="<?php echo $idSubrubro ?>" style="display: none">
		<input type="text" id="idMarca" value="<?php echo $idMarca ?>" style="display: none">
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

<input id="incrementoPrecio2" type="text" value="<?php echo $precioConfig->incrementoPrecio2 ?>" style="visibility: hidden;">
<input id="incrementoPrecio3" type="text" value="<?php echo $precioConfig->incrementoPrecio3 ?>" style="visibility: hidden;">

<script type="text/javascript">

window.addEventListener('load', init);

function init()
{
		var id_seleccionado = $('#Producto_rubro_idRubro').val();
		if (id_seleccionado > 0){
			$.ajax({
							data: 'idrubro='+id_seleccionado,
							url: <?php echo "'".CHtml::normalizeUrl(array('marca/buscarMarcas'))."'"; ?>,
							dataType: 'JSON',
							type: 'POST',
							async: true,
							beforeSend: function(){
								
											
											$.blockUI({ message: '<h1><img src="../../../images/busy.gif" /></h1>' ,
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
								var select = $("#Producto_marca_idmarca");
								select.empty();
								var option = $('<option value="0">Seleccionar Marca</option>');
								option.appendTo(select);
								var idMarcaSeleccionada = $("#idMarca").val();
								$.each(response, function(i,item){
									if (response[i].idmarca == idMarcaSeleccionada){
											option = $('<option value="'+ response[i].idmarca + '" selected>' + response[i].nombre + '</option>');
									}else {
											option = $('<option value="'+ response[i].idmarca + '">' + response[i].nombre + '</option>');
									}
									option.appendTo(select);
								})
							}
			});


			$.ajax({
							data: 'idrubro='+id_seleccionado,
							url: <?php echo "'".CHtml::normalizeUrl(array('subRubro/buscarSubrubros'))."'"; ?>,
							dataType: 'JSON',
							type: 'POST',
							async: true,
							beforeSend: function(){
								
											$.blockUI({ message: '<h1><img src="../../../images/busy.gif" /></h1>' ,
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
								var select = $("#Producto_subRubro_idSubRubro");
								select.empty();
								var option = $('<option value="0">Seleccionar Subrubro</option>');
								option.appendTo(select);
								var idSubrubroSeleccionado = $("#idSubrubro").val();
								$.each(response, function(i,item){
									if (response[i].idSubRubro == idSubrubroSeleccionado){
											option = $('<option value="'+ response[i].idSubRubro + '" selected>' + response[i].nombre + '</option>');
									}else {
											option = $('<option value="'+ response[i].idSubRubro + '">' + response[i].nombre + '</option>');
									}
									option.appendTo(select);
								})
							}
			});


		}
}

	$("#Producto_rubro_idRubro").change(function(){
		var id_seleccionado = $('#Producto_rubro_idRubro').val();
		$.ajax({
						data: 'idrubro='+id_seleccionado,
						url: <?php echo "'".CHtml::normalizeUrl(array('marca/buscarMarcas'))."'"; ?>,
						dataType: 'JSON',
						type: 'POST',
						async: true,
						beforeSend: function(){
								$.blockUI({ message: '<h1><img src="../../../images/busy.gif" /></h1>' ,
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
							/*var idLocalidadSeleccionada = $("#idLocalidad").val();*/
							var select = $("#Producto_marca_idmarca");
							select.empty();
							var option = $('<option value="0">Seleccionar Marca</option>');
							option.appendTo(select);
							$.each(response, function(i,item){
								/*if (response[i].idlocalidad == idLocalidadSeleccionada){
										console.log('entro');
										option = $('<option value="'+ response[i].idlocalidad + '" selected>' + response[i].nombre + '</option>');
								}else {
										option = $('<option value="'+ response[i].idlocalidad + '">' + response[i].nombre + '</option>');
								}*/
								option = $('<option value="'+ response[i].idmarca + '">' + response[i].nombre + '</option>');
								option.appendTo(select);
							})

						}
		});
	});

	$("#Producto_precioEfectivo").change(function(){
		var efectivo = $("#Producto_precioEfectivo").val();
		if (isNaN(efectivo)){
			$("#Producto_precio2").val(0);
			$("#Producto_precio3").val(0);
		}else{
			var incremento2 = 1 + $('#incrementoPrecio2').val()/100;
			var incremento3 = 1 + $('#incrementoPrecio3').val()/100;
			$("#Producto_precio2").val((efectivo * incremento2).toFixed(2));
			$("#Producto_precio3").val((efectivo * incremento3).toFixed(2));
		}


	});
</script>
