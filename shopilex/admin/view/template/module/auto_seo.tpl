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
    <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $back; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
        <tr>
          <td><?php echo $text_all_seo;?></td>
          <td>
          <button type="submit" name="all_seo" value="all_seo"><?php echo $generate;?></button>
          <?php echo $warning_clear;?>
          </td>
        </tr>
       
      </table>
    </form>
  </div>
</div>
<?php echo $footer; ?>