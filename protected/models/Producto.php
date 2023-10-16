<?php

/**
 * This is the model class for table "producto".
 *
 * The followings are the available columns in table 'producto':
 * @property integer $idproducto
 * @property string $codigo
 * @property string $nombre
 * @property integer $rubro_idRubro
 * @property integer $subRubro_idSubRubro
 * @property integer $marca_idmarca
 * @property double $precioCosto
 * @property double $precioEfectivo
 * @property double $precio2
 * @property double $precio3
 * @property integer $estado
 * @property double porcIncremento
 * @property integer modo
 *
 * The followings are the available model relations:
 * @property Marca $marcaIdmarca
 * @property Rubro $rubroIdRubro
 * @property SubRubro $subRubroIdSubRubro
 */
class Producto extends CActiveRecord
{

	public $porcIncremento;
	public $modo;

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'producto';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('codigo, nombre, subRubro_idSubRubro, marca_idmarca, precioCosto, precioEfectivo, porcIncremento, modo', 'required'),
			array('rubro_idRubro, subRubro_idSubRubro, marca_idmarca, estado', 'numerical', 'integerOnly'=>true),
			array('codigo', 'codigoUsadoInsert', 'on'=>'insert'),
			array('codigo', 'codigoUsadoUpdate', 'idActual'=>$this->idproducto, 'on'=>'update'),
			array('precioCosto, precioEfectivo, precio2, precio3, porcIncremento', 'numerical'),
			array('codigo', 'length', 'max'=>20),
			array('nombre', 'length', 'max'=>45),
			array('rubro_idRubro', 'SeleccionoRubro'),
			array('subRubro_idSubRubro', 'SeleccionoSubrubro'),
			array('marca_idmarca', 'SeleccionoMarca'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idproducto, codigo, nombre, rubro_idRubro, subRubro_idSubRubro, marca_idmarca, precioCosto, precioEfectivo, precio2, precio3, estado', 'safe', 'on'=>'search'),
		);
	}

	public function codigoUsadoInsert($attribute)
	{
		$list= Yii::app()->db->createCommand('select * from producto where codigo=:codigo and estado=1')
													->bindValue(':codigo', $this->$attribute)
													->queryAll();
		if(!empty($list)){
			$this->addError($attribute, 'El código ya existe');
		}
	}

	public function codigoUsadoUpdate($attribute, $params)
	{
		$list= Yii::app()->db->createCommand('select * from producto where codigo=:codigo and estado=1 and idproducto=:id')
													->bindValue(':codigo', $this->$attribute)
													->bindValue(':id', $params['idActual'])
													->queryAll();
		if(empty($list)){
			//$this->addError($attribute, 'El código postal ya existe');
			$this->codigoUsadoInsert($attribute);
		}
	}

	public function SeleccionoRubro($attribute)
	{
		if($this->$attribute == 0)
		{
			$this->addError($attribute, 'Debe seleccionar un rubro');
		}
	}

	public function SeleccionoSubrubro($attribute)
	{
		if($this->$attribute == 0)
		{
			$this->addError($attribute, 'Debe seleccionar un subrubro');
		}
	}

	public function SeleccionoMarca($attribute)
	{
		if($this->$attribute == 0)
		{
			$this->addError($attribute, 'Debe seleccionar una marca');
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
			'marcaIdmarca' => array(self::BELONGS_TO, 'Marca', 'marca_idmarca'),
			'rubroIdRubro' => array(self::BELONGS_TO, 'Rubro', 'rubro_idRubro'),
			'subRubroIdSubRubro' => array(self::BELONGS_TO, 'SubRubro', 'subRubro_idSubRubro'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idproducto' => 'Idproducto',
			'codigo' => 'Codigo',
			'nombre' => 'Nombre',
			'rubro_idRubro' => 'Rubro',
			'subRubro_idSubRubro' => 'Subrubro',
			'marca_idmarca' => 'Marca',
			'precioCosto' => 'Precio Costo',
			'precioEfectivo' => 'Precio Efectivo',
			'precio2' => 'Precio2',
			'precio3' => 'Precio3',
			'estado' => 'Estado',
			'porcIncremento'=> 'Incremento %',
			'modo' => 'Modo Ejecución',
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

		$criteria->compare('idproducto',$this->idproducto);
		$criteria->compare('codigo',$this->codigo,true);
		$criteria->compare('t.nombre',$this->nombre,true);
		//$criteria->compare('rubro_idRubro',$this->rubro_idRubro);
		$criteria->with =array('rubroIdRubro','subRubroIdSubRubro','marcaIdmarca');
		$criteria->addSearchCondition('rubroIdRubro.nombre', $this->rubro_idRubro);
		//$criteria->compare('subRubro_idSubRubro',$this->subRubro_idSubRubro);
		$criteria->addSearchCondition('subRubroIdSubRubro.nombre', $this->subRubro_idSubRubro);
		//$criteria->compare('marca_idmarca',$this->marca_idmarca);
		$criteria->addSearchCondition('marcaIdmarca.nombre', $this->marca_idmarca);
		$criteria->compare('precioCosto',$this->precioCosto);
		$criteria->compare('precioEfectivo',$this->precioEfectivo);
		$criteria->compare('precio2',$this->precio2);
		$criteria->compare('precio3',$this->precio3);
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
	 * @return Producto the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
