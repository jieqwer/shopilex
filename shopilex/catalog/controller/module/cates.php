<?php
class ControllerModuleCates extends Controller {
	protected function index($setting) {
		$this->language->load('module/cates'); 

      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_more'] = $this->language->get('text_more');
		$this->data['button_cart'] = $this->language->get('button_cart');
		$this->load->model('catalog/product'); 
		
		$this->load->model('tool/image');

		$this->data['products'] = array();

		$this->load->model('catalog/category');


		$category_info = $this->model_catalog_category->getCategory($setting['cate']);
		$this->data['heading_title'] = '';
		if($category_info){
			$this->data['heading_title'] = $category_info['name'];
			$this->data['href']      = $this->url->link('product/category', 'path=' . $setting['cate']);
			if ($category_info['image']) {
				$this->data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
			} else {
				$this->data['thumb'] = $this->model_tool_image->resize('no_image.jpg', $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));;
			}
			
			$this->load->model('catalog/product');
			$data = array(
				'filter_category_id' => $setting['cate'], 
				'start'              => 0,
				'limit'              => 10
			);
			
			$results = $this->model_catalog_product->getProducts($data);
			foreach ($results as $result) {
				if ($result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $setting['image_width'], $setting['image_height']);
				} else {
					$image =$this->model_tool_image->resize('no_image.jpg', $setting['image_width'], $setting['image_height']);
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
						
				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status')) {
					$rating = $result['rating'];
				} else {
					$rating = false;
				}
					
				$this->data['products'][] = array(
					'product_id' => $result['product_id'],
					'thumb'   	 => $image,
					'name'    	 => $result['name'],
					'price'   	 => $price,
					'special' 	 => $special,
					'rating'     => $rating,
					'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
				);
			}
			}
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/cates.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/cates.tpl';
		} else {
			$this->template = 'default/template/module/cates.tpl';
		}

		$this->render();
	}
}
?>