<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idRubro')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idRubro),array('view','id'=>$data->idRubro)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />


</div>