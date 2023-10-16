<?php

/**
 * This is the model class for table "paciente".
 *
 * The followings are the available columns in table 'paciente':
 * @property integer $idpaciente
 * @property integer $cliente_idcliente
 * @property string $nombre
 * @property string $pacientecol
 * @property integer $especie_idespecie
 * @property integer $raza_idraza
 * @property string $sexo
 * @property string $fechaNacimiento
 * @property string $observacion
 * @property string $señaParticular
 * @property string $foto
 * @property integer $estado
 *
 * The followings are the available model relations:
 * @property Consulta[] $consultas
 * @property Cliente $clienteIdcliente
 * @property Especie $especieIdespecie
 * @property Raza $razaIdraza
 */
class Paciente extends CActiveRecord
{

	public $imagen;

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'paciente';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('cliente_idcliente, nombre, especie_idespecie, raza_idraza, sexo, estado', 'required'),
			array('cliente_idcliente, especie_idespecie, raza_idraza, estado', 'numerical', 'integerOnly'=>true),
			array('nombre, pacientecol', 'length', 'max'=>45),
			array('sexo', 'length', 'max'=>9),
			array('señaParticular', 'length', 'max'=>100),
			array('fechaNacimiento, observacion, foto', 'safe'),
			//array('imagen', 'file', 'types'=>'jpg, png, jpeg, gif, bmp', 'allowEmpty' => true),
			/*array('imagen', 'file', 'types'=>'jpg, png, jpeg, gif, bmp', 'allowEmpty' => true, 
			'maxSize' => 200000,'tooLarge' => ('Logo file size should be less than 200 KB')),*/
			array('imagen', 'file', 'types'=>'jpg, png, jpeg, gif, bmp', 'allowEmpty' => true, 
			'maxSize' => 100*(1024*1024),'tooLarge' => ('Archivo demasiado grande')),
			
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idpaciente, cliente_idcliente, nombre, pacientecol, especie_idespecie, raza_idraza, sexo, fechaNacimiento, observacion, señaParticular, foto, estado', 'safe', 'on'=>'search'),
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
			'consultas' => array(self::HAS_MANY, 'Consulta', 'paciente_idpaciente'),
			'clienteIdcliente' => array(self::BELONGS_TO, 'Cliente', 'cliente_idcliente'),
			'especieIdespecie' => array(self::BELONGS_TO, 'Especie', 'especie_idespecie'),
			'razaIdraza' => array(self::BELONGS_TO, 'Raza', 'raza_idraza'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idpaciente' => 'Idpaciente',
			'cliente_idcliente' => 'Cliente',
			'nombre' => 'Paciente',
			'pacientecol' => 'Pacientecol',
			'especie_idespecie' => 'Especie',
			'raza_idraza' => 'Raza',
			'sexo' => 'Sexo',
			'fechaNacimiento' => 'Fecha Nacimiento',
			'observacion' => 'Observacion',
			'señaParticular' => 'Seña Particular',
			'foto' => 'Foto',
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
	public function search() 
	{
		$criteria = new CDbCriteria;
		$criteria->with = array('especieIdespecie', 'clienteIdcliente', 'razaIdraza');
		$criteria->compare('especieIdespecie.nombre', $this->especie_idespecie, true);
		$criteria->compare('clienteIdcliente.nombre', $this->cliente_idcliente, true);
		$criteria->compare('razaIdraza.nombre', $this->raza_idraza);
		$criteria->compare('sexo',$this->sexo,true);
		$criteria->compare('t.nombre', $this->nombre, true);
		$criteria->compare('señaParticular',$this->señaParticular,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
	public function searchOLD()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('idpaciente',$this->idpaciente);

		$criteria->with =array('clienteIdcliente', 'especieIdespecie');
		$criteria->with =array('especieIdespecie', 'razaIdraza');

		//NUEVO
		$criteria->together = true;

		//$criteria->compare('cliente_idcliente',$this->cliente_idcliente);
		
		//NUEVO
		$criteria->with = 'clienteIdcliente';

		
		$criteria->addSearchCondition('clienteIdcliente.nombre', $this->cliente_idcliente);
		$criteria->compare('t.nombre',$this->nombre,true);
		$criteria->compare('pacientecol',$this->pacientecol,true);
		

		//$criteria->compare('especie_idespecie',$this->especie_idespecie);
		$criteria->addSearchCondition('especieIdespecie.nombre', $this->especie_idespecie);
		//$criteria->compare('raza_idraza',$this->raza_idraza);
		$criteria->addSearchCondition('razaIdraza.nombre', $this->raza_idraza);

		$criteria->compare('sexo',$this->sexo,true);
		$criteria->compare('fechaNacimiento',$this->fechaNacimiento,true);
		$criteria->compare('observacion',$this->observacion,true);
		$criteria->compare('señaParticular',$this->señaParticular,true);
		$criteria->compare('foto',$this->foto,true);
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
	 * @return Paciente the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
