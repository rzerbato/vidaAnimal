<?php
/* @var $this DiagnosticocomplementarioController */
/* @var $data Diagnosticocomplementario */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('iddiagnosticoComplementario')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->iddiagnosticoComplementario), array('view', 'id'=>$data->iddiagnosticoComplementario)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('consulta_idconsulta')); ?>:</b>
	<?php echo CHtml::encode($data->consulta_idconsulta); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('descripcion')); ?>:</b>
	<?php echo CHtml::encode($data->descripcion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('archivo')); ?>:</b>
	<?php echo CHtml::encode($data->archivo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />


</div>