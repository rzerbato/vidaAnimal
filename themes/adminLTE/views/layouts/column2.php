<?php /* @var $this Controller */ ?>
<?php $this->beginContent('//layouts/main'); ?>
<div class="col-xs-12 col-sm-9 col-md-9 col-lg-11">
		<?php echo $content; ?>
</div>
 <!--
 <div class="col-xs-12 col-sm-3 col-md-3 col-lg-2">
		<?php
			/*$this->beginWidget('zii.widgets.CPortlet', array(
				'htmlOptions'=>array('class' =>'box' , ),
				'title'=>'Operaciones',
				'decorationCssClass'=>'box-solid',
				'titleCssClass'=>'box-header with-border',
				'contentCssClass'=>'box-body',
			));
			$this->widget('zii.widgets.CMenu', array(
				'items'=>$this->menu,
				'htmlOptions'=>array('class'=>'operations'),
			));
			$this->endWidget();*/
		?>
</div> -->
<?php $this->endContent(); ?>
