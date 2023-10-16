<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idSubRubro')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idSubRubro),array('view','id'=>$data->idSubRubro)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('rubro_idRubro')); ?>:</b>
	<?php echo CHtml::encode($data->rubro_idRubro); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />


</div>