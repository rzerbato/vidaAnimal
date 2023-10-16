<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'paciente-form',
	'enableAjaxValidation'=>true,
	'htmlOptions'=>array('enctype'=>'multipart/form-data'),
)); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

<?php echo $form->errorSummary($model); ?>


	<div class="row">
		<div class="col-md-5 col-md-offset-1 col-xs-12">

                <?php #echo $form->textFieldGroup($model,'cliente_idcliente',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
                <label class="control-label required" for="SubRubro_rubro_idRubro">Cliente <span class="required">*</span></label>
                <div class="form-group input-group">
                    <input class="form-control" placeholder="Cliente" name="Paciente[cliente_idcliente]" id="Paciente_cliente_idCliente"  <?php if (isset($model)){ echo 'value= "'.$model->cliente_idcliente.'"';}?> type="text" onchange="searchClienteId()">
                    <span class="input-group-addon" style="width: 70%" id="nombreCliente">Nombre Cliente</span>
                    <span class="input-group-btn">
                    <button id="buscarCliente" data-toggle="modal" data-target="#modalCliente" class="btn btn-default" name="yt0" type="button"><i class="fa fa-search fa-fw"></i></button> </span>
                </div>
                    <!--<div class="form-group">
                        <label class="control-label required" for="SubRubro_rubro_idRubro">Cliente <span class="required">*</span></label>
                        <div class="row">
                            <div class="col-md-4 col-xs-10">
                                <input class="form-control" placeholder="Cliente" name="Paciente[cliente_idcliente]" id="Paciente_cliente_idCliente" type="text" onfocus="mostrarFind()" onblur="ocultarFind('')"/>

                            </div>
                            <div class="col-md-1 col-xs-1">
                                <span id="buscarCliente" data-toggle="modal" data-target="#modalCliente" class="glyphicon glyphicon-search" style="display: none"></span>
                            </div>
                            <div class="col-md-6 col-xs-0">
                                <p id="nombreCliente"></p>
                            </div>
                        </div>
                    </div>-->

                <?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>

		<?php #echo $form->textFieldGroup($model,'sexo',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>9)))); ?>

        <?php
            $sexo = array('' => 'Seleccionar Sexo', 'Hembra' => 'Hembra', 'Macho' => 'Macho');
            echo $form->dropDownListGroup(
                $model,
                'sexo',
                array(
                    'widgetOptions' => array(
                        'data' => $sexo,
                    )
                )

            );

        ?>

        <?php
        echo $form->datePickerGroup(
			$model,
			'fechaNacimiento',
			array('widgetOptions'=>array(

				'options'=>array(
					'autoclose' => true,
                    'todayHighlight' => true,
                    'format' => 'dd/mm/yyyy',
				),
				'htmlOptions'=>array('class'=>'span5')),
				'prepend'=>'<i class="glyphicon glyphicon-calendar"></i>'
			)); ?>



		<?php #echo $form->textFieldGroup($model,'pacientecol',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>

		<?php #echo $form->textFieldGroup($model,'especie_idespecie',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

        <?php
            $especies = array('' => 'Seleccionar Especie');
            $especies = $especies + Especie::getListaEspecies('idespecie');
            echo $form->dropDownListGroup(
                $model,
                'especie_idespecie',
                array(
                    'widgetOptions' => array(
                        'data' => $especies,
                        'htmlOptions'=>array(
                            'ajax' => array(
                                'type' => 'POST',
                                'url' => CController::createUrl('raza/listadodinamico'), // Controlador que devuelve las localidades relacionadas
                                'update' => '#Paciente_raza_idraza', // id del item que se actualizará
                                    #'update' => '#localidad_idlocalidad', // id del item que se actualizará
                      )
                        ),
                    )
                )
            );

        ?>

		<?php #echo $form->textFieldGroup($model,'raza_idraza',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
<?php
        $razas = array('' => 'Seleccionar Raza');
        echo $form->dropDownListGroup(
            $model,
            'raza_idraza',
            array(
                'widgetOptions' => array(
                    'data' => $razas,
                )

            )
        );
        ?>

		<?php echo $form->textAreaGroup($model,'observacion', array('widgetOptions'=>array('htmlOptions'=>array('rows'=>6, 'cols'=>50, 'class'=>'span8')))); ?>

		<?php echo $form->textFieldGroup($model,'señaParticular',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>100)))); ?>
		</div>
		<div class="col-md-4 col-md-offset-1 col-xs-12">
	        <section class="row foto_mascota">
                <div id="foto_container" class="col-md-12 col-xs-12 contenedor_foto_mascota">
                    <img id="foto" src="<?php echo $model->foto ?>">
                </div>
                <div class="row">
                    <div class="col-md-12 col-xs-12" style="margin-top: 5%">
                        <!--<input type="file" id="Paciente_imagen" name="Paciente[imagen]"/>-->
                        <div class="input-group input-file" name="Paciente[imagen]">
                            <span class="input-group-btn">
                                <button class="btn btn-default btn-choose" type="button">Archivo</button>
                            </span>
                            <input type="text" class="form-control" placeholder='Seleccionar Archivo...' id="Pacienteimagen" name="Pacienteimagen"/>
                            <span class="input-group-btn">
                                <button class="btn btn-warning btn-reset" type="button">Reset</button>
                            </span>
                        </div>
                    </div>
                </div>
            </section>
			<?php #echo $form->textFieldGroup($model,'foto',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
		</div>
	<?php #echo $form->textFieldGroup($model,'estado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	</div>
	<div class="row">
		<div class="col-md-5 col-md-offset-1 col-xs-12">
        <input type="text" id="idRaza" value="<?php echo $idRaza ?>" style="display: none">
			<div class="form-actions">
				<?php $this->widget('booster.widgets.TbButton', array(
						'buttonType'=>'submit',
						'context'=>'primary',
						'label'=>$model->isNewRecord ? 'Crear' : 'Actualizar',
					)); ?>
			</div>
		</div>
	</div>



<!-- Begin Modal Cliente -->
<div class="modal fade" id="modalCliente" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Búsqueda de Clientes</h4>
			</div>
			<div class="modal-body">
				<div class="output" style="overflow-y: auto">
					<?php
						$url = 'protected/views/cliente/select.php';
						include_once $url;
					?>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="seleccionarCliente()">Seleccionar</button>
			</div>
		</div>
	</div>
</div>
<!-- End Modal Cliente -->
<?php $this->endWidget(); ?>

<script type="text/javascript">

	window.addEventListener('load',  init);

        function init() {
            //Asigno los listener a los botones que buscan las imagenes
            var inptData = document.getElementById('Paciente_imagen');
            inptData.addEventListener('change', leerArchivos, false);
            if (($("#Paciente_fechaNacimiento").val() != '') && (($("#Paciente_fechaNacimiento").val() != '0000-00-00'))){
                $("#Paciente_fechaNacimiento").val((moment($("#Paciente_fechaNacimiento").val()).format('DD/MM/YYYY')));
            }

            var id_seleccionado = $('#Paciente_especie_idespecie').val();
            if (id_seleccionado > 0){
                $.ajax({
                        data: 'idespecie='+id_seleccionado,
                        url: <?php echo "'".CHtml::normalizeUrl(array('raza/buscarRazas'))."'"; ?>,
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
                                            var idRazaSeleccionada = $("#idRaza").val();
                                            var select = $("#Paciente_raza_idraza");
                                            select.empty();
                                            var option = $('<option value="0">Seleccionar Raza</option>');
                                            option.appendTo(select);
                                            $.each(response, function(i,item){
                                                if (response[i].idraza == idRazaSeleccionada){
                                                        option = $('<option value="'+ response[i].idraza + '" selected>' + response[i].nombre + '</option>');
                                                }else {
                                                        option = $('<option value="'+ response[i].idraza + '">' + response[i].nombre + '</option>');
                                                }
                                                option.appendTo(select);
                                            })
                        }
                });
            }
            if ( $("#Paciente_cliente_idCliente").val()!= ''){
                searchClienteId();
            }


        }


        function leerArchivos(e){
            var files = e.target.files;
            var reader = new FileReader();
            reader.addEventListener('load', displayFile, false);
            for(var i = 0; i< files.length; i++){
                var file = files[i];
                if (file.type.indexOf('image') > -1){
                    reader.readAsDataURL(file);
                    continue;
                }
            }
        }

        function displayFile(e){
            var resultado = e.target.result;
            var target = document.getElementById('foto_container');
            if (resultado.indexOf(' ') < 1){
                var imagen = document.createElement('img');
                imagen.setAttribute('src', resultado);
                target.innerHTML = '';
                target.appendChild(imagen);
                return;
            }
            target.innerHTML = resultado;
            return;
        }

function mostrarFind(icono)
{
    $('#buscarCliente').fadeIn(600);

}

function ocultarFind()
{
    $('#buscarCliente').fadeOut(600);

}

function seleccionarCliente(){
    var id_seleccionado = $('#cliente-grid').yiiGridView('getSelection');
    $.ajax({
        data: 'id='+id_seleccionado,
        url: <?php echo "'".CHtml::normalizeUrl(array('cliente/buscarId'))."'"; ?>,
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
            console.log(response);
            console.log(response['nombre']);
            $("#nombreCliente").text(response['nombre']);
            $("#Paciente_cliente_idCliente").val(response['id']);
            //$('#Paciente_cliente_idCliente').val(response['id']);
        }
    });
}

function searchClienteId(){
    var id_seleccionado = $('#Paciente_cliente_idCliente').val();
    $.ajax({
        data: 'id='+id_seleccionado,
        url: <?php echo "'".CHtml::normalizeUrl(array('cliente/buscarId'))."'"; ?>,
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
            alert("El cliente ingresado no existe");
            $('#Paciente_cliente_idCliente').val('');
            $('#nombreCliente').text('Nombre Cliente');
            //alert("Pasó lo siguiente: "+ quepaso + " " + otroobj);
        },
        success: function(response){
            console.log(response);
            console.log(response['nombre']);
            $("#nombreCliente").text(response['nombre']);
            $("#Paciente_cliente_idCliente").val(response['id']);
            //$('#Paciente_cliente_idCliente').val(response['id']);
        }
    });
}

function bs_input_file() {
	$(".input-file").before(
		function() {

			if ( ! $(this).prev().hasClass('input-ghost') ) {
				var element = $("<input type='file' id='Paciente_imagen' name='Paciente[imagen]' class='input-ghost' style='visibility:hidden; height:0'>");
                //var element = $("<input type='file' id='Paciente_imagen' name='Paciente[imagen]' class='input-ghost'>");

				element.attr("name",$(this).attr("name"));
				element.change(function(){
					element.next(element).find('input').val((element.val()).split('\\').pop());
				});
				$(this).find("button.btn-choose").click(function(){
					element.click();
				});
				$(this).find("button.btn-reset").click(function(){
					element.val(null);
					$(this).parents(".input-file").find('input').val('');
                    imagen = document.getElementById('Paciente_imagen');
                    if (!imagen){
                        alert("El elemento selecionado no existe");
                    } else {
                        padre = imagen.parentNode;
                        padre.removeChild(imagen);
                    }
				});
				$(this).find('input').css("cursor","pointer");
				$(this).find('input').mousedown(function() {
					$(this).parents('.input-file').prev().click();
					return false;
				});
				return element;
			}
		}
	);
}
$(function() {
	bs_input_file();
});





</script>
