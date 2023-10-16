<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idproducto')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idproducto),array('view','id'=>$data->idproducto)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('codigo')); ?>:</b>
	<?php echo CHtml::encode($data->codigo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('rubro_idRubro')); ?>:</b>
	<?php echo CHtml::encode($data->rubro_idRubro); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('subRubro_idSubRubro')); ?>:</b>
	<?php echo CHtml::encode($data->subRubro_idSubRubro); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('marca_idmarca')); ?>:</b>
	<?php echo CHtml::encode($data->marca_idmarca); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('precioCosto')); ?>:</b>
	<?php echo CHtml::encode($data->precioCosto); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('precioEfectivo')); ?>:</b>
	<?php echo CHtml::encode($data->precioEfectivo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('precio2')); ?>:</b>
	<?php echo CHtml::encode($data->precio2); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('precio3')); ?>:</b>
	<?php echo CHtml::encode($data->precio3); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />

	*/ ?>

</div>