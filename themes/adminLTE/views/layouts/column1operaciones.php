<?php /* @var $this Controller */ ?>
<?php $this->beginContent('//layouts/main'); ?>
<?php $this->widget('adminLTE.widgets.CMenuAcciones', array(
            'items'=>$this->menu,
        ));
    ?>

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <?php echo $content; ?>
</div><!-- content -->
<?php $this->endContent(); ?>
