<?php
$this->breadcrumbs=array(
	'Backup'=>array('index'),
	'Restaurar',
);?>
<h1><?php echo "Restaurar Backup" //$this->action->id; ?></h1>

<p>
	<?php if(isset($error)) echo $error; ?>
</p>
<p> <?php #echo CHtml::link('View Site',Yii::app()->HomeUrl)?></p>
