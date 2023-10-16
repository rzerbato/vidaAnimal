<div class="btn-group pull-right">
    <button type="button" class="btn btn-default">Acciones</button>
    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
        <span class="caret"></span>
        <span class="sr-only">Toggle Dropdown</span>
    </button>
        <?php $this->widget('zii.widgets.CMenu', array(
            'items'=>$items,                        
            'htmlOptions'=>array('class'=>'dropdown-menu', 'role'=>'menu'),
        ));       
    ?> 
</div>