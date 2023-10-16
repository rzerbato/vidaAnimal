<?php

class RazaController extends Controller
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
'actions'=>array('index','view', 'listadodinamico', 'buscarRazas'),
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
$model=new Raza;
//$modeloEspecie = Especie::model();
$modeloEspecie=new Especie('search');

// Uncomment the following line if AJAX validation is needed
 $this->performAjaxValidation($model);

if(isset($_POST['Raza']))
{
$model->attributes=$_POST['Raza'];
$model->estado = 1;
/*
* Recupero el ID de la especie
*/

$list= Yii::app()->db->createCommand('select * from especie where nombre=:nombre AND estado=:estado')
                      ->bindValue(':nombre', $model->especie_nombre)
                      ->bindValue(':estado', '1')
                      ->queryAll();
if (!empty($list)){
  $model->especie_idespecie = $list[0]['idespecie'];
}
if($model->save())
  $this->redirect(array('admin'));
}
if(isset($_GET['Especie'])){
  Yii::log("Entro al admin: ".$_GET['Especie']['nombre'], CLogger::LEVEL_WARNING, __METHOD__);
  $modeloEspecie->attributes=$_GET['Especie'];
}
$this->render('create',array(
'model'=>$model,
'modeloEspecie'=>$modeloEspecie
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
  //$modeloEspecie = Especie::model();
  $modeloEspecie=new Especie('search');
  // Uncomment the following line if AJAX validation is needed
  $this->performAjaxValidation($model);

  if(isset($_POST['Raza']))
  {
    $model->attributes=$_POST['Raza'];
    /*
    * Recupero el ID de la especie
    */
    if (isset($model->especie_nombre)){
      $list= Yii::app()->db->createCommand('select * from especie where nombre=:nombre')
      ->bindValue(':nombre', $model->especie_nombre)
      ->queryAll();
      if(sizeof($list)){
          $model->especie_idespecie = $list[0]['idespecie'];
      }else{
        $model->especie_idespecie = 0;
      }

    }

    if($model->save())
    $this->redirect(array('admin'));
  }
  $especie = Especie::model()->findByPK($model->especie_idespecie);
  if (isset($especie)){
      $model->especie_nombre = $especie->nombre;
  }

  if(isset($_GET['Especie'])){
    $modeloEspecie->attributes=$_GET['Especie'];
  }
  $this->render('update',array(
    'model'=>$model,'modeloEspecie'=>$modeloEspecie
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
$model->save(false);
  
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
$dataProvider=new CActiveDataProvider('Raza');
$this->render('index',array(
'dataProvider'=>$dataProvider,
));
}

/**
* Manages all models.
*/
public function actionAdmin(){
  
  $model=new Raza('search');
  $model->unsetAttributes();  // clear any default values
  //$modeloEspecie = Especie::model();
  $modeloEspecie=new Especie('search');
  if(isset($_GET['Raza'])){
    $model->attributes=$_GET['Raza'];
  }
  
  if(isset($_GET['Especie'])){
    Yii::log("Entro al admin: ".$_GET['Especie']['nombre'], CLogger::LEVEL_WARNING, __METHOD__);
    $modeloEspecie->attributes=$_GET['Especie'];
  }
  $this->render('admin',array(
    'model'=>$model, 'modeloEspecie'=>$modeloEspecie
  ));
}

public function actionBuscarRazas(){
  
  $criteria=new CDbCriteria;

  $criteria->compare('especie_idespecie',$_POST['idespecie']);
  $criteria->compare('estado', 1);
  $criteria->order = 'nombre ASC';
  $data = new CActiveDataProvider(Raza::model(), array(
    'pagination'=>array(
      'pageSize'=>100,
    ),
    'criteria'=>$criteria,
  ));
  echo CJSON::encode($data->getData());
}


public function actionListadodinamico()
{
 if (isset($_POST['Paciente']['especie_idespecie']))
 {
  /*$data = Localidad::model()->findAll(array(
   'condition'=>'provincia_idprovincia='.$_POST['Cliente']['provincia_idprovincia'],
   'order'=>'nombre',
  ));

   $data=CHtml::listData($data,'provincia_idprovincia','nombre');*/

   $criteria=new CDbCriteria;

   $criteria->compare('especie_idespecie',$_POST['Paciente']['especie_idespecie']);
   $criteria->compare('estado', 1);

   $data = new CActiveDataProvider(Raza::model(), array(
    'pagination'=>array(
      'pageSize'=>100,
    ),
     'criteria'=>$criteria,
   ));

   //$localidades = array(0 => 'Seleccionar Localidad');
   //$localidades = $localidades + $data->getData();
   //var_dump($localidades);
  //foreach($localidades as $value=>$name){

  //print_r($data->getData());
  echo CHtml::tag('option', array('value'=>0), 'Seleccionar Raza', true);
  foreach($data->getData() as $value){
    //print_r($value);
    echo CHtml::tag('option', array('value'=>$value['idraza']), CHtml::encode($value['nombre']), true);
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
$model=Raza::model()->findByPk($id);
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
if(isset($_POST['ajax']) && $_POST['ajax']==='raza-form')
{
echo CActiveForm::validate($model);
Yii::app()->end();
}
}
}
