<?php 
class ControllerPaymentAlipay extends Controller {
	private $error = array(); 

	public function index() {
		$this->load_language('payment/alipay');

		$this->document->settitle($this->language->get('heading_title'));
		
		if (isset($this->error['secrity_code'])) {
			$this->data['error_secrity_code'] = $this->error['secrity_code'];
		} else {
			$this->data['error_secrity_code'] = '';
		}

		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}

		if (isset($this->error['partner'])) {
			$this->data['error_partner'] = $this->error['partner'];
		} else {
			$this->data['error_partner'] = '';
		}
		
		$this->data['breadcrumbs']  = array();

   		$this->data['breadcrumbs'][] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token'],
       		'text'      => $this->language->get('text_payment'),
      		'separator' => $this->language->get('text_breadcrumb_separator')
   		);

   		$this->data['breadcrumbs'][] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=payment/alipay&token=' . $this->session->data['token'],
       		'text'      => $this->language->get('heading_title'),
      		'separator' => $this->language->get('text_breadcrumb_separator')
   		);
		
		$this->load->model('setting/setting');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->load->model('setting/setting');
			
			$this->model_setting_setting->editSetting('alipay', $this->request->post);				
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect( HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token']);
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_all_zones'] = $this->language->get('text_all_zones');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		
		$this->data['entry_seller_email'] = $this->language->get('entry_seller_email');
		$this->data['entry_security_code'] = $this->language->get('entry_security_code');
		$this->data['entry_partner'] = $this->language->get('entry_partner');
		$this->data['entry_trade_type'] = $this->language->get('entry_trade_type');
		$this->data['entry_anti_phishing'] = $this->language->get('entry_anti_phishing');
		$this->data['entry_order_status'] = $this->language->get('entry_order_status');	
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['tab_general'] = $this->language->get('tab_general');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
 		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}


		$this->data['action'] = HTTPS_SERVER . 'index.php?route=payment/alipay&token=' . $this->session->data['token'];
		
		$this->data['cancel'] =  HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token'];
		
		if (isset($this->request->post['alipay_seller_email'])) {
			$this->data['alipay_seller_email'] = $this->request->post['alipay_seller_email'];
		} else {
			$this->data['alipay_seller_email'] = $this->config->get('alipay_seller_email');
		}

		if (isset($this->request->post['alipay_security_code'])) {
			$this->data['alipay_security_code'] = $this->request->post['alipay_security_code'];
		} else {
			$this->data['alipay_security_code'] = $this->config->get('alipay_security_code');
		}

		if (isset($this->request->post['alipay_partner'])) {
			$this->data['alipay_partner'] = $this->request->post['alipay_partner'];
		} else {
			$this->data['alipay_partner'] = $this->config->get('alipay_partner');
		}		

		if (isset($this->request->post['alipay_trade_type'])) {
			$this->data['alipay_trade_type'] = $this->request->post['alipay_trade_type'];
		} else {
			$this->data['alipay_trade_type'] = $this->config->get('alipay_trade_type');
		}
		
	/*	if (isset($this->request->post['alipay_anti_phishing'])) {
			$this->data['alipay_anti_phishing'] = $this->request->post['alipay_anti_phishing'];
		} else {
			$this->data['alipay_anti_phishing'] = $this->config->get('alipay_anti_phishing');
		}
		*/
		if (isset($this->request->post['alipay_order_status_id'])) {
			$this->data['alipay_order_status_id'] = $this->request->post['alipay_order_status_id'];
		} else {
			$this->data['alipay_order_status_id'] = $this->config->get('alipay_order_status_id'); 
		} 

		$this->load->model('localisation/order_status');
		
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
			
		$this->load->model('localisation/geo_zone');
										
		$this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		
		if (isset($this->request->post['alipay_status'])) {
			$this->data['alipay_status'] = $this->request->post['alipay_status'];
		} else {
			$this->data['alipay_status'] = $this->config->get('alipay_status');
		}
		
		if (isset($this->request->post['alipay_sort_order'])) {
			$this->data['alipay_sort_order'] = $this->request->post['alipay_sort_order'];
		} else {
			$this->data['alipay_sort_order'] = $this->config->get('alipay_sort_order');
		}
		
		$this->template = 'payment/alipay.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}


	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/alipay')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->request->post['alipay_seller_email']) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if (!$this->request->post['alipay_security_code']) {
			$this->error['secrity_code'] = $this->language->get('error_secrity_code');
		}

		if (!$this->request->post['alipay_partner']) {
			$this->error['partner'] = $this->language->get('error_partner');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
}
?>