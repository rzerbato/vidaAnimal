<?php

class PacienteController extends Controller
{
/**
* @var string the default layout for the views. Defaults to '//layouts/column2', meaning
* using two-column layout. See 'protected/views/layouts/column2.php'.
*/
public $layout='//layouts/column2';

/**
* @return array action filters
*/
public function filters()
{
return array(
'accessControl', // perform access control for CRUD operations
);
}

/**
* Specifies the access control rules.
* This method is used by the 'accessControl' filter.
* @return array access control rules
*/
public function accessRules()
{
return array(
array('allow',  // allow all users to perform 'index' and 'view' actions
'actions'=>array('index','view'),
'users'=>array('*'),
),
array('allow', // allow authenticated user to perform 'create' and 'update' actions
'actions'=>array('create','update','admin','delete', 'imprimirHistoria'),
'users'=>array('@'),
),
/*
array('allow', // allow admin user to perform 'admin' and 'delete' actions
'actions'=>array('admin','delete'),
'users'=>array('admin'),
),
*/
array('deny',  // deny all users
'users'=>array('*'),
),
);
}

/**
* Displays a particular model.
* @param integer $id the ID of the model to be displayed
*/
public function actionView($id)
{
	$model = $this->loadModel($id);
	$modelConsulta = new Consulta('search');
	$modelConsulta->unsetAttributes();  // clear any default values
	$modelConsulta->cliente_idcliente = $model->cliente_idcliente;
	$modelConsulta->paciente_idpaciente = $model->idpaciente;
	$modelConsulta->estado = 1;
	if(isset($_GET['Consulta']))
		$modelConsulta->attributes=$_GET['Consulta'];

$this->render('view',array(
'model'=>$model, 'modelConsulta'=>$modelConsulta,
/*$this->render('view',array(
	'model'=>$this->loadModel($id),*/
));
}

/**
* Creates a new model.
* If creation is successful, the browser will be redirected to the 'view' page.
*/
public function actionCreate()
{
	$model=new Paciente;

	// Uncomment the following line if AJAX validation is needed
	 $this->performAjaxValidation($model);
	$idRaza = 0;
	if(isset($_POST['Paciente']))
	{

		$model->attributes=$_POST['Paciente'];
		$model->estado = 1;
		$model->fechaNacimiento = str_replace("/", "-", $model->fechaNacimiento);
		$newDate = date("Y-m-d", strtotime($model->fechaNacimiento));
		$model->fechaNacimiento = $newDate;
		$idRaza = $model->raza_idraza;

		if($model->save())
	    {
	    	//if ($_FILES['Paciente']['name']['imagen'] == ''){

			if ($_FILES['Paciente']['name']['imagen'] == ''){

				$model->foto = 'avatar_azul.png';

			}else{
				//if(isset($_FILES) and $_FILES['Paciente']['error']['imagen']==0)

				if(isset($_FILES) and $_FILES['Paciente']['error']['imagen']==0)
				{
					$uf = CUploadedFile::getInstance($model, 'imagen');

					if(strtolower($uf->getExtensionName()) == 'jpeg' || strtolower($uf->getExtensionName()) == 'png'
						|| strtolower($uf->getExtensionName()) == 'jpg'	|| strtolower($uf->getExtensionName()) == 'gif'
						|| strtolower($uf->getExtensionName()) == 'bmp')
					{

						$nombreImagen = mt_rand().''.$uf->getName();
						$uf->saveAs(Yii::getPathOfAlias('webroot').'/images/'.$nombreImagen);
						$model->foto = $nombreImagen;
						//$model->save();
					}
				}
				//$model->foto = $uf->getName();
			};
			$model->save();
			//$this->redirect(array('view','id'=>$model->idpaciente));
			$this->redirect(array('admin'));
	    }
	}
	if (!isset($model->imagen)){
			$model->foto = Yii::app()->baseUrl."/images/avatar_azul.png";

	}

	$modelCliente=new Cliente('search');
	$modelCliente->unsetAttributes();  // clear any default values
	if(isset($_GET['Cliente']))
	{
	  $modelCliente->attributes=$_GET['Cliente'];
	}


	$this->render('create',array(
	'model'=>$model, 'idRaza'=>$idRaza, 'modelCliente'=>$modelCliente,
	));
}

/**
* Updates a particular model.
* If update is successful, the browser will be redirected to the 'view' page.
* @param integer $id the ID of the model to be updated
*/
public function actionUpdate($id)
{
$model=$this->loadModel($id);

// Uncomment the following line if AJAX validation is needed
// $this->performAjaxValidation($model);

if(isset($_POST['Paciente']))
{
	$model->attributes=$_POST['Paciente'];
	$model->fechaNacimiento = str_replace("/", "-", $model->fechaNacimiento);
	$newDate = date("Y-m-d", strtotime($model->fechaNacimiento));
	$model->fechaNacimiento = $newDate;
	if($model->save())
	{

		if ($_FILES['Paciente']['name']['imagen'] == ''){

			//$model->foto = 'avatar_azul.png';

		}else{
			if(isset($_FILES) and $_FILES['Paciente']['error']['imagen']==0)
			{
				$uf = CUploadedFile::getInstance($model, 'imagen');

				if(strtolower($uf->getExtensionName()) == 'jpeg' || strtolower($uf->getExtensionName()) == 'png'
					|| strtolower($uf->getExtensionName()) == 'jpg' || strtolower($uf->getExtensionName()) == 'gif'
					|| strtolower($uf->getExtensionName()) == 'bmp')
				{

					$nombreImagen = mt_rand().''.$uf->getName();
					$uf->saveAs(Yii::getPathOfAlias('webroot').'/images/'.$nombreImagen);
					$model->foto = $nombreImagen;
				}
			}
			//$model->foto = $uf->getName();
		};
		$model->save();
		//$this->redirect(array('view','id'=>$model->idpaciente));
		$this->redirect(array('admin'));
	}
}
	//var_dump($model);
	$model->foto = Yii::app()->baseUrl."/images/".$model->foto;
	$idRaza = $model->raza_idraza;

	$modelCliente=new Cliente('search');
	$modelCliente->unsetAttributes();  // clear any default values
	if(isset($_GET['Cliente']))
	{
	  $modelCliente->attributes=$_GET['Cliente'];
	}

	$this->render('update',array(
		'model'=>$model, 'idRaza'=>$idRaza, 'modelCliente'=>$modelCliente,
	));
}

/**
* Deletes a particular model.
* If deletion is successful, the browser will be redirected to the 'admin' page.
* @param integer $id the ID of the model to be deleted
*/
public function actionDelete($id)
{
if(Yii::app()->request->isPostRequest)
{
// we only allow deletion via POST request
//$this->loadModel($id)->delete();
$modelo = $this->loadModel($id);
$modelo->estado = 0;
$modelo->save();


// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
if(!isset($_GET['ajax']))
$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
}
else
throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
}

/**
 * Genera un PDF con la historia clinica del paciente
 */
function actionImprimirHistoria($idPaciente){
	$pacienteModel = $this->loadModel($idPaciente);
	$consultaModel = new Consulta();
	$consultaModel->idconsulta = $pacienteModel->idpaciente;
	$consultas = $consultaModel->buscarConsultas($pacienteModel->idpaciente);
	$baseUrl = Yii::app()->baseUrl;
    $mPDF1 = Yii::app()->ePdf->mpdf();
    //$productos = Producto::model()->findAll(array('condition'=>'estado = 1', 'order'=>'nombre asc'));
    include './protected/views/paciente/historiaClinica.php';
}

/**
* Lists all models.
*/
public function actionIndex()
{
$dataProvider=new CActiveDataProvider('Paciente');
$this->render('index',array(
'dataProvider'=>$dataProvider,
));
}

/**
* Manages all models.
*/
public function actionAdmin()
{
	$model=new Paciente('search');
	$model->unsetAttributes();  // clear any default values
	if(isset($_GET['Paciente']))
		$model->attributes=$_GET['Paciente'];

	$this->render('admin',array(
		'model'=>$model,
	));
}

/**
* Returns the data model based on the primary key given in the GET variable.
* If the data model is not found, an HTTP exception will be raised.
* @param integer the ID of the model to be loaded
*/
public function loadModel($id)
{
$model=Paciente::model()->findByPk($id);
if($model===null)
throw new CHttpException(404,'The requested page does not exist.');
return $model;
}

/**
* Performs the AJAX validation.
* @param CModel the model to be validated
*/
protected function performAjaxValidation($model)
{
if(isset($_POST['ajax']) && $_POST['ajax']==='paciente-form')
{
echo CActiveForm::validate($model);
Yii::app()->end();
}
}
}
