<?php

/**
 * This is the model class for table "raza".
 *
 * The followings are the available columns in table 'raza':
 * @property integer $idraza
 * @property integer $especie_idespecie
 * @property string $nombre
 * @property integer $estado
 *
 * The followings are the available model relations:
 * @property Paciente[] $pacientes
 * @property Especie $especieIdespecie
 */
class Raza extends CActiveRecord
{

	public $especie_nombre;

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'raza';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			//array('especie_idespecie, nombre, estado', 'required'),
			array('especie_nombre, nombre, estado', 'required'),
			array('especie_idespecie, estado', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>45),
			array('especie_nombre', 'existeEspecie'),
			array('nombre', 'nombreUsadoInsert', 'on'=>'insert'),
			array('nombre', 'nombreUsadoUpdate', 'idActual'=>$this->idraza, 'on'=>'update'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idraza, especie_idespecie, nombre, estado', 'safe', 'on'=>'search'),
		);
	}

	public function existeEspecie($attribute)
	{
		$list= Yii::app()->db->createCommand('select * from especie where nombre=:nombre and estado=1')
													->bindValue(':nombre', $this->$attribute)
													->queryAll();
		if(empty($list)){
			$this->addError($attribute, 'La especie no existe');
		}
	}

	public function nombreUsadoInsert($attribute)
	{
		Yii::log("Esto tiene especie ".$this->especie_idespecie."pepe", CLogger::LEVEL_WARNING, __METHOD__);
		$list= Yii::app()->db->createCommand('select * from raza where nombre=:nombre and estado=1 and especie_idespecie=:especie')
													->bindValue(':nombre', $this->$attribute)
													->bindValue(':especie', $this->especie_idespecie)
													->queryAll();



		if(!empty($list)){
			$this->addError($attribute, 'La raza ya existe para la especie seleccionada');
		}
	}

	public function nombreUsadoUpdate($attribute, $params)
	{
		$list= Yii::app()->db->createCommand('select * from raza where nombre=:nombre and estado=1 and idraza=:id and especie_idespecie=:especie')
													->bindValue(':nombre', $this->$attribute)
													->bindValue(':id', $params['idActual'])
													->bindValue(':especie', $this->especie_idespecie)
													->queryAll();
		if(empty($list)){
			//$this->addError($attribute, 'El código postal ya existe');
			$this->nombreUsadoInsert($attribute);
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
			'pacientes' => array(self::HAS_MANY, 'Paciente', 'raza_idraza'),
			'especie' => array(self::BELONGS_TO, 'Especie', 'especie_idespecie'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idraza' => 'Idraza',
			'especie_idespecie' => 'Especie',
			'especie_nombre' => 'Especie',
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
		
		$criteria->compare('idraza',$this->idraza);
		//$criteria->compare('especie_idespecie',$this->especie_idespecie);
		$criteria->compare('t.nombre',$this->nombre,true);
		#$criteria->compare('estado',$this->estado);
		$criteria->compare('t.estado', 1);
		$criteria->with =array('especie');
		$criteria->addSearchCondition('especie.nombre', $this->especie_idespecie);
		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Raza the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
