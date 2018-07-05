<?php 
// begin  sfc module		
			$code=$result['code'];
			if($code!='sfc'){
				$quote = $this->{'model_shipping_' . $code}->getQuote($address_data); 
				if ($quote) {
					$quote_data[$code] = array(
						'title'      => $quote['title'],
						'quote'      => $quote['quote'], 
						'sort_order' => $quote['sort_order'],
						'error'      => $quote['error']
					);
				}
			}
			else{
				$doc = new DOMDocument();
				if(defined('REQUIRESHIPTYPE')) {
					$doc->load( REQUIRESHIPTYPE ); 
					$dataArr = $doc->getElementsByTagName( "shiptype" ); 
					}
				else {
					define('REQUIRESHIPTYPE','http://www.sendfromchina.com/shipfee/ship_type_list');
					$doc->load( REQUIRESHIPTYPE ); 
					$dataArr = $doc->getElementsByTagName( "shiptype" ); 
				}
				foreach( $dataArr as $row ){ 
					$method_codes = $row->getElementsByTagName( "method_code" );
					$method_code = $method_codes->item(0)->nodeValue;
					$sfc_mothod='sfc_'.$method_code;
					
					if( $this->config->get($sfc_mothod)){
						$quote = $this->{'model_shipping_' .$code}->getQuote($address_data,$method_code); 
						if ($quote) {
							//echo $key.'_'.$quote['id'];
							$quote_data[$code.'_'.$quote['code']] = array(
								'title'      => $quote['title'],
								'quote'      => $quote['quote'], 
								'sort_order' => $quote['sort_order'],
								'error'      => $quote['error']
								);
							}
						}
					}
				}
		
			// end  sfc module
?>