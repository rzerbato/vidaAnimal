<?php
/* @var $this ConsultaController */
/* @var $model Consulta */

$this->breadcrumbs=array(
	'Consultas'=>array('paciente/view','id'=>$pacienteModel->idpaciente),
	'Crear',
);

$this->menu=array(
	array('label'=>'<i class="fa fa-close fa-fw"></i> Cancelar','url'=>array('paciente/view','id'=>$pacienteModel->idpaciente)),
);
?>

<h1>Crear Consulta</h1>

<?php $this->renderPartial('_form', array('model'=>$model, 'pacienteModel'=>$pacienteModel, 'clienteModel'=>$clienteModel, 'modelDiagnosticoComplementario' =>$modelDiagnosticoComplementario )); ?>