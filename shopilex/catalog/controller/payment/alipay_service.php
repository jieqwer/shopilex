<?php
require_once("alipay_function.php");

class alipay_service {

    var $gateway;			//��ص�ַ
    var $_key;				//��ȫУ����
    var $mysign;			//ǩ����
    var $sign_type;			//ǩ������
    var $parameter;			//��Ҫǩ��Ĳ�������
    var $_input_charset;    //�ַ�����ʽ

    /**���캯��
	*�������ļ�������ļ��г�ʼ������
	*$parameter ��Ҫǩ��Ĳ�������
	*$key ��ȫУ����
	*$sign_type ǩ������
    */
    function alipay_service($parameter,$key,$sign_type) {
        $this->gateway		= "https://www.alipay.com/cooperate/gateway.do?";
        $this->_key			= $key;
        $this->sign_type	= $sign_type;
        $preParameter		= para_filter($parameter);

        //�趨_input_charset��ֵ,Ϊ��ֵ�������Ĭ��ΪGBK
        if($parameter['_input_charset'] == '')
            $this->parameter['_input_charset'] = 'GBK';

        $this->_input_charset   = $this->parameter['_input_charset'];

        //���ǩ����
        $this->parameter = arg_sort($preParameter);    //�õ�����ĸa��z������ǩ���������
        $this->mysign = build_mysign($this->parameter,$this->_key,$this->sign_type);
    }


	function build_url() {
		$url        = $this->gateway;
		$sort_array = array();
		$arg        = "";
		$sort_array = arg_sort($this->parameter);
		while (list ($key, $val) = each ($sort_array)) {
			$arg.=$key."=".urlencode(charset_encode($val,$this->parameter['_input_charset']))."&";
		}
		$url.= $arg."sign=" .$this->mysign ."&sign_type=".$this->sign_type;
		return $url;

	}
}
?>