<?php
/* @var $this ConsultaController */
/* @var $data Consulta */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('idconsulta')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idconsulta), array('view', 'id'=>$data->idconsulta)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha')); ?>:</b>
	<?php echo CHtml::encode($data->fecha); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cliente_idcliente')); ?>:</b>
	<?php echo CHtml::encode($data->cliente_idcliente); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('paciente_idpaciente')); ?>:</b>
	<?php echo CHtml::encode($data->paciente_idpaciente); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tipoConsulta_idtipoConsulta')); ?>:</b>
	<?php echo CHtml::encode($data->tipoConsulta_idtipoConsulta); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('motivo')); ?>:</b>
	<?php echo CHtml::encode($data->motivo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />


</div>