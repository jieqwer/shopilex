<?php echo $header; ?>
<div id="login-header" >

</div>

<div id="content">
  <div class="box" style="width:70%; display:inline; min-height: 300px; margin-top: 40px;float:right;">
    <div class="content" id="login" style="min-height: 150px; overflow: hidden;width:350px;">
      <h2 style="color:#DD4B39;">登录Shopilex后台管理</h2>
      <?php if ($success) { ?>
      <div class="success"><?php echo $success; ?></div>
      <?php } ?>
      <?php if ($error_warning) { ?>
      <div class="warning"><?php echo $error_warning; ?></div>
      <?php } ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table style="width: 100%;">
          <tr>
            <td><?php echo $entry_username; ?><br />
              <input type="text" name="username" value="<?php echo $username; ?>" style="margin-top: 4px;width:330px;" />
              <br />
              <br />
              <?php echo $entry_password; ?><br />
              <input type="password" name="password" value="<?php echo $password; ?>" style="margin-top: 4px;width:330px"/>
              <!--   <br />
             	 <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
              -->
              </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td style="text-align: right;"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_login; ?></span></a></td>
          </tr>
        </table>
        <?php if ($redirect) { ?>
        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        <?php } ?>
      </form>
     
    
    </div>
  </div>
  
</div>
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#form').submit();
	}
});
//--></script> 
<?php echo $footer; ?>