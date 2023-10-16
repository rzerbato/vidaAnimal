


<?php
$this->widget('booster.widgets.TbGridView',array(
  'id'=>'especie-grid',
  'type'=>'striped bordered condensed',
  'dataProvider'=>$modeloEspecie->search(),
  'filter'=>$modeloEspecie,
  'selectableRows'=>1,
  'columns'=>array(
    //'idespecie',
    'nombre',
  ),
)); 

?>
