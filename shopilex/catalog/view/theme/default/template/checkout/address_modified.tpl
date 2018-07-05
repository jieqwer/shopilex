<?php if ($addresses) { ?>
<input type="radio" name="<?php echo $type; ?>_address" value="existing" id="<?php echo $type; ?>-address-existing" checked="checked" />
<label for="<?php echo $type; ?>-address-existing"><?php echo $text_address_existing; ?></label>
<div id="<?php echo $type; ?>-existing">
  <select name="address_id" style="width: 100%; margin-bottom: 15px;height:100px;" size="5">
    <?php foreach ($addresses as $address) { ?>
    <?php if ($address['address_id'] == $address_id) { ?>
    <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['zone']; ?>,<?php echo $address['city']; ?>, <?php echo $address['address_1']; ?> <?php echo $address['address_2']; ?>,<?php echo $entry_postcode; ?>  <?php echo $address['postcode']; ?> ,<?php echo $entry_mobile; ?>  <?php echo $address['mobile']; ?> ,<?php echo $entry_phone; ?>  <?php echo $address['phone']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['zone']; ?>,<?php echo $address['city']; ?>, <?php echo $address['address_1']; ?> <?php echo $address['address_2']; ?>,<?php echo $entry_postcode; ?>  <?php echo $address['postcode']; ?> ,<?php echo $entry_mobile; ?>  <?php echo $address['mobile']; ?> ,<?php echo $entry_phone; ?>  <?php echo $address['phone']; ?></option>
    <?php } ?>
    <?php } ?>
  </select>
</div>
<?php } ?>
<p>
  <input type="radio" name="<?php echo $type; ?>_address" value="new" id="<?php echo $type; ?>-address-new" />
  <label for="<?php echo $type; ?>-address-new"><?php echo $text_address_new; ?></label>
</p>
<div id="<?php echo $type; ?>-new" style="display: none;">
  <table class="form">
    <tr>
      <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
      <td><input type="text" name="firstname" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
      <td><select name="zone_id" class="large-field">
        </select></td>
    </tr>
    <tr>
      <td><span class="required">*</span> <?php echo $entry_city; ?></td>
      <td><input type="text" name="city" value="" class="large-field" /></td>
    </tr>
   
    <tr>
      <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
      <td><input type="text" name="address_1" value="" class="large-field" /></td>
    </tr>
    <tr>
      <td><?php echo $entry_address_2; ?></td>
      <td><input type="text" name="address_2" value="" class="large-field" /></td>
    </tr>
     <tr>
      <td><span class="required">*</span> <?php echo $entry_postcode; ?></td>
      <td><input type="text" name="postcode" value="" class="large-field" /></td>
    </tr>
      <tr>
          <td><span class="required">*</span> <?php echo $entry_mobile; ?></td>
          <td><input type="text" name="mobile" value="" />
            </td>
        </tr>
        <tr>
          <td> <?php echo $entry_phone; ?></td>
          <td><input type="text" name="phone" value="" />
           </td>
    </tr>
  </table>
</div>
<br />
<div class="buttons">
  <div class="right"><a id="button-address" class="button"><span><?php echo $button_save; ?></span></a></div>
</div>
<script type="text/javascript"><!--
$('#<?php echo $type; ?>-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>');
	
$('#<?php echo $type; ?>-address input[name=\'<?php echo $type; ?>_address\']').live('change', function() {
	if (this.value == 'new') {
		$('#<?php echo $type; ?>-existing').hide();
		$('#<?php echo $type; ?>-new').show();
	} else {
		$('#<?php echo $type; ?>-existing').show();
		$('#<?php echo $type; ?>-new').hide();
	}
});
//--></script> 