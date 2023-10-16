<?php

class LocalidadController extends Controller
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
        'actions'=>array('index','view', 'listadodinamico', 'buscarLocalidades'),
        'users'=>array('*'),
      ),
      array('allow', // allow authenticated user to perform 'create' and 'update' actions
        'actions'=>array('create','update','admin','delete'),
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
  $this->render('view',array(
    'model'=>$this->loadModel($id),
  ));
}

/**
* Creates a new model.
* If creation is successful, the browser will be redirected to the 'view' page.
*/
public function actionCreate()
{
  $model=new Localidad;

  // Uncomment the following line if AJAX validation is needed
   $this->performAjaxValidation($model);

  if(isset($_POST['Localidad']))
  {
    $model->attributes=$_POST['Localidad'];
    $model->estado = 1;

    if($model->save()){
      //$this->redirect(array('view','id'=>$model->idlocalidad));
      $this->redirect('admin');
    }
  }

  $this->render('create',array(
    'model'=>$model,
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
  $this->performAjaxValidation($model);

  if(isset($_POST['Localidad']))
  {
    $model->attributes=$_POST['Localidad'];
    if($model->save()){
      //$this->redirect(array('view','id'=>$model->idlocalidad));
      $this->redirect(array('admin'));
    }

  }

  $this->render('update',array(
    'model'=>$model,
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
    $model=$this->loadModel($id);
    $model->estado = 0;
    $model->save();



    // if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
    if(!isset($_GET['ajax']))
      $this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
  }
  else
  throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
}

/**
* Lists all models.
*/
public function actionIndex()
{
  $dataProvider=new CActiveDataProvider('Localidad');
  $this->render('index',array(
    'dataProvider'=>$dataProvider,
  ));
}

/**
* Manages all models.
*/
public function actionAdmin()
{
  $model=new Localidad('search');
  $model->unsetAttributes();  // clear any default values
  if(isset($_GET['Localidad']))
  $model->attributes=$_GET['Localidad'];

  $this->render('admin',array(
    'model'=>$model,
  ));
}

public function actionBuscarLocalidades(){
  //echo "hola ".$_POST['idprovincia'];
  $criteria=new CDbCriteria;

  $criteria->compare('provincia_idprovincia',$_POST['idprovincia']);
  $criteria->compare('estado', 1);
  $criteria->order = 'nombre ASC';
  $data = new CActiveDataProvider(Localidad::model(), array(
    'criteria'=>$criteria,
  ));
  echo CJSON::encode($data->getData());
}

public function actionListadodinamico()
{
 if (isset($_POST['Cliente']['provincia_idprovincia']))
 {
  /*$data = Localidad::model()->findAll(array(
   'condition'=>'provincia_idprovincia='.$_POST['Cliente']['provincia_idprovincia'],
   'order'=>'nombre',
  ));

   $data=CHtml::listData($data,'provincia_idprovincia','nombre');*/

   $criteria=new CDbCriteria;

   $criteria->compare('provincia_idprovincia',$_POST['Cliente']['provincia_idprovincia']);
   $criteria->compare('estado', 1);

   $data = new CActiveDataProvider(Localidad::model(), array(
     'criteria'=>$criteria,
   ));

   //$localidades = array(0 => 'Seleccionar Localidad');
   //$localidades = $localidades + $data->getData();
   //var_dump($localidades);
  //foreach($localidades as $value=>$name){

  //print_r($data->getData());
  echo CHtml::tag('option', array('value'=>0), 'Seleccionar Localidad', true);
  foreach($data->getData() as $value){
    //print_r($value);
    echo CHtml::tag('option', array('value'=>$value['idlocalidad']), CHtml::encode($value['nombre']), true);
  }

 }
}


/**
* Returns the data model based on the primary key given in the GET variable.
* If the data model is not found, an HTTP exception will be raised.
* @param integer the ID of the model to be loaded
*/
public function loadModel($id)
{
  $model=Localidad::model()->findByPk($id);
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
  if(isset($_POST['ajax']) && $_POST['ajax']==='localidad-form')
  {
    echo CActiveForm::validate($model);
    Yii::app()->end();
  }
}
}
