<?php

/**
* This is the model class for table "localidad".
*
* The followings are the available columns in table 'localidad':
* @property integer $idlocalidad
* @property integer $codigoPostal
* @property integer $provincia_idprovincia
* @property string $nombre
* @property integer $estado
*
* The followings are the available model relations:
* @property Cliente[] $clientes
* @property Provincia $provinciaIdprovincia
*/
class Localidad extends CActiveRecord
{
	/**
	* @return string the associated database table name
	*/
	public function tableName()
	{
		return 'localidad';
	}

	/**
	* @return array validation rules for model attributes.
	*/
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('codigoPostal, provincia_idprovincia, nombre, estado', 'required'),
			array('codigoPostal, provincia_idprovincia, estado', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>45),
			// La siguiente regla se utiliza para validar que se haya seleccionado una provincia
			array('provincia_idprovincia', 'seleccionoProvincia'),
			// La siguiente regla se utiliza para validar que se haya seleccionado una provincia
			array('codigoPostal', 'codigoUsadoInsert', 'on'=>'insert'),
			array('codigoPostal', 'codigoUsadoUpdate', 'idActual'=>$this->idlocalidad, 'on'=>'update'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idlocalidad, codigoPostal, provincia_idprovincia, nombre, estado', 'safe', 'on'=>'search'),
		);
	}
	public function seleccionoProvincia($attribute)
	{
		if($this->$attribute == 0)
		{
			$this->addError($attribute, 'Debe seleccionar una provincia');
		}
	}

	public function codigoUsadoInsert($attribute)
	{
		$list= Yii::app()->db->createCommand('select * from localidad where codigoPostal=:codigo and estado=1')
													->bindValue(':codigo', $this->$attribute)
													->queryAll();
		if(!empty($list)){
			$this->addError($attribute, 'El código postal ya existe');
		}
	}

	public function codigoUsadoUpdate($attribute, $params)
	{
		$list= Yii::app()->db->createCommand('select * from localidad where codigoPostal=:codigo and estado=1 and idlocalidad=:id')
													->bindValue(':codigo', $this->$attribute)
													->bindValue(':id', $params['idActual'])
													->queryAll();
		if(empty($list)){
			//$this->addError($attribute, 'El código postal ya existe');
			$this->codigoUsadoInsert($attribute);
		}
	}
	
	/**
	* @return array relational rules.
	*/
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'clientes' => array(self::HAS_MANY, 'Cliente', 'localidad_idlocalidad'),
			'provincia' => array(self::BELONGS_TO, 'Provincia', 'provincia_idprovincia'),
		);
	}

	/**
	* @return array customized attribute labels (name=>label)
	*/
	public function attributeLabels()
	{
		return array(
			'idlocalidad' => 'Idlocalidad',
			'codigoPostal' => 'Código Postal',
			'provincia_idprovincia' => 'Provincia',
			'nombre' => 'Nombre',
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
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('idlocalidad',$this->idlocalidad);
		$criteria->compare('codigoPostal',$this->codigoPostal);
		#$criteria->compare('provincia_idprovincia',$this->provincia_idprovincia);
		$criteria->with =array('provincia');
		$criteria->addSearchCondition('provincia.nombre', $this->provincia_idprovincia);
		//$criteria->compare('nombre',$this->nombre,true);
		#$criteria->compare('estado',$this->estado);
		$criteria->compare('t.nombre',$this->nombre,true);
		$criteria->compare('t.estado', 1);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	* Returns the static model of the specified AR class.
	* Please note that you should have this exact method in all your CActiveRecord descendants!
	* @param string $className active record class name.
	* @return Localidad the static model class
	*/
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
