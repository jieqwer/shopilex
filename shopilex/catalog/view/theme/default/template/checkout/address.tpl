<?php if ($addresses) { ?>
<input type="hidden" name="<?php echo $type; ?>_address" value="existing" id="<?php echo $type; ?>-address-existing" />
<div id="<?php echo $type; ?>-existing">
 
    <?php foreach ($addresses as $address) { ?>
    <?php if ($address['address_id'] == $address_id) { ?>
    <input type="hidden" name="address_id" value="<?php echo $address['address_id']; ?>" />
   <?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['zone']; ?>,<?php echo $address['city']; ?>, <?php echo $address['address_1']; ?> <?php echo $address['address_2']; ?>
    ,<?php echo $entry_postcode; ?><?php echo $address['postcode']; ?> ,<?php echo $entry_mobile; ?><?php echo $address['mobile']; ?> ,<?php echo $entry_phone; ?><?php echo $address['phone']; ?> 
    <?php } ?>
   
    <?php } ?>
  </select>
</div>
<?php } ?>

<script type="text/javascript"><!--
$('#<?php echo $type; ?>-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>');
	

//--></script> 