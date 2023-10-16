<?php

/**
 * This is the model class for table "rubro".
 *
 * The followings are the available columns in table 'rubro':
 * @property integer $idRubro
 * @property string $nombre
 * @property integer $estado
 *
 * The followings are the available model relations:
 * @property Marca[] $marcas
 * @property Producto[] $productos
 * @property SubRubro[] $subRubros
 */
class Rubro extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'rubro';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre', 'required'),
			array('estado', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>45),
			array('nombre', 'nombreUsadoInsert', 'on'=>'insert'),
			array('nombre', 'nombreUsadoUpdate', 'idActual'=>$this->idRubro, 'on'=>'update'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idRubro, nombre, estado', 'safe', 'on'=>'search'),
		);
	}

	public function nombreUsadoInsert($attribute)
		{
			$list= Yii::app()->db->createCommand('select * from rubro where nombre=:nombre and estado=1')
														->bindValue(':nombre', $this->$attribute)
														->queryAll();
			if(!empty($list)){
				$this->addError($attribute, 'El rubro ya existe');
			}
		}

		public function nombreUsadoUpdate($attribute, $params)
		{
			$list= Yii::app()->db->createCommand('select * from rubro where nombre=:nombre and estado=1 and idrubro=:id')
														->bindValue(':nombre', $this->$attribute)
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
			'marcas' => array(self::HAS_MANY, 'Marca', 'rubro_idRubro'),
			'productos' => array(self::HAS_MANY, 'Producto', 'rubro_idRubro'),
			'subRubros' => array(self::HAS_MANY, 'SubRubro', 'rubro_idRubro'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idRubro' => 'Rubro',
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

		$criteria->compare('idRubro',$this->idRubro);
		$criteria->compare('nombre',$this->nombre,true);
		#$criteria->compare('estado',$this->estado);
		$criteria->compare('estado', 1);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	public function getListaRubros($clave)
	{
		$models = Rubro::model()->findAll(array('condition'=>'estado = 1', 'order'=>'nombre asc'));

     // format models resulting using listData
     return CHtml::listData($models,
                'idRubro', 'nombre');


		//return CHtml::listdata(Rubro::model()->findAll(array('order'=>'nombre asc')), $clave, 'nombre');
	}

	public function buscar()
		{
			$criteria=new CDbCriteria;
			$criteria->compare('estado',1);
			return new CActiveDataProvider($this, array(
	                    'criteria'=>$criteria,
			));
		}

		public function getListadoRubros($clave)
		{
			return CHtml::listdata(Rubro::model()->findAll(array('condition'=>'estado = 1', 'order'=>'nombre asc')), $clave, 'nombre');
		}
	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Rubro the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
