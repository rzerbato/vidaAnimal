<?php
/* @var $this DiagnosticocomplementarioController */
/* @var $model Diagnosticocomplementario */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('booster.widgets.TbActiveForm', array(
	'id'=>'diagnosticocomplementario-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>true,
	'htmlOptions'=>array('enctype'=>'multipart/form-data'),
)); ?>

	<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>

	<?php echo $form->errorSummary($model); ?>

	<!-- <div class="row">
		<?php #echo $form->labelEx($model,'consulta_idconsulta'); ?>
		<?php #echo $form->textField($model,'consulta_idconsulta'); ?>
		<?php #echo $form->error($model,'consulta_idconsulta'); ?>
	</div> -->

	

	 <!-- <div class="row"> -->
		<?php #echo $form->labelEx($model,'archivo'); ?>
		<?php #echo $form->textField($model,'archivo'); ?>
		<?php #echo $form->error($model,'archivo'); ?>
	<!-- </div> -->
	
	<!-- <input type="file" id="Diagnosticocomplementario_imagen" name="Diagnosticocomplementario[imagen]"/> -->
	
	<div class="row">	
		<div class="col-md-5 col-md-offset-1 col-xs-12">
		<?php echo $form->labelEx($model,'archivo'); ?>
			<div class="input-group input-file" name="Diagnosticocomplementario[imagen]">
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
	<div class="row" style = "margin-top: 2%;">
		<div id="foto_container" class="col-md-11 offset-1 col-xs-12">	
		</div>
	</div>	
	<div class="row" style = "margin-top: 2%;">
		<div class="col-md-8 col-md-offset-1 col-xs-12">
			<?php #echo $form->labelEx($model,'descripcion'); ?>
			<?php #echo $form->textField($model,'descripcion',array('size'=>45,'maxlength'=>45)); ?>
			<?php #echo $form->error($model,'descripcion'); ?>
			<?php echo $form->textAreaGroup($model,'descripcion', array('widgetOptions'=>array('htmlOptions'=>array('rows'=>6, 'cols'=>50, 'class'=>'span8')))); ?>

		</div>
	</div>
	
	<!-- <div class="row">
		<?php #echo $form->labelEx($model,'estado'); ?>
		<?php #echo $form->textField($model,'estado'); ?>
		<?php #echo $form->error($model,'estado'); ?>
	</div> -->
 
	<!-- <div class="row buttons">
		<?php #echo CHtml::submitButton($model->isNewRecord ? 'Crear' : 'Actualizar'); ?>
	</div> -->

	<div class="row">
		<div class="col-md-5 col-md-offset-1 col-xs-12">
        
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

</div><!-- form -->
<script>
window.addEventListener('load',  init)
function init() {
	//Asigno los listener a los botones que buscan las imagenes
	var inptData = document.getElementById('Diagnosticocomplementario_imagen');
	inptData.addEventListener('change', leerArchivos, false);            
			
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
		imagen.setAttribute('class', 'imagenDiagnostico');
		target.innerHTML = '';
		target.appendChild(imagen);
		return;
	}
	target.innerHTML = resultado;
	return;
}

function bs_input_file() {
	$(".input-file").before(
		function() {
            
			if ( ! $(this).prev().hasClass('input-ghost') ) {
				//var element = $("<input type='file' id='Paciente_imagen' name='Paciente[imagen]' class='input-ghost' style='visibility:hidden; height:0'>");
				var element = $("<input type='file' id='Diagnosticocomplementario_imagen' name='Diagnosticocomplementario[imagen]' class='input-ghost' style='visibility:hidden; height:0'>");
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