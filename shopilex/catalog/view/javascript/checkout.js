function loadDefaultShippingAddress(){
	$(document).ready(function() {
		$.ajax({
			url: 'index.php?route=checkout/address/shipping',
			dataType: 'json',
			success: function(json) {
				/*
				if (json['redirect']) {
					location = json['redirect'];
				}
				*/
				
				if (json['output']) {
					$('#shipping-address .checkout-content').html(json['output']);
					
					$('#shipping-address .checkout-content').slideDown('slow');
				}
			}
		});	
	});
}

$('#shipping-address .checkout-heading a').live('click', function() {
	$(document).ready(function() {
		$('#shipping-address .checkout-heading a').hide();
		$.ajax({
			url: 'index.php?route=checkout/address/change',
			dataType: 'json',
			success: function(json) {
				/*
				if (json['redirect']) {
					location = json['redirect'];
				}
				*/
				
				if (json['output']) {
					$('#shipping-address .checkout-content').html(json['output']);
					
					$('#shipping-address .checkout-content').slideDown('slow');
					
				}
			}
		});	
	});
});

//Shipping Address			
$('#shipping-address #button-address').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/address/change',
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
				loadDefaultShippingAddress();
				$('#shipping-address .checkout-heading a').show();
			}  
		}
	});	
});

//load shipping method
function loadDefaultShippingMethod(){
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
			}		
		}
	});	
}

$('#shipping-method .checkout-heading a').live('click', function() {
	$(document).ready(function() {
		$('#shipping-method .checkout-heading a').hide();
		$.ajax({
			url: 'index.php?route=checkout/shipping/change',
			dataType: 'json',
			success: function(json) {
				/*
				if (json['redirect']) {
					location = json['redirect'];
				}
				*/
				
				if (json['output']) {
					$('#shipping-method .checkout-content').html(json['output']);
					
					$('#shipping-method .checkout-content').slideDown('slow');
				}
			}
		});	
	});
});

$('#button-shipping').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/shipping/change',
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
					loadDefaultShippingMethod();
					$('#shipping-method .checkout-heading a').show();					
			}
		}
	});	
});



function loadDefaultPaymentMethod(){
	$(document).ready(function() {
		$.ajax({
			url: 'index.php?route=checkout/payment',
			dataType: 'json',
			success: function(json) {
				if (json['output']) {
					$('#payment-method .checkout-content').html(json['output']);
					
					$('#payment-method .checkout-content').slideDown('slow');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError);
			}
		});	
	});
}

$('#payment-method .checkout-heading a').live('click', function() {
	$(document).ready(function() {
		$('#payment-method .checkout-heading a').hide();
		$.ajax({
			url: 'index.php?route=checkout/payment/change',
			dataType: 'json',
			success: function(json) {
				/*
				if (json['redirect']) {
					location = json['redirect'];
				}
				*/
				
				if (json['output']) {
					$('#payment-method .checkout-content').html(json['output']);
					
					$('#payment-method .checkout-content').slideDown('slow');
				}
			}
		});	
	});
});


$('#button-payment').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/payment/change', 
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
				loadDefaultPaymentMethod();	
				$('#payment-method .checkout-heading a').show();				
			}
		}
	});	
});	

function loadConfirm(){
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
}	