<?php
class ControllerModuleAutoSEO extends Controller {
    private $error = array();
    public function index () {
       $this->load->language('module/auto_seo');
      
       $this->document->setTitle($this->language->get('heading_title'));
	   $this->load->model('setting/setting');
       $this->load->model('module/auto_seo');
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
             if (isset($this->request->post['all_seo'])) {
             
                $this->model_module_auto_seo->generateAll();
            }
          	$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }
        
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        
        $this->data['warning_clear'] = $this->language->get('warning_clear');
        $this->data['back'] = $this->language->get('back');
        $this->data['text_all_seo'] = $this->language->get('text_all_seo');
        $this->data['generate'] = $this->language->get('generate');
        
        $this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => $this->language->get('text_breadcrumb_separator')
   		);
        
       
        $this->data['action'] =  $this->url->link('module/auto_seo', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'); 
        
        $this->data['heading_title'] = $this->language->get('heading_title');
       
        $this->template = 'module/auto_seo.tpl';
        $this->children = array('common/header', 'common/footer');
        $this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
    }
    private function validate () {
        if (! $this->user->hasPermission('modify', 'module/auto_seo')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        if (! $this->error) {
            return true;
        } else {
            return false;
        }
    }
} 