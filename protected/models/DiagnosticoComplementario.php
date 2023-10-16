<?php

/**
 * This is the model class for table "diagnosticocomplementario".
 *
 * The followings are the available columns in table 'diagnosticocomplementario':
 * @property integer $iddiagnosticoComplementario
 * @property integer $consulta_idconsulta
 * @property string $descripcion
 * @property string $archivo
 * @property integer $estado
 *
 * The followings are the available model relations:
 * @property Consulta $consultaIdconsulta
 */
class Diagnosticocomplementario extends CActiveRecord
{

	public $imagen;

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'diagnosticocomplementario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('consulta_idconsulta, archivo, estado', 'required'),
			array('consulta_idconsulta, estado', 'numerical', 'integerOnly'=>true),
			array('descripcion', 'length', 'max'=>45),
			/*array('imagen', 'file', 'types'=>'jpg, png, jpeg, gif, bmp, pdf', 'allowEmpty' => true, 
			'maxSize' => 200000,'tooLarge' => ('Logo file size should be less than 200 KB')),*/
			array('imagen', 'file', 'types'=>'jpg, png, jpeg, gif, bmp, pdf', 'allowEmpty' => true, 
			'maxSize' => 100*(1024*1024),'tooLarge' => ('Archivo demasiado grande')),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('iddiagnosticoComplementario, consulta_idconsulta, descripcion, archivo, estado', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'consultaIdconsulta' => array(self::BELONGS_TO, 'Consulta', 'consulta_idconsulta'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'iddiagnosticoComplementario' => 'Iddiagnostico Complementario',
			'consulta_idconsulta' => 'Consulta Idconsulta',
			'descripcion' => 'Descripcion',
			'archivo' => 'Archivo',
			'imagen'=>'Imagen',
			'estado' => 'Estado',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search($idConsulta)
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('iddiagnosticoComplementario',$this->iddiagnosticoComplementario);
		//$criteria->compare('consulta_idconsulta',$this->consulta_idconsulta);
		$criteria->compare('consulta_idconsulta',$idConsulta);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('archivo',$this->archivo,true);
		$criteria->compare('estado', 1);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	public static function tieneDiagnosticoComplementario($idConsulta){
		
		$query = Yii::app()->db->createCommand()
			  ->select('iddiagnosticoComplementario')
			  ->from('diagnosticocomplementario')
			  ->where('consulta_idconsulta=:consulta_idconsulta', array(':consulta_idconsulta'=>$idConsulta))
			  ->queryRow();
		
		if($query){
			return true;
		}
		return false;
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Diagnosticocomplementario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
