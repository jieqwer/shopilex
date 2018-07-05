<div class="left">
  <h2><?php echo $text_your_details; ?></h2>
    <br />
   <span class="required">*</span> <?php echo $entry_username; ?><br />
  <input type="text" name="username" value="" class="large-field" />
     <br /> <br />
  <span class="required">*</span> <?php echo $entry_firstname; ?><br />
  <input type="text" name="firstname" value="" class="large-field" />
  <br />
  <br />
  <span class="required">*</span> <?php echo $entry_email; ?><br />
  <input type="text" name="email" value="" class="large-field" />
  <br />
 
  <br />
  <?php echo $entry_fax; ?><br />
  <input type="text" name="fax" value="" class="large-field" />
  <br />
  <br />
  <h2><?php echo $text_your_password; ?></h2>
  <span class="required">*</span> <?php echo $entry_password; ?><br />
  <input type="password" name="password" value="" class="large-field" />
  <br />
  <br />
  <span class="required">*</span> <?php echo $entry_confirm; ?> <br />
  <input type="password" name="confirm" value="" class="large-field" />
  <br />
  <br />
  <br />
</div>
<div class="right">
  <h2><?php echo $text_your_address; ?></h2>
 <br />

   <span class="required">*</span> <?php echo $entry_zone; ?><br />
  <select name="zone_id" class="large-field">
  </select>
  <br />
  <br />
  
  <span class="required">*</span> <?php echo $entry_city; ?><br />
  <input type="text" name="city" value="" class="large-field" />
  <br />
  <br />

   <span class="required">*</span> <?php echo $entry_address_1; ?><br />
  <input type="text" name="address_1" value="" class="large-field" />
  <br />
  <br />
  <?php echo $entry_address_2; ?><br />
  <input type="text" name="address_2" value="" class="large-field" />
  <br />
  <br />
    <span class="required">*</span> <?php echo $entry_postcode; ?><br />
  <input type="text" name="postcode" value="" class="large-field" />
    <br />
      <br />
 	<span class="required">*</span> <?php echo $entry_mobile; ?>  <br />
 	<input type="text" name="mobile" value=""  class="large-field" />
     <br />
    <br />    
	<?php echo $entry_phone; ?><br />   
    <input type="text" name="phone" value=""  class="large-field" />
      <br />
      <br /> 
     <br />
</div>
<div style="clear: both; padding-top: 15px; border-top: 1px solid #EEEEEE;">
  <input type="checkbox" name="newsletter" value="1" id="newsletter" />
  <label for="newsletter"><?php echo $entry_newsletter; ?></label>
  <br />
  <?php if ($shipping_required) { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" />
  <label for="shipping"><?php echo $entry_shipping; ?></label>
  <br />
  <?php } ?>
  <br />
  <br />
</div>
<?php if ($text_agree) { ?>
<div class="buttons">
  <div class="right"><?php echo $text_agree; ?>
    <input type="checkbox" name="agree" value="1" />
    <a id="button-register" class="button"><span><?php echo $button_continue; ?></span></a></div>
</div>
<?php } else { ?>
<div class="buttons">
  <div class="right"><a id="button-register" class="button"><span><?php echo $button_continue; ?></span></a></div>
</div>
<?php } ?>
<script type="text/javascript"><!--
$('#shipping-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>');
//--></script>
<script type="text/javascript"><!--
$('.fancybox').fancybox({
	width: 560,
	height: 560,
	autoDimensions: false
});
//--></script>  