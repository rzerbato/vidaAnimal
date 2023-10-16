<?php

class ConsultaController extends Controller
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
			'postOnly + delete', // we only allow deletion via POST request
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
				'actions'=>array('create','update','delete'),
				'users'=>array('@'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('admin'),
			),
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

		$modelDiagnostico=new DiagnosticoComplementario('search');
		$modelDiagnostico->unsetAttributes();  // clear any default values
		if(isset($_GET['Diagnosticocomplementario'])){
			$modelDiagnostico->attributes=$_GET['Diagnosticocomplementario'];
		}

		$this->render('view',array(
			'model'=>$this->loadModel($id), 'modelDiagnostico'=>$modelDiagnostico,
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate($idPaciente = null)
	{

		$pacienteModel = Paciente::model()->findByPk($idPaciente);
		$clienteModel = Cliente::model()->findByPk($pacienteModel->cliente_idcliente);


		$model=new Consulta;

		$model->cliente_idcliente = $clienteModel->idcliente;
		$model->paciente_idpaciente = $pacienteModel->idpaciente;
		$model->estado = 1;
		$modelDiagnosticoComplementario = new DiagnosticoComplementario('search');
		$modelDiagnosticoComplementario->unsetAttributes();  // clear any default values

		$modelDiagnosticoComplementario->consulta_idconsulta = $model->idconsulta;
		$modelDiagnosticoComplementario->estado = 1;



		// Uncomment the following line if AJAX validation is needed
		#$this->performAjaxValidation($model);

		if(isset($_POST['Consulta']))
		{
			$model->attributes=$_POST['Consulta'];
			$irDiagnosticoComplementario = $_POST['Consulta']['irDiagnosticoComplementario'];
			$fechaOld = $model->fecha;
			$model->fecha = str_replace("/", "-", $model->fecha);
			$newDate = date("Y-m-d", strtotime($model->fecha));
			$model->fecha = $newDate;
			if($model->save()){
				//Yii::log("HIZO EL FUCKING SAVE!!!" , CLogger::LEVEL_WARNING, __METHOD__);
				if($irDiagnosticoComplementario == "true"){
					$this->redirect('../../index.php/diagnosticoComplementario/create/'.$model->idconsulta);
				}else{
					//$this->redirect(array('admin'));
					$this->redirect('../../index.php/paciente/'.$pacienteModel->idpaciente);
				}
			}
			$model->fecha = $fechaOld;
		}

		$model->irDiagnosticoComplementario = "false";
		if(!isset($model->fecha)){
			$model->fecha = date('d/m/Y');

		}
		if(isset($_GET['Diagnosticocomplementario'])){
			$modelDiagnosticoComplementario->attributes=$_GET['Diagnosticocomplementario'];
		}

		$this->render('create',array(
			'model'=>$model, 'pacienteModel'=>$pacienteModel, 'clienteModel'=>$clienteModel, 'modelDiagnosticoComplementario' =>$modelDiagnosticoComplementario
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

		$pacienteModel = Paciente::model()->findByPk($model->paciente_idpaciente);
		$clienteModel = Cliente::model()->findByPk($pacienteModel->cliente_idcliente);

		$modelDiagnosticoComplementario = new DiagnosticoComplementario('search', array('idconsulta', $model->idconsulta));
		$modelDiagnosticoComplementario->unsetAttributes();  // clear any default values
		$modelDiagnosticoComplementario->consulta_idconsulta = $model->idconsulta;
		$modelDiagnosticoComplementario->estado = 1;
		if(isset($_GET['DiagnosticoComplementario']))
			$modelDiagnosticoComplementario->attributes=$_GET['DiagnosticoComplementario'];

		// Uncomment the following line if AJAX validation is needed
		$this->performAjaxValidation($model);


		if(isset($_POST['Consulta']))
		{
			$model->attributes=$_POST['Consulta'];
			$irDiagnosticoComplementario = $_POST['Consulta']['irDiagnosticoComplementario'];
			$fechaOld = $model->fecha;
			$model->fecha = str_replace("/", "-", $model->fecha);
			$newDate = date("Y-m-d", strtotime($model->fecha));
			$model->fecha = $newDate;
			if($model->save()){
				if($irDiagnosticoComplementario == "true"){
					$this->redirect(Yii::app()->baseUrl.'/index.php/diagnosticoComplementario/create/'.$model->idconsulta);
				}else{
					//$this->redirect(array('view','id'=>$model->idconsulta));
					$this->redirect(Yii::app()->baseUrl.'/index.php/paciente/'.$pacienteModel->idpaciente);
				}
			}
		}

		#$this->render('update',array(
		#	'model'=>$model,
		#));
		$model->fecha = str_replace("-", "/", $model->fecha);
			$newDate = date("d/m/Y", strtotime($model->fecha));
			$model->fecha = $newDate;
			if(isset($_GET['Diagnosticocomplementario'])){
				$modelDiagnosticoComplementario->attributes=$_GET['Diagnosticocomplementario'];
			}
		$this->render('create',array(
			'model'=>$model, 'pacienteModel'=>$pacienteModel, 'clienteModel'=>$clienteModel, 'modelDiagnosticoComplementario' =>$modelDiagnosticoComplementario
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDelete($id)
	{
		//$this->loadModel($id)->delete();
		$model=$this->loadModel($id);
		$model->estado = 0;
		$model->save();

		// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
		if(!isset($_GET['ajax']))
			$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
	}

	/**
	 * Lists all models.
	 */
	public function actionIndex()
	{
		$dataProvider=new CActiveDataProvider('Consulta');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new Consulta('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Consulta']))
			$model->attributes=$_GET['Consulta'];

		$this->render('admin',array(
			'model'=>$model,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return Consulta the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=Consulta::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param Consulta $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='consulta-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
}
