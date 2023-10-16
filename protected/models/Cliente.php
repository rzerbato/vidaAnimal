<?php

/**
 * This is the model class for table "cliente".
 *
 * The followings are the available columns in table 'cliente':
 * @property integer $idcliente
 * @property integer $numeroDocumento
 * @property integer $tipoDocumento_idtipoDocumento
 * @property string $nombre
 * @property string $direccion
 * @property integer $provincia_idprovincia
 * @property integer $localidad_idlocalidad
 * @property string $telefonoFijo
 * @property string $telefonoCelular
 * @property string $email
 * @property integer $estado
 *
 * The followings are the available model relations:
 * @property Localidad $localidadIdlocalidad
 * @property Provincia $provinciaIdprovincia
 * @property TipoDocumento $tipoDocumentoIdtipoDocumento
 * @property Consulta[] $consultas
 * @property Paciente[] $pacientes
 */
class Cliente extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'cliente';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			//array('numeroDocumento, tipoDocumento_idtipoDocumento, nombre, provincia_idprovincia, localidad_idlocalidad, direccion', 'required'),
			array('nombre, provincia_idprovincia, localidad_idlocalidad, direccion', 'required'),
			array('numeroDocumento, tipoDocumento_idtipoDocumento, provincia_idprovincia, localidad_idlocalidad, estado', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>80),
			array('direccion, email', 'length', 'max'=>50),
			array('telefonoFijo, telefonoCelular', 'length', 'max'=>15),
			array('numeroDocumento', 'unique'),
			array('email','email'),
			array('tipoDocumento_idtipoDocumento', 'seleccionoTipoDocumento'),
			array('provincia_idprovincia', 'seleccionoProvincia'),
			array('localidad_idlocalidad', 'seleccionoLocalidad'),
			array('numeroDocumento', 'longitudNroDocumento', 'cliente'=>$this),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idcliente, numeroDocumento, tipoDocumento_idtipoDocumento, nombre, direccion, provincia_idprovincia, localidad_idlocalidad, telefonoFijo, telefonoCelular, email, estado', 'safe', 'on'=>'search'),
		);
	}
	public function seleccionoTipoDocumento($attribute)
	{
		if($this->$attribute == 0)
		{
			$this->addError($attribute, 'Debe seleccionar un tipo de documento');
		}
	}

	public function seleccionoProvincia($attribute)
	{
		if($this->$attribute == 0)
		{
			$this->addError($attribute, 'Debe seleccionar una provincia');
		}
	}


		public function seleccionoLocalidad($attribute)
		{
			if($this->$attribute == 0)
			{
				$this->addError($attribute, 'Debe seleccionar una localidad');
			}
		}

		public function longitudNroDocumento($attribute, $params)
		{
			/**
			 * ESTO SE COMENTÓ PARA QUE SE PUEDIERAN CARGAR LAS FICHAS AL MOMENTO 1
			 */
			/*$tipoDocumento = TipoDocumento::model()->findByPK($params['cliente']->tipoDocumento_idtipoDocumento);

			if ($tipoDocumento['nombre'] == 'DNI')
			{
				if($params['cliente']->numeroDocumento > 99999999 or ($params['cliente']->numeroDocumento < 1000000 and $params['cliente']->numeroDocumento != 0))
				{
					$this->addError($attribute, 'Número de documento erróneo');
				}
			}else {
				if ($tipoDocumento['nombre'] == 'CUIT' or $tipoDocumento['nombre'] == 'CUIL	')
				{
					if($params['cliente']->numeroDocumento > 99999999999 or ($params['cliente']->numeroDocumento < 10000000000 and $params['cliente']->numeroDocumento != 0))
					{
						$this->addError($attribute, 'Número de documento erróneo');
					}
				}
			}*/
		}


	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'localidadIdlocalidad' => array(self::BELONGS_TO, 'Localidad', 'localidad_idlocalidad'),
			'provinciaIdprovincia' => array(self::BELONGS_TO, 'Provincia', 'provincia_idprovincia'),
			'tipoDocumentoIdtipoDocumento' => array(self::BELONGS_TO, 'TipoDocumento', 'tipoDocumento_idtipoDocumento'),
			'consultas' => array(self::HAS_MANY, 'Consulta', 'cliente_idcliente'),
			'pacientes' => array(self::HAS_MANY, 'Paciente', 'cliente_idcliente'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idcliente' => 'Idcliente',
			'numeroDocumento' => 'Número de Documento',
			'tipoDocumento_idtipoDocumento' => 'Tipo Doc.',
			'nombre' => 'Nombre',
			'direccion' => 'Dirección',
			'provincia_idprovincia' => 'Provincia',
			'localidad_idlocalidad' => 'Localidad',
			'telefonoFijo' => 'Teléfono Fijo',
			'telefonoCelular' => 'Teléfono Celular',
			'email' => 'E-mail',
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

		$criteria->compare('idcliente',$this->idcliente);
		$criteria->compare('numeroDocumento',$this->numeroDocumento);
		#$criteria->compare('tipoDocumento_idtipoDocumento',$this->tipoDocumento_idtipoDocumento);
		$criteria->with =array('provinciaIdprovincia','localidadIdlocalidad','tipoDocumentoIdtipoDocumento');

		$criteria->addSearchCondition('tipoDocumentoIdtipoDocumento.nombre', $this->tipoDocumento_idtipoDocumento);

		$criteria->compare('t.nombre',$this->nombre,true);
		$criteria->compare('direccion',$this->direccion,true);

		#$criteria->compare('provincia_idprovincia',$this->provincia_idprovincia);

		//$criteria->with =array('provinciaIdprovincia');
		$criteria->addSearchCondition('provinciaIdprovincia.nombre', $this->provincia_idprovincia);

		#$criteria->compare('localidad_idlocalidad',$this->localidad_idlocalidad);
		//$criteria->with =array('localidadIdlocalidad');
		$criteria->addSearchCondition('localidadIdlocalidad.nombre', $this->localidad_idlocalidad);

		$criteria->compare('telefonoFijo',$this->telefonoFijo,true);
		$criteria->compare('telefonoCelular',$this->telefonoCelular,true);
		$criteria->compare('email',$this->email,true);
		#$criteria->compare('estado',$this->estado);
		$criteria->compare('t.estado',1);

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
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Cliente the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
