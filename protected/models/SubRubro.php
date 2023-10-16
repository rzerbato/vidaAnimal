<?php

/**
 * This is the model class for table "subRubro".
 *
 * The followings are the available columns in table 'subRubro':
 * @property integer $idSubRubro
 * @property string $nombre
 * @property integer $rubro_idRubro
 * @property integer $estado
 *
 * The followings are the available model relations:
 * @property Producto[] $productos
 * @property Rubro $rubroIdRubro
 */
class SubRubro extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'subRubro';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre, rubro_idRubro, estado', 'required'),
			array('rubro_idRubro, estado', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>45),
			array('rubro_idRubro', 'seleccionoRubro'),
			array('nombre', 'nombreUsadoInsert', 'on'=>'insert'),
			array('nombre', 'nombreUsadoUpdate', 'idActual'=>$this->idSubRubro, 'on'=>'update'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idSubRubro, nombre, rubro_idRubro, estado', 'safe', 'on'=>'search'),
		);
	}

	public function seleccionoRubro($attribute)
	{
		if($this->$attribute == 0)
		{
			$this->addError($attribute, 'Debe seleccionar un Rubro');
		}
	}

	public function nombreUsadoInsert($attribute)
	{
		$list= Yii::app()->db->createCommand('select * from subRubro where nombre=:nombre and estado=1 and rubro_idRubro=:rubro')
													->bindValue(':nombre', $this->$attribute)
													->bindValue(':rubro', $this->rubro_idRubro)
													->queryAll();
		if(!empty($list)){
			$this->addError($attribute, 'El subrubro ya existe para el rubro seleccionado');
		}
	}

	public function nombreUsadoUpdate($attribute, $params)
	{
		$list= Yii::app()->db->createCommand('select * from subRubro where nombre=:nombre and estado=1 and idsubRubro=:id and rubro_idRubro=:rubro')
													->bindValue(':nombre', $this->$attribute)
													->bindValue(':rubro', $this->rubro_idRubro)
													->bindValue(':id', $params['idActual'])
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
			'productos' => array(self::HAS_MANY, 'Producto', 'subRubro_idSubRubro'),
			'rubroIdRubro' => array(self::BELONGS_TO, 'Rubro', 'rubro_idRubro'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idSubRubro' => 'Id Sub Rubro',
			'nombre' => 'Nombre',
			'rubro_idRubro' => 'Rubro',
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

		$criteria->compare('idSubRubro',$this->idSubRubro);
		$criteria->compare('t.nombre',$this->nombre,true);
		//$criteria->compare('rubro_idRubro',$this->rubro_idRubro);
		$criteria->with =array('rubroIdRubro');
		$criteria->addSearchCondition('rubroIdRubro.nombre', $this->rubro_idRubro);
		//$criteria->compare('estado',$this->estado);
		$criteria->compare('t.estado', 1);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return SubRubro the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
