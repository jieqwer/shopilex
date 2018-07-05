<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<table class="form">
  <?php $has_payment=0; ?>
  <?php foreach ($payment_methods as $payment_method) { ?>
  <?php if ($payment_method['code'] == $code || !$code) { ?>
      <?php $has_payment=1; ?>
	  <tr>
	    <td style="width: 1px;">
	     <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
	     </td>
	    <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
	  </tr>
   <?php }  ?>
  <?php  } ?>
  
   <?php if ($has_payment==0) { ?>
   <?php foreach ($payment_methods as $payment_method) { ?>
  	 <tr>
	    <td style="width: 1px;">
	     <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
	     </td>
	    <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
	  </tr>
	<?php  break;} ?>
  <?php  } ?>
</table>
<?php } ?>

<b><?php echo $text_comment; ?></b>
<p id="payment_comment">
<?php echo $comment; ?>
</p>


<script type="text/javascript"><!--
$('.fancybox').fancybox({
	width: 560,
	height: 560,
	autoDimensions: false
});
//--></script>  