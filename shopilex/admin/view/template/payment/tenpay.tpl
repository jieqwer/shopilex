<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
    <h1 ><?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location='<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
		<tr>
		<td><span class="required">*</span> <?php echo $entry_trade_type; ?><br></td>
          <td>
			直接到帐:&nbsp;<input type="radio" name="tenpay_cmdno" value="1"  checked="true"/>&nbsp;&nbsp;
		</td>
        </tr>
        
	  	<tr>
          <td><span class="required">*</span> <?php echo $entry_seller; ?></td>
          <td><input type="text" name="tenpay_seller" value="<?php echo $tenpay_seller; ?>" size="50" />
	 		 <?php if ($error_seller) { ?>
            <span class="error"><?php echo $error_seller; ?></span>
            <?php } ?></td>
        </tr>
		<tr>
          <td><span class="required">*</span> <?php echo $entry_key; ?></td>
          <td><input type="text" name="tenpay_key" value="<?php echo $tenpay_key; ?>" size="50" />
	 		 <?php if ($error_key) { ?>
            <span class="error"><?php echo $error_key; ?></span>
            <?php } ?></td>
        </tr>
		<tr>
          <td><span class="required">*</span> <?php echo $entry_bargainor_id; ?></td>
          <td><input type="text" name="tenpay_bargainor_id" value="<?php echo $tenpay_bargainor_id; ?>" size="50" />
	  		<?php if ($error_bargainor_id) { ?>
            <span class="error"><?php echo $error_bargainor_id; ?></span>
            <?php } ?></td>
        </tr>
	  
        <tr>
          <td><?php echo $entry_order_status; ?></td>
          <td><select name="tenpay_order_status_id">
              <?php foreach ($order_statuses as $order_status) { ?>
              <?php if ($order_status['order_status_id'] == $tenpay_order_status_id) { ?>
              <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select></td>
        </tr>
        <tr>
          <td><?php echo $entry_status; ?></td>
          <td><select name="tenpay_status">
              <?php if ($tenpay_status) { ?>
              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_enabled; ?></option>
              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
        </tr>
        <tr>
          <td><?php echo $entry_sort_order; ?></td>
          <td><input type="text" name="tenpay_sort_order" value="<?php echo $tenpay_sort_order; ?>" size="1" /></td>
        </tr>
		 <tr>
          <td>&nbsp;</td>
          <td>使用注意已经存在CNY的人民币汇率设置。Code为CNY</td>
        </tr>
      </table>
    </form>
  </div>
</div>
<?php echo $footer; ?>