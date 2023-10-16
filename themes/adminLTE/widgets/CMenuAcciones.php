<?php
class CMenuAcciones extends CWidget
{
    
    public $items;

    public function run()
    {        
    	
        $this->render('menuAcciones', array('items'=>$this->items));
    }
}