<?php

class ProductoController extends Controller
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
    'actions'=>array('create','update', 'print', 'actualizaPreciosRubro', 'actualizaPreciosSubRubro', 'actualizaPreciosMarca', 'actualizaPreciosMasivo','admin','delete'),
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
  $model=new Producto;

  // Uncomment the following line if AJAX validation is needed
  $this->performAjaxValidation($model);
  $idMarca = 0;
  $idSubrubro = 0;
  if(isset($_POST['Producto']))
  {
    $model->attributes=$_POST['Producto'];
    $idMarca = $model->marca_idmarca;
    $idSubrubro = $model->subRubro_idSubRubro;
    $model->estado = 1;
    $model->porcIncremento = 1;
    $model->modo = 1;

    if($model->save())
    $this->redirect(array('admin'));
  }
  
  // Recupero la configuración de precios
  $modeloConfig = new Configprecio();
  $precioConfig = $modeloConfig->retornaConfiguracion(); 
  
  $this->render('create',array(
    'model'=>$model,
    'idSubrubro'=>$idSubrubro,
    'idMarca'=>$idMarca,
    'precioConfig'=>$precioConfig
  ));
}

public function actionActualizaPreciosRubro()
{
  $model=new Producto;
  $this->performAjaxValidation($model);
  if(isset($_POST['Producto']))
  {
    $model->attributes=$_POST['Producto'];
    $model->codigo = 'z';
    $model->nombre = 'a';
    $model->subRubro_idSubRubro = 1;
    $model->marca_idmarca = 1;
    $model->precioCosto = 1;
    $model->precioEfectivo = 1;
    $valid=$model->validate();
    if($valid){

      // Recupero la configuración de precios
      $modeloConfig = new Configprecio();
      $precioConfig = $modeloConfig->retornaConfiguracion();      

      $baseUrl = Yii::app()->baseUrl;
      $mPDF1 = Yii::app()->ePdf->mpdf();
      //Si el modo es 0 ejecuto la impresion de la lista de precios en modo prueba
      /*if($model->modo == 0)
      {*/
        $productos = Producto::model()->findAll(array('condition'=>'estado = 1 AND rubro_idRubro='.$model->rubro_idRubro, 'order'=>'nombre asc'));
        foreach($productos as $row)
        {
          $row->precioCosto = ($row->precioCosto * ($model->porcIncremento / 100)) + $row->precioCosto;
          $row->precioEfectivo = ($row->precioEfectivo * ($model->porcIncremento / 100)) + $row->precioEfectivo;
          $row->precio2 = ($row->precioEfectivo * ($precioConfig->incrementoPrecio2 / 100)) + $row->precioEfectivo;
          $row->precio3 = ($row->precioEfectivo * ($precioConfig->incrementoPrecio3 / 100)) + $row->precioEfectivo;
          /*$row->precio2 = ($row->precio2 * ($model->porcIncremento / 100)) + $row->precio2;
          $row->precio3 = ($row->precio3 * ($model->porcIncremento / 100)) + $row->precio3;*/
          if($model->modo == 1)
          {
            $row->update();
          }
        }

      //}

      include './protected/views/producto/listaPrecios.php';

      $this->redirect(array('admin'));
    }
    else{
      $error = CActiveForm::validate($model);
    }
}
$this->render('actualizaPrecioRubro', array(
  'model'=>$model,));
}


public function actionActualizaPreciosSubRubro()
{
  $model=new Producto;
  $this->performAjaxValidation($model);
  if(isset($_POST['Producto']))
  {
    $model->attributes=$_POST['Producto'];
    $model->codigo = 'z';
    $model->nombre = 'a';
    //$model->subRubro_idSubRubro = 1;
    $model->marca_idmarca = 1;
    $model->precioCosto = 1;
    $model->precioEfectivo = 1;
    $valid=$model->validate();
    if($valid){

      // Recupero la configuración de precios
      $modeloConfig = new Configprecio();
      $precioConfig = $modeloConfig->retornaConfiguracion();      

      $baseUrl = Yii::app()->baseUrl;
      $mPDF1 = Yii::app()->ePdf->mpdf();
      //Si el modo es 0 ejecuto la impresion de la lista de precios en modo prueba
      /*if($model->modo == 0)
      {*/
        $productos = Producto::model()->findAll(array('condition'=>'estado = 1 AND subRubro_idSubRubro='.$model->subRubro_idSubRubro, 'order'=>'nombre asc'));
        foreach($productos as $row)
        {
          $row->precioCosto = ($row->precioCosto * ($model->porcIncremento / 100)) + $row->precioCosto;
          $row->precioEfectivo = ($row->precioEfectivo * ($model->porcIncremento / 100)) + $row->precioEfectivo;
          $row->precio2 = ($row->precioEfectivo * ($precioConfig->incrementoPrecio2 / 100)) + $row->precioEfectivo;
          $row->precio3 = ($row->precioEfectivo * ($precioConfig->incrementoPrecio3 / 100)) + $row->precioEfectivo;
          /*$row->precio2 = ($row->precio2 * ($model->porcIncremento / 100)) + $row->precio2;
          $row->precio3 = ($row->precio3 * ($model->porcIncremento / 100)) + $row->precio3;*/
          if($model->modo == 1)
          {
            $row->update();
          }
        }

      //}

      include './protected/views/producto/listaPrecios.php';

      $this->redirect(array('admin'));
    }
    else{
      $error = CActiveForm::validate($model);
    }
}
$this->render('actualizaPrecioSubRubro', array(
  'model'=>$model,));
}


public function actionActualizaPreciosMasivo()
{
  $model=new Producto;
  $this->performAjaxValidation($model);
  if(isset($_POST['Producto']))
  {
    $model->attributes=$_POST['Producto'];
    $model->codigo = 1;
    $model->nombre = 'a';
    $model->rubro_idRubro = 1;
    $model->subRubro_idSubRubro = 1;
    $model->marca_idmarca = 1;
    $model->precioCosto = 1;
    $model->precioEfectivo = 1;
    $model->scenario = 'actualizaMasivo';
    $valid=$model->validate();
    if($valid){

      // Recupero la configuración de precios
      $modeloConfig = new Configprecio();
      $precioConfig = $modeloConfig->retornaConfiguracion();      

      $baseUrl = Yii::app()->baseUrl;
      $mPDF1 = Yii::app()->ePdf->mpdf();
      $productos = Producto::model()->findAll(array('condition'=>'estado = 1', 'order'=>'nombre asc'));
      foreach($productos as $row)
      {
        $row->precioCosto = ($row->precioCosto * ($model->porcIncremento / 100)) + $row->precioCosto;
        $row->precioEfectivo = ($row->precioEfectivo * ($model->porcIncremento / 100)) + $row->precioEfectivo;
        $row->precio2 = ($row->precioEfectivo * ($precioConfig->incrementoPrecio2 / 100)) + $row->precioEfectivo;
        $row->precio3 = ($row->precioEfectivo * ($precioConfig->incrementoPrecio3 / 100)) + $row->precioEfectivo;
        if($model->modo == 1)
        {
          $row->update();
        }
      }
      include './protected/views/producto/listaPrecios.php';

      $this->redirect(array('admin'));
    }
    else{
      $error = CActiveForm::validate($model);
    }
  }
  $this->render('actualizaPrecioMasivo', array(
    'model'=>$model,));
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

    if(isset($_POST['Producto']))
    {
      $model->attributes=$_POST['Producto'];
      $model->porcIncremento = 1;
      $model->modo = 1;
      if($model->save())
      $this->redirect(array('admin'));
    }
    $idMarca = $model->marca_idmarca;
    $idSubrubro = $model->subRubro_idSubRubro;

    // Recupero la configuración de precios
    $modeloConfig = new Configprecio();
    $precioConfig = $modeloConfig->retornaConfiguracion(); 
  
    $this->render('update',array(
      'model'=>$model,
      'idSubrubro'=>$idSubrubro,
      'idMarca'=>$idMarca,
      'precioConfig'=>$precioConfig
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
      #$this->loadModel($id)->delete();
      $modelo = $this->loadModel($id);
      $modelo->estado = 0;
      $modelo->save(false);
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
    $dataProvider=new CActiveDataProvider('Producto');
    $this->render('index',array(
      'dataProvider'=>$dataProvider,
    ));
  }

  /**
  * Manages all models.
  */
  public function actionAdmin()
  {
    $model=new Producto('search');
    $model->unsetAttributes();  // clear any default values
    if(isset($_GET['Producto']))
    $model->attributes=$_GET['Producto'];

    $this->render('admin',array(
      'model'=>$model,
    ));
  }

  public function actionPrint()
  {
    $baseUrl = Yii::app()->baseUrl;
    $mPDF1 = Yii::app()->ePdf->mpdf();
    /*$mPDF1 = Yii::app()->ePdf->mpdf('','A4',8,'dejavusans');
    $mPDF1 = Yii::app()->ePdf->mpdf('win-1252','LETTER','','',15,15,25,12,5,7);
    $mPDF1->SetDisplayMode('fullpage');
    $mPDF1->list_indent_first_level = 0;	// 1 or 0 - whether to indent the first level of a list
    $mPDF1->WriteHTML($stylesheet,1);	// The parameter 1 tells that this is css/style only and no body/html/text*/
    $productos = Producto::model()->findAll(array('condition'=>'estado = 1', 'order'=>'nombre asc'));
    include './protected/views/producto/listaPrecios.php';

  }




  public function actionActualizaPreciosMarca()
  {
    $model=new Producto;
    $this->performAjaxValidation($model);
    if(isset($_POST['Producto']))
    {
      $model->attributes=$_POST['Producto'];
      $model->codigo = 'z';
      $model->nombre = 'a';
      $model->subRubro_idSubRubro = 1;
      $model->rubro_idRubro = 1;
      $model->precioCosto = 1;
      $model->precioEfectivo = 1;
      $valid=$model->validate();
      if($valid){
  
        // Recupero la configuración de precios
        $modeloConfig = new Configprecio();
        $precioConfig = $modeloConfig->retornaConfiguracion();      
  
        $baseUrl = Yii::app()->baseUrl;
        $mPDF1 = Yii::app()->ePdf->mpdf();
        //Si el modo es 0 ejecuto la impresion de la lista de precios en modo prueba
        /*if($model->modo == 0)
        {*/
          $productos = Producto::model()->findAll(array('condition'=>'estado = 1 AND marca_idmarca='.$model->marca_idmarca, 'order'=>'nombre asc'));
          foreach($productos as $row)
          {
            $row->precioCosto = ($row->precioCosto * ($model->porcIncremento / 100)) + $row->precioCosto;
            $row->precioEfectivo = ($row->precioEfectivo * ($model->porcIncremento / 100)) + $row->precioEfectivo;
            $row->precio2 = ($row->precioEfectivo * ($precioConfig->incrementoPrecio2 / 100)) + $row->precioEfectivo;
            $row->precio3 = ($row->precioEfectivo * ($precioConfig->incrementoPrecio3 / 100)) + $row->precioEfectivo;
            /*$row->precio2 = ($row->precio2 * ($model->porcIncremento / 100)) + $row->precio2;
            $row->precio3 = ($row->precio3 * ($model->porcIncremento / 100)) + $row->precio3;*/
            if($model->modo == 1)
            {
              $row->update();
            }
          }
  
        //}
  
        include './protected/views/producto/listaPrecios.php';
  
        $this->redirect(array('admin'));
      }
      else{
        $error = CActiveForm::validate($model);
      }
    }
    $listaMarcas = Marca::getListaMarcas();
    $this->render('actualizaPrecioMarca', array(
      'model'=>$model, 'listaMarcas'=>$listaMarcas));
  }



  /**
  * Returns the data model based on the primary key given in the GET variable.
  * If the data model is not found, an HTTP exception will be raised.
  * @param integer the ID of the model to be loaded
  */
  public function loadModel($id)
  {
    $model=Producto::model()->findByPk($id);
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
    if(isset($_POST['ajax']) && $_POST['ajax']==='producto-form')
    {
      echo CActiveForm::validate($model);
      Yii::app()->end();
    }
  }
}
