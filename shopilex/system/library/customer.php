<?php
final class Customer {
	private $customer_id;
	private $firstname;
	private $lastname;
	private $email;
	private $telephone;
	private $fax;
	private $newsletter;
	private $customer_group_id;
	private $address_id;
	private $payment_method;
	private $shipping_method;
	
  	public function __construct($registry) {
		$this->config = $registry->get('config');
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');
		$this->url = $registry->get('url');
		$this->language = $registry->get('language');
		if (isset($this->session->data['customer_id'])) { 
			$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$this->session->data['customer_id'] . "' AND status = '1'");
			
			if ($customer_query->num_rows) {
				$this->customer_id = $customer_query->row['customer_id'];
				$this->firstname = $customer_query->row['firstname'];
				$this->lastname = $customer_query->row['lastname'];
				$this->email = $customer_query->row['email'];
				$this->telephone = $customer_query->row['telephone'];
				$this->fax = $customer_query->row['fax'];
				$this->newsletter = $customer_query->row['newsletter'];
				$this->customer_group_id = $customer_query->row['customer_group_id'];
				
				$this->address_id = $customer_query->row['address_id'];
				$this->payment_method = $customer_query->row['payment_method'];
				$this->shipping_method = $customer_query->row['shipping_method'];			
      			
				$this->db->query("UPDATE " . DB_PREFIX . "customer SET cart = '" . $this->db->escape(isset($this->session->data['cart']) ? serialize($this->session->data['cart']) : '') . "', wishlist = '" . $this->db->escape(isset($this->session->data['wishlist']) ? serialize($this->session->data['wishlist']) : '') . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE customer_id = '" . (int)$this->session->data['customer_id'] . "'");
			
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_ip WHERE customer_id = '" . (int)$this->session->data['customer_id'] . "' AND ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'");
				
				if (!$query->num_rows) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "customer_ip SET customer_id = '" . (int)$this->session->data['customer_id'] . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', date_added = NOW()");
				}
			} else {
				$this->logout();
			}
  		}
	}
		
  	public function login($email, $password) {
  		
		if (!$this->config->get('config_customer_approval')) {
			$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(strtolower($email)) . "' AND password = '" . $this->db->escape(md5($password)) . "' AND status = '1'");
		} else {
			$customer_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(strtolower($email)) . "' AND password = '" . $this->db->escape(md5($password)) . "' AND status = '1' AND approved = '1'");
		}
		
		if ($customer_query->num_rows) {
			$this->session->data['customer_id'] = $customer_query->row['customer_id'];	
		    
			if (($customer_query->row['cart']) && (is_string($customer_query->row['cart']))) {
				$cart = unserialize($customer_query->row['cart']);
				
				foreach ($cart as $key => $value) {
					if (!array_key_exists($key, $this->session->data['cart'])) {
						$this->session->data['cart'][$key] = $value;
					} else {
						$this->session->data['cart'][$key] += $value;
					}
				}			
			}

			if (($customer_query->row['wishlist']) && (is_string($customer_query->row['wishlist']))) {
				if (!isset($this->session->data['wishlist'])) {
					$this->session->data['wishlist'] = array();
				}
								
				$wishlist = unserialize($customer_query->row['wishlist']);
			
				foreach ($wishlist as $product_id) {
					if (!in_array($product_id, $this->session->data['wishlist'])) {
						$this->session->data['wishlist'][] = $product_id;
					}
				}			
			}
									
			$this->customer_id = $customer_query->row['customer_id'];
			$this->firstname = $customer_query->row['firstname'];
			$this->lastname = $customer_query->row['lastname'];
			$this->email = $customer_query->row['email'];
			$this->telephone = $customer_query->row['telephone'];
			$this->fax = $customer_query->row['fax'];
			$this->newsletter = $customer_query->row['newsletter'];
			$this->customer_group_id = $customer_query->row['customer_group_id'];
			$this->address_id = $customer_query->row['address_id'];
           
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' ,  date_added = NOW() WHERE customer_id = '" . (int)$customer_query->row['customer_id'] . "'");
			
	  		return true;
    	} else {
      		return false;
    	}
  	}
  
	public function setAddress($address_id) {
  		$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . $this->db->escape($address_id) . "' WHERE customer_id = '" . (int)$this->getId() . "'");
  	}
  	
  	private function redirect($url, $status = 302) {
  		header('Status: ' . $status);
  		header('Location: ' . str_replace('&amp;', '&', $url));
  		exit();
  	}
  	
  	public function logout() {
		unset($this->session->data['customer_id']);

		$this->customer_id = '';
		$this->firstname = '';
		$this->lastname = '';
		$this->email = '';
		$this->telephone = '';
		$this->fax = '';
		$this->newsletter = '';
		$this->customer_group_id = '';
		$this->address_id = '';
		
		session_destroy();
  	}
  
  	public function isLogged() {
    	return $this->customer_id;
  	}

  	public function getId() {
    	return $this->customer_id;
  	}
      
  	public function getFirstName() {
		return $this->firstname;
  	}
  
  	public function getLastName() {
		return $this->lastname;
  	}
  
  	public function getName() {
		return $this->firstname;
  	}
  
  	public function getEmail() {
		return $this->email;
  	}
  
  	public function getTelephone() {
		return $this->telephone;
  	}
  
  	public function getFax() {
		return $this->fax;
  	}
	
  	public function getNewsletter() {
		return $this->newsletter;	
  	}

  	public function getCustomerGroupId() {
		return $this->customer_group_id;	
  	}
	
  	public function getAddressId() {
		return $this->address_id;	
  	}
	
  	public function getBalance() {
		$query = $this->db->query("SELECT SUM(amount) AS total FROM " . DB_PREFIX . "customer_transaction WHERE customer_id = '" . (int)$this->customer_id . "'");
	
		return $query->row['total'];
  	}	
		
  	public function getRewardPoints() {
		$query = $this->db->query("SELECT SUM(points) AS total FROM " . DB_PREFIX . "customer_reward WHERE customer_id = '" . (int)$this->customer_id . "'");
	
		return $query->row['total'];	
  	}	
  	
	public function getShippingMethod(){
  		return $this->shipping_method;
  	}
  	
	public function getShippingMethodTitle(){
  		if($this->shipping_method!=''){
			$this->language->load('shipping/'.$this->shipping_method);
  			return $this->language->get('text_title');
		}else{
			return '';
		}
  	}
  	
	public function setShippingMethod($shipping_method){
  		$this->db->query("UPDATE " . DB_PREFIX . "customer SET shipping_method = '".$shipping_method."' WHERE customer_id = '" . (int)$this->session->data['customer_id'] ."'");
  	}
  	
	public function getPaymentMethod(){
  		return $this->payment_method;
  	}
  	
	public function getPaymentMethodTitle(){
		if($this->payment_method!=''){
			$this->language->load('payment/'.$this->payment_method);
  			return $this->language->get('text_title');
		}else{
			return '';
		}
  	}
  	
  	public function setPaymentMethod($paymentMethod){
  		$this->db->query("UPDATE " . DB_PREFIX . "customer SET payment_method = '".$paymentMethod."'  WHERE customer_id = '" . (int)$this->session->data['customer_id']."'" );
  	}
	
}
?>