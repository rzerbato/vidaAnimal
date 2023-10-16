<?php

/**
 * This is the model class for table "especie".
 *
 * The followings are the available columns in table 'especie':
 * @property integer $idespecie
 * @property string $nombre
 * @property integer $estado
 *
 * The followings are the available model relations:
 * @property Paciente[] $pacientes
 * @property Raza[] $razas
 */
class Especie extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'especie';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre, estado', 'required'),
			array('estado', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>45),
			array('nombre', 'nombreUsadoInsert', 'on'=>'insert'),
			array('nombre', 'nombreUsadoUpdate', 'idActual'=>$this->idespecie, 'on'=>'update'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idespecie, nombre, estado', 'safe', 'on'=>'search'),
		);
	}

	public function nombreUsadoInsert($attribute)
		{
			$list= Yii::app()->db->createCommand('select * from especie where nombre=:nombre and estado=1')
														->bindValue(':nombre', $this->$attribute)
														->queryAll();
			if(!empty($list)){
				$this->addError($attribute, 'La especie ya existe');
			}
		}

		public function nombreUsadoUpdate($attribute, $params)
		{
			$list= Yii::app()->db->createCommand('select * from especie where nombre=:nombre and estado=1 and idespecie=:id')
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
			'pacientes' => array(self::HAS_MANY, 'Paciente', 'especie_idespecie'),
			'razas' => array(self::HAS_MANY, 'Raza', 'especie_idespecie'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idespecie' => 'Idespecie',
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
		Yii::log("Le dio al buscar: ", CLogger::LEVEL_WARNING, __METHOD__);
		$criteria=new CDbCriteria;
		$criteria->compare('idespecie',$this->idespecie);
		$criteria->compare('nombre',$this->nombre,true);
#		$criteria->compare('estado',$this->estado);
		$criteria->compare('estado',1);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}


	public function buscar()
	{
		
		
		$criteria=new CDbCriteria;
		$criteria->compare('estado',1);
		return new CActiveDataProvider($this, array(
                    'criteria'=>$criteria,
		));
	}

	/**
	* [getListaEspecies description]
	* @param  [type] $clave [description]
	* @return [type]        [description]
	*/
	public static function getListaEspecies($clave)
	{
		return CHtml::listdata(Especie::model()->findAll(array('condition'=>'estado = 1', 'order'=>'nombre asc')), $clave, 'nombre');
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Especie the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
