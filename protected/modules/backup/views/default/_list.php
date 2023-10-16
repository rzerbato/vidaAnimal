<?php $this->widget('booster.widgets.TbGridView',array(
	'id' => 'install-grid',
	'type' => 'striped bordered condensed',
	'template' => "{summary}{items}{pager}",
	'dataProvider' => $dataProvider,
	'columns' => array(
		//'name',		
		array (
			'name'=>'Nombre',
			'value'=> '$data["name"]',
			'type'=>'text',
		),
		//'size',
		array (
			'name'=>'Fecha Creación',
			'value'=> '$data["create_time"]',
			'type'=>'text',
		),
		array (
			'name'=>'Tamaño',
			'value'=> '$data["size"]',
			'type'=>'text',
		),
		//'create_time',
		
		/*array(
			'class' => 'CButtonColumn',
			'template' => ' {download} {restore}',
			  'buttons'=>array
			    (
			        'Download' => array
			        (
			            'url'=>'Yii::app()->createUrl("backup/default/download", array("file"=>$data["name"]))',
			        ),
			        'Restore' => array
			        (
			            'url'=>'Yii::app()->createUrl("backup/default/restore", array("file"=>$data["name"]))',
					),
			        'delete' => array
			        (
			            'url'=>'Yii::app()->createUrl("backup/default/delete", array("file"=>$data["name"]))',
			        ),
			    ),		
		),*/
		array(
			//'class' => 'CButtonColumn',			
			'class'=>'booster.widgets.TbButtonColumn',
				//'template' => ' {download} {restore} {delete}',
				'template' => ' {download}',
				'htmlOptions'=>array(
					'style'=>'width: 70px; text-align: center;',
					
				),
				'buttons'=>array( 
					  'download' => array
					(
						'label' => 'Descargar',
						'url'=>'Yii::app()->createUrl("backup/default/download", array("file"=>$data["name"]))',
						'icon' => 'fa fa-download',
					),
					  /*'restore' => array
					(
						'label' => 'Restaurar',
						'url'=>'Yii::app()->createUrl("backup/default/restore", array("file"=>$data["name"]))',
						'icon' => 'fa fa-window-restore',
					),

					'delete' => array
			        (
			            'url'=>'Yii::app()->createUrl("backup/default/delete", array("file"=>$data["name"]))',
			        ),*/
  
				),	
		),
	),
)); 

?>