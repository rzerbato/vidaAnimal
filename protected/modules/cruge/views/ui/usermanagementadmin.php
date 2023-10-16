
<div class="form">
<h1><?php echo ucwords('Administrar Usuarios');?></h1>
<?php
$this->menu=array(
	//array('label'=>'Listar Articulo','icon'=>'list','url'=>array('index')),
	array('label'=>'<i class="fa fa-plus fa-fw"></i> Crear Usuario','url'=>array('usermanagementcreate')),
	array('label'=>'<i class="fa fa-briefcase fa-fw"></i> Admin. Roles','url'=>array('rbaclistroles')),
	array('label'=>'<i class="fa fa-share-square fa-fw"></i> Asignar Roles','url'=>array('rbacusersassignments')),
	array('label'=>'<i class="fa fa-exclamation-triangle fa-fw"></i> Variables de Sistema','url'=>array('systemupdate')),

);



/*
	para darle los atributos al CGridView de forma de ser consistente con el sistema Cruge
	es mejor preguntarle al Factory por los atributos disponibles, esto es porque si se decide
	cambiar la clase de CrugeStoredUser por otra entonces asi no haya dependenci directa a los
	campos.
*/
$cols = array();

// presenta los campos de ICrugeStoredUser

foreach(Yii::app()->user->um->getSortFieldNamesForICrugeStoredUser() as $key=>$fieldName){
	$value=null; // default
	$filter=null; // default, textbox
	$type='text';
	if($fieldName == 'state'){
		$value = '$data->getStateName()';
		$filter = Yii::app()->user->um->getUserStateOptions();
	}
	if($fieldName == 'logondate'){
		$type='datetime';
	}
	//El IF es CUSTOM
	if($fieldName != 'iduser'){ 	
		$cols[] = array('name'=>$fieldName,'value'=>$value,'filter'=>$filter,'type'=>$type);
	}
}

$cols[] = array(
	'class'=>'CButtonColumn',
	//'class'=>'booster.widgets.TbButtonColumn',
	'template' => '{update} {eliminar}',
	'deleteConfirmation'=>CrugeTranslator::t('admin', '¿Está seguro de eliminar este usuario?'),
	'buttons' => array(
			'update'=>array(
				'label'=>'Actualizar Usuario',
				'url'=>'array("usermanagementupdate","id"=>$data->getPrimaryKey())'
			),
			'eliminar'=>array(
				'label'=>'Eliminar Usuario',
				'imageUrl'=>Yii::app()->user->ui->getResource("delete.png"),
				'url'=>'array("usermanagementdelete","id"=>$data->getPrimaryKey())',
				'options' => array('class' => 'delete')
			),
		),
);

//var_dump($dataProvider);
/*$this->widget(Yii::app()->user->ui->CGridViewClass,
	array(
	'type' => 'striped bordered condensed',
    'dataProvider'=>$dataProvider,
	'template' => "{items}",
    'columns'=>$cols,
	'filter'=>$model,
));*/

?>

<div class="row">
	<div class="col-md-11 col-xs-12">
<?php
$this->widget('booster.widgets.TbGridView',array(
	
	'dataProvider'=>$dataProvider,
	'filter'=>$model,
	'type' => 'striped bordered condensed',
	'template' => "{summary}{items}{pager}",
	'columns'=>array(	
		'username',		
		'password',
		'email',
		'state',
		array(
			'class'=>'booster.widgets.TbButtonColumn',
			'template' => '{update} {delete}',
			'deleteConfirmation'=>CrugeTranslator::t('admin', '¿Está seguro de eliminar este usuario?'),
			'buttons' => array(
					'update'=>array(
						'label'=>'Actualizar Usuario',
						'url'=>'array("usermanagementupdate","id"=>$data->getPrimaryKey())'
					),
					'delete'=>array(
						'label'=>'Eliminar Usuario',
						//'imageUrl'=>Yii::app()->user->ui->getResource("delete.png"),
						'url'=>'array("usermanagementdelete","id"=>$data->getPrimaryKey())',
						'options' => array('class' => 'delete')
					),
				),
		),
	),
	));
/*
$this->widget(Yii::app()->user->ui->CGridViewClass,
	array(
	'type' => 'striped bordered condensed',
    'dataProvider'=>$dataProvider,
	'template' => "{items}",
    'columns'=>array(
		array('name'=>'Username ', 'header'=>'Nombre Usuario'),
	),
	'filter'=>$model,
));*/
?>
</div>
</div>
</div>
