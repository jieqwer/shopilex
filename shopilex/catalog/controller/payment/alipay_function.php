<?php
function build_mysign($sort_array,$key,$sign_type = "MD5") {
    $prestr = create_linkstring($sort_array);
    $prestr = $prestr.$key;
	log_result("sign : ".$prestr);
    $mysgin = sign($prestr,$sign_type);
    return $mysgin;
}

function create_linkstring($array) {
    $arg  = "";
    while (list ($key, $val) = each ($array)) {
        $arg.=$key."=".$val."&";
    }
    $arg = substr($arg,0,count($arg)-2);
    return $arg;
}


function para_filter($parameter) {
    $para = array();
    while (list ($key, $val) = each ($parameter)) {
        if($key == "sign" || $key == "sign_type" || $val == "")continue;
        else	$para[$key] = $parameter[$key];
    }
    return $para;
}


function arg_sort($array) {
    ksort($array);
    reset($array);
    return $array;
}

function  log_result($word) {
	// 根目录建立log_alipay.txt文件可以用于记录支付宝的日志信息，方便调试
	/*$fp = fopen("log_alipay.txt","alex");
	flock($fp, LOCK_EX) ;
	fwrite($fp,$word."：excute ：".strftime("%Y-%m-%d %H:%I:%S",time())."\t\n");
	flock($fp, LOCK_UN);
	fclose($fp);*/
}

function charset_encode($input,$_output_charset ,$_input_charset="utf-8") {
    $output = "";
    if(!isset($_output_charset) )$_output_charset  = $_input_charset;
    if($_input_charset == $_output_charset || $input ==null ) {
        $output = $input;
    } elseif (function_exists("mb_convert_encoding")) {
        $output = mb_convert_encoding($input,$_output_charset,$_input_charset);
    } elseif(function_exists("iconv")) {
        $output = iconv($_input_charset,$_output_charset,$input);
    } else die("sorry, you have no libs support for charset change.");
    return $output;
}


function charset_decode($input,$_input_charset ,$_output_charset) {
    $output = "";
    if(!isset($_input_charset) )$_input_charset  = $_input_charset ;
    if($_input_charset == $_output_charset || $input ==null ) {
        $output = $input;
    } elseif (function_exists("mb_convert_encoding")) {
        $output = mb_convert_encoding($input,$_output_charset,$_input_charset);
    } elseif(function_exists("iconv")) {
        $output = iconv($_input_charset,$_output_charset,$input);
    } else die("sorry, you have no libs support for charset changes.");
    return $output;
}


function query_timestamp($partner) {
    $URL = "https://mapi.alipay.com/gateway.do?service=query_timestamp&partner=".$partner;
	$encrypt_key = "";
}

function sign($prestr,$sign_type) {
    $sign='';
    if($sign_type == 'MD5') {
        $sign = md5($prestr);
    }elseif($sign_type =='DSA') {
        //DSA 签名方法待后续开发
        die("DSA 签名方法待后续开发，请先使用MD5签名方式");
    }else {
        die("支付宝暂不支持".$sign_type."类型的签名方式");
    }
    return $sign;
}

?>