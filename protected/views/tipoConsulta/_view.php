<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idtipoConsulta')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idtipoConsulta),array('view','id'=>$data->idtipoConsulta)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado')); ?>:</b>
	<?php echo CHtml::encode($data->estado); ?>
	<br />


</div>