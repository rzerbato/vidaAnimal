<?php

//$modelo = Cliente::model();

$this->widget('booster.widgets.TbGridView',array(
  'id'=>'cliente-grid',
  'type'=>'striped bordered condensed',
  'dataProvider'=>$modelCliente->search(),
  'filter'=>$modelCliente,
  'selectableRows'=>1,
  'columns'=>array(
    'nombre',
  ),
)); ?>
