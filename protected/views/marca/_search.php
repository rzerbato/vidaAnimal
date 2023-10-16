<?php $form=$this->beginWidget('booster.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

<?php #echo $form->textFieldGroup($model,'idmarca',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
<div class="row">
	<div class="col-md-3 col-md-offset-1 col-xs-12">

		<?php #echo $form->textFieldGroup($model,'rubro_idRubro',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>

		<div class="form-group">
			<label class="control-label required" for="SubRubro_rubro_idRubro">Rubro <span class="required">*</span></label>
			<div class="input-group">
					<input class="form-control" placeholder="Rubro" name="Marca[rubro_idRubro]" id="Marca_rubro_idRubro" type="text"/>
					<span class="input-group-btn">
						<button id="buscarRubro" data-toggle="modal" data-target="#modalRubro" class="btn btn-default"  name="yt0" type="button"><i class="fa fa-search fa-fw"></i></button> 												
					</span>
			</div>	
		</div>
	</div>
	<div class="col-md-4 col-md-offset-1 col-xs-12">
		<?php echo $form->textFieldGroup($model,'nombre',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5','maxlength'=>45)))); ?>
	</div>
</div>
		<?php #echo $form->textFieldGroup($model,'estado',array('widgetOptions'=>array('htmlOptions'=>array('class'=>'span5')))); ?>
		<div class="row">
			<div class="col-md-7 col-md-offset-1 col-xs-12">
	<div class="form-actions">
		<?php $this->widget('booster.widgets.TbButton', array(
			'buttonType' => 'submit',
			'context'=>'primary',
			'label'=>'Buscar',
		)); ?>
	</div>
</div>
</div>
<?php #$this->endWidget(); ?>

<!-- Begin Modal Rubro -->
<div class="modal fade" id="modalRubro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		<div class="modal-dialog">
				<div class="modal-content">
						<div class="modal-header">
								<h4 class="modal-title" id="myModalLabel">Búsqueda de Rubros</h4>
						</div>
						<div class="modal-body">
								<div class="output" style="overflow-y: auto">
										<?php
												$url = 'protected/views/rubro/select.php';
												include_once $url;
										?>
								</div>
						</div>
								<div class="modal-footer">
										<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
										<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="seleccionarRubro()">Seleccionar</button>
								</div>
						</div>
		</div>
</div>
<!-- End Modal Rubro -->
<?php $this->endWidget(); ?>


<script type="text/javascript">
function mostrarFind(icono)
{
		$('#buscarRubro').fadeIn(600);

}

function ocultarFind()
{
		$('#buscarRubro').fadeOut(600);

}

function seleccionarRubro(){
var id_seleccionado =	$('#rubro-grid').yiiGridView('getSelection');
$.ajax({
				data: 'id='+id_seleccionado,
				url: <?php echo "'".CHtml::normalizeUrl(array('rubro/buscarId'))."'"; ?>,
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
								$('#Marca_rubro_idRubro').val(response['nombre']);
				}
});
}

</script>
