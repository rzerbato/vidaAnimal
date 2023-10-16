<div class="view">

		<b><?php echo CHtml::encode($data->getAttributeLabel('idConfigPrecio')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->idConfigPrecio),array('view','id'=>$data->idConfigPrecio)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('incrementoPrecio2')); ?>:</b>
	<?php echo CHtml::encode($data->incrementoPrecio2); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('incrementoPrecio3')); ?>:</b>
	<?php echo CHtml::encode($data->incrementoPrecio3); ?>
	<br />


</div>