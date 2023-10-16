<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'id'=>'raza-form',
	'enableAjaxValidation'=>true,
)); ?>

<p class="help-block">Los campos con <span class="required">*</span> son obligatorios.</p>
<?php #var_dump($model->errors['especie_nombre']); ?>
<?php echo $form->errorSummary($model); ?>
			<?php #echo $form->textFieldGroup($model,'especie_idespecie',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	   
            <div class="row">            
				<div class="col-md-5 col-md-offset-1 col-xs-12">                
                    <div class="form-group <?php if (isset($model->errors['especie_nombre'])){echo 'has-error';} ?>">
                        <?php echo $form->labelEx($model,'especie_nombre'); ?>
                        <div class="input-group">
                            <input class="form-control" placeholder="Especie" name="Raza[especie_nombre]" id="Raza_especie_nombre" type="text"  value = '<?php if (isset($model)){echo $model->especie_nombre;} ?>'/>
                            <span class="input-group-btn">
                                <button id="buscarEspecie" data-toggle="modal" data-target="#modalEspecie" class="btn btn-default"  name="yt0" type="button"><i class="fa fa-search fa-fw"></i></button> 
                            </span>
                           
                        </div>
                        <?php echo $form->error($model,'especie_nombre'); ?>                        
                    </div>
                    
                </div>
            </div>
			
			<div class="row">
				<div class="col-md-5 col-md-offset-1 col-xs-12">
					<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
				</div>
			</div>
	<?php # echo $form->textFieldGroup($model,'estado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
	<div class="row">
		<div class="col-md-9 col-md-offset-1 col-xs-12">
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

<!-- Begin Modal Especie -->
<div class="modal fade" id="modalEspecie" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Búsqueda de Especies</h4>
            </div>
            <div class="modal-body">
                <div class="output" style="overflow-y: auto">
                    <?php
                        $url = 'protected/views/especie/select.php';
                        include_once $url;
                    ?>
                </div>
            </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="seleccionarEspecie()">Seleccionar</button>
                </div>
            </div>
    </div>
</div>

<!-- End Modal Especie -->

<script type="text/javascript">
/*
$(document).ready(function(){
    var elDiv = document.querySelector('.keys');
    elDiv.setAttribute('title', '/veterinaria/index.php/especie/admin');
});

*/

function mostrarFind()
	{

			$('#buscarEspecie').fadeIn(600);

	}

function ocultarFind()
	{
			$('#buscarEspecie').fadeOut(600);

	}

function seleccionarEspecie(){
	var id_seleccionado =	$('#especie-grid').yiiGridView('getSelection');
	$.ajax({
          data: 'id='+id_seleccionado,
          url: <?php echo "'".CHtml::normalizeUrl(array('especie/buscarId'))."'"; ?>,
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
                  $('#Raza_especie_nombre').val(response['nombre']);
									$('#Raza_especie_nombre').focus();

          }
  });
}



</script>
