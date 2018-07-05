<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <div id="warnning">
  
  </div>
  <div class="checkout">
    <div id="checkout">
      <div class="checkout-heading"><?php echo $text_checkout_option; ?></div>
      <div class="checkout-content"></div>
    </div>
    <?php if ($shipping_required) { ?>
    <div id="shipping-address">
      <div class="checkout-heading"><?php echo $text_checkout_shipping_address; ?></div>
      <div class="checkout-content"></div>
    </div>
    <div id="shipping-method">
      <div class="checkout-heading"><?php echo $text_checkout_shipping_method; ?></div>
      <div class="checkout-content"></div>
    </div>
    <?php } ?>
    <div id="payment-method">
      <div class="checkout-heading"><?php echo $text_checkout_payment_method; ?></div>
      <div class="checkout-content"></div>
    </div>
    <div id="confirm">
      <div class="checkout-heading"><?php echo $text_checkout_confirm; ?></div>
      <div class="checkout-content"></div>
    </div>
  </div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('#checkout .checkout-content input[name=\'account\']').live('change', function() {
	if ($(this).attr('value') == 'register') {
		$('#shipping-address .checkout-heading span').html('<?php echo $text_checkout_account; ?>');
	} else {
		$('#shipping-address .checkout-heading span').html('<?php echo $text_checkout_shipping_address; ?>');
		
		
	}
});


<?php if (!$logged) { ?> 
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=checkout/login',
		dataType: 'json',
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['output']) {		
				$('#checkout .checkout-content').html(json['output']);
				
				$('#checkout .checkout-content').slideDown('slow');
			}
		}
	});	
});		
<?php } else { ?>
<?php if ($shipping_required) { ?>
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=checkout/address/shipping',
		dataType: 'json',
		success: function(json) {
			if (json['output']) {
				$('#shipping-address .checkout-content').html(json['output']);
				
				$('#shipping-address .checkout-content').slideDown('slow');

				$('#shipping-address .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');			
			}
		}
	});	
	
	$.ajax({
		url: 'index.php?route=checkout/address/shipping',
		data: $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'password\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address select'),
		dataType: 'json',
		success: function(json) {
			$.ajax({
				url: 'index.php?route=checkout/shipping',
				dataType: 'json',
				success: function(json) {
					if (json['redirect']) {
						location = json['redirect'];
					}
								
					if (json['output']) {
						
						$('#shipping-method .checkout-content').html(json['output']);
						
						$('#shipping-method .checkout-content').slideDown('slow');
						
						$('#shipping-address .checkout-heading a').remove();
					
						$('#shipping-address .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');							
					}
				
					$.ajax({
						url: 'index.php?route=checkout/payment',
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}
													
							if (json['output']) {
								$('#payment-method .checkout-content').html(json['output']);
								
								$('#payment-method .checkout-content').slideDown('slow');

						
								$('#shipping-method .checkout-heading a').remove();
								
								$('#shipping-method .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');	
							}
						},
						error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError);
						}
					});		


					$.ajax({
						url: 'index.php?route=checkout/confirm',
						dataType: 'json',
						success: function(json) {
							if (json['redirect']) {
								location = json['redirect'];
							}	
						
							if (json['output']) {
								$('#confirm .checkout-content').html(json['output']);
						
								$('#confirm .checkout-content').slideDown('slow');
								
								checkDoPayment();
								
								$('#payment-method .checkout-heading a').remove();
								
								$('#payment-method .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');	
							}
						},
						error: function(xhr, ajaxOptions, thrownError) {
							alert(thrownError);
						}
					});						
				}
			});	
		}
	});	

});
<?php } else { ?>
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=checkout/payment',
		dataType: 'json',
		success: function(json) {
			if (json['output']) {
				$('#payment-method .checkout-content').html(json['output']);
				
				$('#payment-method .checkout-content').slideDown('slow');

				$('#payment-method .checkout-heading a').remove();
				
				$('#payment-method .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');	
			}
		}
	});	

	$.ajax({
		url: 'index.php?route=checkout/confirm',
		dataType: 'json',
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
		
			if (json['output']) {
				$('#confirm .checkout-content').html(json['output']);
		
				$('#confirm .checkout-content').slideDown('slow');
				
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError);
		}
	});		
	
});
<?php } ?>
<?php } ?>

// Checkout
$('#button-account').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/' + $('input[name=\'account\']:checked').attr('value'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-account').attr('disabled', true);
			$('#button-account').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('#button-account').attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {
			$('.warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['output']) {			
				$('#shipping-address .checkout-content').html(json['output']);
				
				// $('#checkout .checkout-content').slideUp('slow');
				
				$('#shipping-address .checkout-content').slideDown('slow');
				
				$('#checkout .checkout-heading a').remove();
				$('#checkout .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');
			}
		}
	});
});


// Shipping Address			
$('#shipping-address #button-address').live('click', function() {
	$('#warnning').html('');
	$.ajax({
		url: 'index.php?route=checkout/address/shipping',
		type: 'post',
		data: $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'password\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address select'),
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-address #button-address').attr('disabled', true);
			$('#shipping-address #button-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#shipping-address #button-address').attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {
			$('.error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['firstname']) {
					$('#shipping-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
				}
				
			
				if (json['error']['email']) {
					$('#shipping-address input[name=\'email\']').after('<span class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['mobile']) {
					$('#shipping-address input[name=\'mobile\']').after('<span class="error">' + json['error']['mobile'] + '</span>');
				}		
										
				if (json['error']['address_1']) {
					$('#shipping-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#shipping-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#shipping-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}	
			
				
				if (json['error']['zone']) {
					$('#shipping-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
			} else {
				$.ajax({
					url: 'index.php?route=checkout/shipping',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
									
						if (json['output']) {
							
							$('#shipping-method .checkout-content').html(json['output']);
							
							$('#shipping-address .checkout-heading a').remove();
							$('#shipping-address .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');							
						}
						
						$.ajax({
							url: 'index.php?route=checkout/address/shipping',
							dataType: 'json',
							success: function(json) {
								if (json['redirect']) {
									location = json['redirect'];
								}	
													
								if (json['output']) {
									$('#shipping-address .checkout-content').html(json['output']);
								}
							}
						});						
					}
				});	

				checkoutComfirm();
			}  
		}
	});	
});


/* testing  */
 $('#shipping-address .checkout-heading a').live('click', function() {
	$(document).ready(function() {
		
	    $('#shipping-address .checkout-heading a').remove();
		$.ajax({
			url: 'index.php?route=checkout/address/shipping&action=modifyad',
			dataType: 'json',
			success: function(json) {
				if (json['output']) {
					$('#shipping-address .checkout-content').html(json['output']);
					
					$('#shipping-address .checkout-content').slideDown('slow');
					
				}
			}
		});	
	});
});

$('#shipping-method .checkout-heading a').live('click', function() {
	$(document).ready(function() {
		
	    $('#shipping-method .checkout-heading a').remove();
		$.ajax({
			url: 'index.php?route=checkout/shipping&action=modifymt',
			dataType: 'json',
			success: function(json) {
				if (json['output']) {
					$('#shipping-method .checkout-content').html(json['output']);
					
					$('#shipping-method .checkout-content').slideDown('slow');
					
				}
			}
		});	
	});
});


$('#payment-method .checkout-heading a').live('click', function() {
	$(document).ready(function() {
		
	 	$('#shipping-method .checkout-heading a').remove();
		$.ajax({
			url: 'index.php?route=checkout/payment&action=modifypm',
			dataType: 'json',
			success: function(json) {
				if (json['output']) {
					$('#payment-method .checkout-content').html(json['output']);
					
					$('#payment-method .checkout-content').slideDown('slow');

					$('#shipping-method .checkout-heading a').remove();
				 	$('#shipping-method .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');	
					
				}
			}
		});	
	});
});
/* end testing  */

$('#button-shipping').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/shipping',
		type: 'post',
		data: $('#shipping-method input[type=\'radio\']:checked, #shipping-method textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-shipping').attr('disabled', true);
			$('#button-shipping').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-shipping').attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {
			$('.warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#shipping-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
					
					$('.warning').fadeIn('slow');
				}			
			} else {
				$.ajax({
					url: 'index.php?route=checkout/payment',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}
												
						if (json['output']) {
							$('#payment-method .checkout-content').html(json['output']);

							$('#payment-method .checkout-content').slideDown('slow');

							$('#shipping-method .checkout-heading a').remove();
						 	$('#shipping-method .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');

						 	$.ajax({
								url: 'index.php?route=checkout/shipping',
								dataType: 'json',
								success: function(json) {
									if (json['output']) {
										$('#shipping-method .checkout-content').html(json['output']);
										$.ajax({
											url: 'index.php?route=checkout/confirm',
											data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
											dataType: 'json',
											success: function(json) {
												if (json['output']) {
													$('#confirm .checkout-content').html(json['output']);
													checkDoPayment();
												}
											}
										});		
									}
								}
							});	
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError);
					}
				});					
			}
		}
	});	
});


$('#button-payment').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/payment', 
		type: 'post',
		data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-payment').attr('disabled', true);
			$('#button-payment').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-payment').attr('disabled', false);
			$('.wait').remove();
		},			
		success: function(json) {
			$('.warning').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#payment-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
					
					$('.warning').fadeIn('slow');
				}			
			} else {
				$.ajax({
					url: 'index.php?route=checkout/confirm',
					dataType: 'json',
					success: function(json) {
						if (json['redirect']) {
							location = json['redirect'];
						}	
					
						if (json['output']) {
							$('#confirm .checkout-content').html(json['output']);
			
							$('#confirm .checkout-content').slideDown('slow');
							<?php if ($shipping_required) { ?>
								checkDoPayment();
							<?php } ?>
							$.ajax({
								url: 'index.php?route=checkout/payment',
								dataType: 'json',
								success: function(json) {
									if (json['output']) {
										$('#payment-method .checkout-content').html(json['output']);
									}
								}
							});		
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError);
					}
				});					
			}
		}
	});	
});

function checkDoPayment(){
	$.ajax({
		url: 'index.php?route=checkout/confirm/check',
		dataType: 'json',
		success: function(json) {
			if (json.error) {
				$('#button-confirm').hide();
				$('.payment').hide();
				if(json['error_msg']){
					$('#warnning').html('<div class="attention">'+json['error_msg']+ '</div>');
				}
			}else{
				$('#warnning').html('');
			}
		}
	});		
	
	
}
function checkoutComfirm(){
	$.ajax({
		url: 'index.php?route=checkout/confirm',
		dataType: 'json',
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			}	
		
			if (json['output']) {
				$('#confirm .checkout-content').html(json['output']);
		
				$('#confirm .checkout-content').slideDown('slow');

				checkDoPayment();

				$('#payment-method .checkout-heading a').remove();
				
				$('#payment-method .checkout-heading').prepend('<a><?php echo $text_modify; ?></a>');	
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError);
		}
	});		
	
}

//--></script> 
<?php echo $footer; ?>