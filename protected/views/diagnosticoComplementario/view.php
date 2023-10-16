<?php
/* @var $this DiagnosticocomplementarioController */
/* @var $model Diagnosticocomplementario */


if($_GET['vieneDe']=='view'){
	$this->breadcrumbs=array(
		'Consulta'=>array('consulta/view','id'=>$model->consulta_idconsulta),
	);
}
if($_GET['vieneDe']=='update'){
		$this->breadcrumbs=array(
			'Consulta'=>array('consulta/update','id'=>$model->consulta_idconsulta),
		);
	}


if($_GET['vieneDe']=='view'){
	$this->menu=array(
		array('label'=>'<i class="fa fa-mail-reply fa-fw"></i> Volver','url'=>array('consulta/view','id'=>$model->consulta_idconsulta)),
	);
}
if($_GET['vieneDe']=='update'){
	$this->menu=array(
		array('label'=>'<i class="fa fa-mail-reply fa-fw"></i> Volver','url'=>array('consulta/update','id'=>$model->consulta_idconsulta)),
	);
}

?>

<h1>Ver Diagnostico Complementario</h1>


<?php 

$file = new SplFileInfo($model->archivo);
$extension = $file->getExtension();

$this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		//'iddiagnosticoComplementario',
		//'consulta_idconsulta',
		array(
            'label'=>'Archivo',
            'type'=>'raw',
			'value'=>CHtml::link(//CHtml::encode($model->archivo),
						CHtml::image(Yii::app()->baseUrl."/images/".$extension.".png"),
                        array("../images/".$model->archivo), array("target"=>"_blank")),
        ),
		'descripcion',

		
		//'estado',
	),
)); 
/*
array(
			'class'=>'CLinkColumn',
			'labelExpression'=>'Archivo',
			'urlExpression'=>'Yii::app()->createUrl("/courses/exams/create",array("exam_group_id"=>$data->id,"id"=>$_REQUEST["id"]))',
			'header'=>'Name',
		),
*/
?>
