<div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
            <?php 
            	$contador=1;
            	foreach ($tabs as $tab): 
            ?>
            	<li <?php echo(isset($tab['active'])?'class="active"':''); ?> ><a href="#tab_<?php echo($contador); ?>" data-toggle="tab"><?php echo($tab['titulo']); ?></a></li>
            <?php 
             	$contador++;
             	endforeach;
             ?> 
            </ul>             
            <div class="tab-content">
	            <?php 
	            	$contador=1;
	            	foreach ($tabs as $tab): 
	            ?>
	              <div class="tab-pane <?php echo(isset($tab['active'])?'active':''); ?>" id="tab_<?php echo($contador); ?>">                            
	                <?php 
	                	$tab['datos']['idtab']='#tab_'.$contador;
	                	$this->render($tab['contenido'],array('datos'=>$tab['datos'])); 
	                ?>
	              </div>
	             <?php 
	             	$contador++;
	             	endforeach;
	             ?>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
</div>
<!-- nav-tabs-custom -->
