<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idpaciente')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idpaciente),array('view','id'=>$data->idpaciente)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cliente_idcliente')); ?>:</b>
	<?php echo CHtml::encode($data->cliente_idcliente); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('pacientecol')); ?>:</b>
	<?php echo CHtml::encode($data->pacientecol); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('especie_idespecie')); ?>:</b>
	<?php echo CHtml::encode($data->especie_idespecie); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('raza_idraza')); ?>:</b>
	<?php echo CHtml::encode($data->raza_idraza); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('sexo')); ?>:</b>
	<?php echo CHtml::encode($data->sexo); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('fechaNacimiento')); ?>:</b>
	<?php echo CHtml::encode($data->fechaNacimiento); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('observacion')); ?>:</b>
	<?php echo CHtml::encode($data->observacion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('señaParticular')); ?>:</b>
	<?php echo CHtml::encode($data->señaParticular); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('foto')); ?>:</b>
	<?php echo CHtml::encode($data->foto); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />

	*/ 
	
	
	?>

</div>