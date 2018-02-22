<?php
if (!defined('WHMCS')) {
	die('This file cannot be accessed directly');
}
use WHMCS\Database\Capsule;

add_hook('ClientAreaFooterOutput', 1, function ($vars){
	
	$promo = Capsule::table('mod_promo_widget')->orderBy('id', 'DESC')->first();
	$type = $promo->type;
	$title = $promo->title;
	$content = htmlspecialchars_decode($promo->content);
	$titlecolor = $promo->titlecolor;
	$contentcolor = $promo->contentcolor;
	$btntxt = $promo->btntxt;
	$btnlink = $promo->btnlink;
	$btncolor = $promo->btncolor;
	$btntxtcolor = $promo->btntxtcolor;
	$font = htmlspecialchars_decode($promo->font);
	$animation = $promo->animation;
	$bgcolor = $promo->bgcolor;
	$activated = $promo->activated;
	if ($btntxt) {
		$btntxt = '<a href="'.$btnlink.'" class="btn">'.$btntxt.'</a>';
	}
	if ( $activated == 'on' ) {
		return <<<EOF
<script>
$(function () {
	$('.promowidget .close').click(function() {
        $('.promo-widget').hide();
    });
});
</script>
<link href="{$vars['systemurl']}/modules/addons/Promo_Widget/templates/assets/css/fed.css" rel="stylesheet" type="text/css">
<style>
.promowidget {
    font-family: {$font};
    color: {$contentcolor};
    background-color: {$bgcolor};
}
.promowidget .title {
    color: {$titlecolor};
}
.promowidget .btn {
	color: {$btntxtcolor} !important;
    background-color: {$btncolor} !important;
}
</style>
<div class="promo-widget">
	<div class="promowidget {$type} {$animation} animated">
		<div class="title">{$title}</div>
		<div class="content">
			{$content}
		</div>
		{$btntxt}
		<a href="https://neworld.org" tabindex="-1" class="powered" target="_blank">Powered by NeWorld</a>
		<span class="close">&times;</span>
	</div>
</div>
EOF;
	}
});