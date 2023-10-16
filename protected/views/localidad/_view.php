<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idlocalidad')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idlocalidad),array('view','id'=>$data->idlocalidad)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('codigoPostal')); ?>:</b>
	<?php echo CHtml::encode($data->codigoPostal); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('provincia_idprovincia')); ?>:</b>
	<?php echo CHtml::encode($data->provincia_idprovincia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />


</div>