<?php

class SubRubroController extends Controller
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
'actions'=>array('index','view', 'listadodinamico', 'buscarSubrubros'),
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
$model=new SubRubro;

// Uncomment the following line if AJAX validation is needed
$this->performAjaxValidation($model);

if(isset($_POST['SubRubro']))
{
$model->attributes=$_POST['SubRubro'];
$model->estado = 1;
if($model->save())
$this->redirect(array('admin'));
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

if(isset($_POST['SubRubro']))
{
$model->attributes=$_POST['SubRubro'];
if($model->save())
$this->redirect(array('admin'));
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
$model = $this->loadModel($id);
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
$dataProvider=new CActiveDataProvider('SubRubro');
$this->render('index',array(
'dataProvider'=>$dataProvider,
));
}

/**
* Manages all models.
*/
public function actionAdmin()
{
$model=new SubRubro('search');
$model->unsetAttributes();  // clear any default values
if(isset($_GET['SubRubro']))
{
  $model->attributes=$_GET['SubRubro'];
}

$modelRubro=new Rubro('search');
$modelRubro->unsetAttributes();  // clear any default values
if(isset($_GET['Rubro']))
{
  $modelRubro->attributes=$_GET['Rubro'];
}

$this->render('admin',array(
'model'=>$model, 'modelRubro'=>$modelRubro,
));
}


public function actionListadodinamico()
{
 if (isset($_POST['Producto']['rubro_idRubro']))
 {


   $criteria=new CDbCriteria;

   $criteria->compare('rubro_idRubro',$_POST['Producto']['rubro_idRubro']);
   $criteria->compare('estado', 1);
   $criteria->order = "nombre asc";
   
   $data = new CActiveDataProvider(SubRubro::model(), array(
    'pagination'=>array(
      'pageSize'=>100,
    ),
     'criteria'=>$criteria,     
   ));
 

  echo CHtml::tag('option', array('value'=>0), 'Seleccionar Subrubro', true);
  foreach($data->getData() as $value){
    //print_r($value);
    echo CHtml::tag('option', array('value'=>$value['idSubRubro']), CHtml::encode($value['nombre']), true);
  }

 }
}

public function actionBuscarSubrubros(){
  //echo "hola ".$_POST['idprovincia'];

  $criteria=new CDbCriteria;

  $criteria->compare('rubro_idRubro',$_POST['idrubro']);
  $criteria->compare('estado', 1);
  $criteria->order = 'nombre ASC';
  $data = new CActiveDataProvider(SubRubro::model(), array(
    'pagination'=>array(
      'pageSize'=>100,
    ),
    'criteria'=>$criteria,
  ));
  echo CJSON::encode($data->getData());
} 


/**
* Returns the data model based on the primary key given in the GET variable.
* If the data model is not found, an HTTP exception will be raised.
* @param integer the ID of the model to be loaded
*/
public function loadModel($id)
{
$model=SubRubro::model()->findByPk($id);
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
if(isset($_POST['ajax']) && $_POST['ajax']==='sub-rubro-form')
{
echo CActiveForm::validate($model);
Yii::app()->end();
}
}
}
