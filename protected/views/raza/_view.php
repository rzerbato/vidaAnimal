<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idraza')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idraza),array('view','id'=>$data->idraza)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('especie_idespecie')); ?>:</b>
	<?php echo CHtml::encode($data->especie_idespecie); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />


</div>