<?php

/**
 * This is the model class for table "consulta".
 *
 * The followings are the available columns in table 'consulta':
 * @property integer $idconsulta
 * @property string $fecha
 * @property integer $cliente_idcliente
 * @property integer $paciente_idpaciente
 * @property integer $tipoConsulta_idtipoConsulta
 * @property string $motivo
 * @property integer $estado
 *
 * The followings are the available model relations:
 * @property Cliente $clienteIdcliente
 * @property Paciente $pacienteIdpaciente
 * @property TipoConsulta $tipoConsultaIdtipoConsulta
 * @property DiagnosticoComplementario[] $diagnosticoComplementarios
 */
class Consulta extends CActiveRecord
{

	public $irDiagnosticoComplementario;
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'consulta';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('fecha, cliente_idcliente, paciente_idpaciente, tipoConsulta_idtipoConsulta, motivo, estado', 'required'),
			array('cliente_idcliente, paciente_idpaciente, tipoConsulta_idtipoConsulta, estado', 'numerical', 'integerOnly'=>true),
			array('irDiagnosticoComplementario', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('idconsulta, fecha, cliente_idcliente, paciente_idpaciente, tipoConsulta_idtipoConsulta, motivo, estado', 'safe', 'on'=>'search'),

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
			'clienteIdcliente' => array(self::BELONGS_TO, 'Cliente', 'cliente_idcliente'),
			'pacienteIdpaciente' => array(self::BELONGS_TO, 'Paciente', 'paciente_idpaciente'),
			'tipoConsultaIdtipoConsulta' => array(self::BELONGS_TO, 'TipoConsulta', 'tipoConsulta_idtipoConsulta'),
			'diagnosticoComplementarios' => array(self::HAS_MANY, 'DiagnosticoComplementario', 'consulta_idconsulta'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'idconsulta' => 'Idconsulta',
			'fecha' => 'Fecha',
			'cliente_idcliente' => 'Cliente',
			'paciente_idpaciente' => 'Paciente',
			'tipoConsulta_idtipoConsulta' => 'Tipo Consulta',
			'motivo' => 'Anamnesis',
			'estado' => 'Estado',
			'irDiagnosticoComplementario' => 'diagnostico',
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
		$criteria->compare('idconsulta',$this->idconsulta);
		$criteria->compare('fecha',$this->fecha,true);
		$criteria->compare('cliente_idcliente',$this->cliente_idcliente);
		$criteria->compare('paciente_idpaciente',$this->paciente_idpaciente);
		$criteria->with =array('tipoConsultaIdtipoConsulta');
		//$criteria->compare('tipoConsulta_idtipoConsulta',$this->tipoConsulta_idtipoConsulta);
		$criteria->addSearchCondition('tipoConsultaIdtipoConsulta.nombre', $this->tipoConsulta_idtipoConsulta);
		$criteria->compare('motivo',$this->motivo,true);
		//$criteria->compare('estado',$this->estado);
		$criteria->compare('t.estado', 1);

		$criteria->order = 't.fecha desc';

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria, 
		));
	}

	/**
	 * Función que retorna todas las consultas de un paciente dado
	 */
	public function buscarConsultas($idpaciente){
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;
		$criteria->compare('paciente_idpaciente',$idpaciente);
		$criteria->compare('t.estado', 1);
		return ($this::findAll($criteria));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Consulta the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
