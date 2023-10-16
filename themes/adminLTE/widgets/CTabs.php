<?php
class CTabs extends CWidget
{
    
    public $tabs;/* arreglo de la forma array(
    								array('titulo'=>'Titulo de la solapa 1','contenido'=>'_view','active'=>true,'datos'=>array())),
    								array('titulo'=>'Titulo de la solapa 2','contenido'=>'_view','datos'=>array())),

    								) */

    public function run()
    {        
    	
        $this->render('tabs', array('tabs'=>$this->tabs));
    }
}