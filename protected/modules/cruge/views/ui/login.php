<!-- Top content -->
<div class="container ">
	<fieldset class ="col-sm-7 col-sm-offset-3 inicio_sesion">


		<div class="row">
			<div class="col-sm-9 col-sm-offset-2 ">
				<h1><strong>Vida Animal</strong></h1>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2 form-box">
				<div class="form-top">
					<div class="form-top-left">
						<h2>Inicio de Sesión</h2>
					</div>
				</div>

			</div>
		</div>
		<div class="row">
			<div class="col-sm-8 col-sm-offset-2 form-box">
				<div class="form-bottom">

				<?php if(Yii::app()->user->hasFlash('loginflash')): ?>
					<div class="flash-error">
						<?php echo Yii::app()->user->getFlash('loginflash'); ?>
					</div>
				<?php else: ?>
					<div class="form">
						<?php $form=$this->beginWidget('CActiveForm', array(
							'id'=>'logon-form',
							'enableClientValidation'=>false,
							'clientOptions'=>array(
								'validateOnSubmit'=>true,
							),
						)); ?>

						<div class="form-group">
							<?php echo $form->labelEx($model,'username'); ?>
							<?php echo $form->textField($model,'username', array('class'=>'form-username form-control', 'placeholder'=>'Nombre de Usuario')); ?>
							<?php echo $form->error($model,'username', array('style'=>'color: red')); ?>
						</div>

						<div class="form-group">
							<?php echo $form->labelEx($model,'password'); ?>
							<?php echo $form->passwordField($model,'password', array('class'=>'form-password form-control', 'placeholder'=>'Clave / Password')); ?>
							<?php echo $form->error($model,'password', array('style'=>'color: red')); ?>
						</div>


						<div class="form-group buttons">
							<?php Yii::app()->user->ui->tbutton('Inicio de Sesión'); ?>

						</div>

						<?php
						//	si el componente CrugeConnector existe lo usa:
						//
						if(Yii::app()->getComponent('crugeconnector') != null){
							if(Yii::app()->crugeconnector->hasEnabledClients){
								?>
								<div class='crugeconnector'>
									<span><?php echo CrugeTranslator::t('logon', 'You also can login with');?>:</span>
									<ul>
										<?php
										$cc = Yii::app()->crugeconnector;
										foreach($cc->enabledClients as $key=>$config){
											$image = CHtml::image($cc->getClientDefaultImage($key));
											echo "<li>".CHtml::link($image,
											$cc->getClientLoginUrl($key))."</li>";
										}
										?>
									</ul>
								</div>
								<?php }} ?>


								<?php $this->endWidget(); ?>
					</div>
					<?php endif; ?>

				</div>
			</div>
		</div>
	</fieldset>
</div>
