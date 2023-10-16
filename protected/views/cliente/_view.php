<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idcliente')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idcliente),array('view','id'=>$data->idcliente)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('numeroDocumento')); ?>:</b>
	<?php echo CHtml::encode($data->numeroDocumento); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tipoDocumento_idtipoDocumento')); ?>:</b>
	<?php echo CHtml::encode($data->tipoDocumento_idtipoDocumento); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('direccion')); ?>:</b>
	<?php echo CHtml::encode($data->direccion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('provincia_idprovincia')); ?>:</b>
	<?php echo CHtml::encode($data->provincia_idprovincia); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('localidad_idlocalidad')); ?>:</b>
	<?php echo CHtml::encode($data->localidad_idlocalidad); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('telefonoFijo')); ?>:</b>
	<?php echo CHtml::encode($data->telefonoFijo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('telefonoCelular')); ?>:</b>
	<?php echo CHtml::encode($data->telefonoCelular); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('email')); ?>:</b>
	<?php echo CHtml::encode($data->email); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />

	*/ ?>

</div>
