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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/setting.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-mail"><?php echo $tab_mail; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        
        <div id="tab-mail">
          <table class="form">
            <tr>
              <td><?php echo $entry_mail_protocol; ?></td>
              <td><select name="config_mail_protocol">
              	 <?php if ($config_mail_protocol == '0') { ?>
                  <option value="0" selected="selected"><?php echo $text_no_mail; ?></option>
                  <?php } else { ?>
                 	 <option value="0"><?php echo $text_no_mail; ?></option>
                  <?php } ?>
                  <?php if ($config_mail_protocol == 'mail') { ?>
                  <option value="mail" selected="selected"><?php echo $text_mail; ?></option>
                  <?php } else { ?>
                  <option value="mail"><?php echo $text_mail; ?></option>
                  <?php } ?>
                  <?php if ($config_mail_protocol == 'smtp') { ?>
                  <option value="smtp" selected="selected"><?php echo $text_smtp; ?></option>
                  <?php } else { ?>
                  <option value="smtp"><?php echo $text_smtp; ?></option>
                  <?php } ?>
                  
                  
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_mail_parameter; ?></td>
              <td><input type="text" name="config_mail_parameter" value="<?php echo $config_mail_parameter; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_host; ?></td>
              <td><input type="text" name="config_smtp_host" value="<?php echo $config_smtp_host; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_username; ?></td>
              <td><input type="text" name="config_smtp_username" value="<?php echo $config_smtp_username; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_password; ?></td>
              <td><input type="text" name="config_smtp_password" value="<?php echo $config_smtp_password; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_port; ?></td>
              <td><input type="text" name="config_smtp_port" value="<?php echo $config_smtp_port; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_timeout; ?></td>
              <td><input type="text" name="config_smtp_timeout" value="<?php echo $config_smtp_timeout; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_alert_mail; ?></td>
              <td><?php if ($config_alert_mail) { ?>
                <input type="radio" name="config_alert_mail" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_alert_mail" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_alert_mail" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_alert_mail" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
			<tr>
              <td><?php echo $entry_account_mail; ?></td>
              <td><?php if ($config_account_mail) { ?>
                <input type="radio" name="config_account_mail" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_account_mail" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_account_mail" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_account_mail" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_alert_emails; ?></td>
              <td><textarea name="config_alert_emails" cols="40" rows="5"><?php echo $config_alert_emails; ?></textarea></td>
            </tr>
          </table>
        </div>
        
      </form>
    </div>
  </div>
</div>

<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<?php echo $footer; ?>