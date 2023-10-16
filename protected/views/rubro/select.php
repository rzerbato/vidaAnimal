<?php

//$modelo = Rubro::model();

$this->widget('booster.widgets.TbGridView',array(
  'id'=>'rubro-grid',
  'type'=>'striped bordered condensed',
  'dataProvider'=>$modelRubro->search(),
  'filter'=>$modelRubro,
  'selectableRows'=>1,
  'columns'=>array(
    'nombre',
  ),
)); ?>
