<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idespecie')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idespecie),array('view','id'=>$data->idespecie)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />


</div>