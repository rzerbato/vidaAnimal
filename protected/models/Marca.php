<?php

/**
 * This is the model class for table "marca".
 *
 * The followings are the available columns in table 'marca':
 * @property integer $idmarca
 * @property string $nombre
 * @property integer $rubro_idRubro
 * @property integer $estado
 *
 * The followings are the available model relations:
 * @property Rubro $rubroIdRubro
 * @property Producto[] $productos
 */
class Marca extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'marca';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre, rubro_idRubro', 'required'),
			array('rubro_idRubro, estado', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>45),
			array('rubro_idRubro', 'seleccionoRubro'),
			array('nombre', 'nombreUsadoInsert', 'on'=>'insert'),
			array('nombre', 'nombreUsadoUpdate', 'idActual'=>$this->idmarca, 'on'=>'update'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idmarca, nombre, rubro_idRubro, estado', 'safe', 'on'=>'search'),
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
		$list= Yii::app()->db->createCommand('select * from marca where nombre=:nombre and estado=1 and rubro_idRubro=:rubro')
													->bindValue(':nombre', $this->$attribute)
													->bindValue(':rubro', $this->rubro_idRubro)
													->queryAll();
		if(!empty($list)){
			$this->addError($attribute, 'La marca ya existe para el rubro seleccionado');
		}
	}

	public function nombreUsadoUpdate($attribute, $params)
	{
		$list= Yii::app()->db->createCommand('select * from marca where nombre=:nombre and estado=1 and idmarca=:id and rubro_idRubro=:rubro')
													->bindValue(':nombre', $this->$attribute)
													->bindValue(':rubro', $this->rubro_idRubro)
													->bindValue(':id', $params['idActual'])
													->queryAll();
		if(empty($list)){
			//$this->addError($attribute, 'El código postal ya existe');
			$this->nombreUsadoInsert($attribute);
		}
	}




	public function getListaMarcas()
	{
		$data = Marca::model()->findAll(array('condition'=>'estado = 1', 'order'=>'nombre asc'));
		$marcas = array();
		foreach ($data as $marca) {
			$marcas[$marca->idmarca] = $marca->nombre; // Reemplaza "id" y "nombre" con los nombres de los atributos de tu modelo real
		}
		
		
		return $marcas;


		//return CHtml::listdata(Rubro::model()->findAll(array('order'=>'nombre asc')), $clave, 'nombre');
	}


	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'rubroIdRubro' => array(self::BELONGS_TO, 'Rubro', 'rubro_idRubro'),
			'productos' => array(self::HAS_MANY, 'Producto', 'marca_idmarca'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idmarca' => 'Idmarca',
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

		$criteria->compare('idmarca',$this->idmarca);
		$criteria->compare('t.nombre',$this->nombre,true);
		//$criteria->compare('rubro_idRubro',$this->rubro_idRubro);
		$criteria->with =array('rubroIdRubro');
		$criteria->addSearchCondition('rubroIdRubro.nombre', $this->rubro_idRubro);
		#$criteria->compare('estado',$this->estado);
		$criteria->compare('t.estado', 1);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}


	

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Marca the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
