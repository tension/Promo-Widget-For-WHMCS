<!-- include summernote css/js-->
<link rel="stylesheet" type="text/css" href="{$assets}assets/summernote/summernote.min.css" />
<script type="text/javascript" src="{$assets}assets/summernote/summernote.min.js"></script>
<script type="text/javascript" src="{$assets}assets/summernote/lang/summernote-zh-CN.min.js"></script>
<script>
	$(function() {
        $('.tinymce').summernote({
	          toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'link']],
			    ['clear', ['clear']]
			],
			lang : 'zh-CN',
			minHeight : 120,
			dialogsFade : true,
			dialogsInBody : true,
			disableDragAndDrop : false,
        });
	    $('.layout-list > li').click(function(){
			$(this).addClass('layout-icon_active').find('input[type=radio]').attr('checked', 'checked');
			$(this).siblings().removeClass('layout-icon_active').find('input[type=radio]').removeAttr('checked');
		});
		$('.widget-preview__btn_desktop').click(function(){
			$(this).addClass('active');
			$('.widget-preview__btn_mobile').removeClass('active');
			$('.mobile-preview').hide();
			$('.desktop-preview').show();
		});
		$('.widget-preview__btn_mobile').click(function(){
			$(this).addClass('active');
			$('.widget-preview__btn_desktop').removeClass('active');
			$('.desktop-preview').hide();
			$('.mobile-preview').show();
		});
		var title 			= $('input[name=title]').val();
		var content 		= $('#content').val();
		var type 			= $('input[name=type]:checked').val();
		var bgcolor 		= $('input[name=bgcolor]').val();
		var titlecolor 		= $('input[name=titlecolor]').val();
		var contentcolor 	= $('input[name=contentcolor]').val();
		var animation 		= $('select[name=animation]:selected').val();
		$('.frame .promowidget').addClass(type).addClass(animation).css({
			'color': contentcolor,
			'background-color': bgcolor
		});
		$('.frame .promowidget .title').text(title).css({
			'color': titlecolor,
		});
		$('.frame .promowidget .content').html(content).css({
			'color': contentcolor,
		});
		var dwidget = $('.desktop-frame').html();
		var mwidget = $('.mobile-frame').html();
		$('.desktop-preview-frame iframe').contents().find("body").append(dwidget);
		$('.mobile-preview-frame iframe').contents().find("body").append(mwidget);
	});
	
</script>
<div class="block block-rounded block-bordered">
    <ul class="nav nav-tabs" role="tablist">
        <li class="pull-right">
        	<span>{$setting['title']}</span>
        </li>
        <li class="active">
        	<a class="tab-top" href="#tab1" role="tab" data-toggle="tab" id="tabLink1" data-tab-id="1" aria-expanded="true">外观</a>
        </li>
        <li>
        	<a class="tab-top" href="#tab2" role="tab" data-toggle="tab" id="tabLink2" data-tab-id="2" aria-expanded="true">内容</a>
        </li>
        <li>
        	<a class="tab-top" href="#tab3" role="tab" data-toggle="tab" id="tabLink3" data-tab-id="3" aria-expanded="true">行为</a>
        </li>
        <li>
        	<a class="tab-top" href="#tab4" role="tab" data-toggle="tab" id="tabLink4" data-tab-id="4" aria-expanded="true">针对</a>
        </li>
    </ul>
	<form class="form-horizontal" method="POST" action="{$module}&action={$action}{if $action == 'edit'}&id={$id}{/if}">

    <div class="block-content">
        <div class="row items-push">
		    <div class="col-sm-6">
			    <div class="tab-content">
					<div class="tab-pane active" id="tab1">
				        <div class="form-group">
				            <label class="col-xs-12">位置</label>
				            <ul class="layout-list clearfix">
				                <li class="layout-list__i {if $setting['type'] == 'full'}layout-icon_active{/if}">
				                    <input type="radio" name="type" value="full" {if $setting['type'] eq "full"} checked{/if} />
				                    <span class="layout-icon layout-icon_full"></span>
				                </label>
				                <li class="layout-list__i {if $setting['type'] == 'left'}layout-icon_active{/if}">
				                    <input type="radio" name="type" value="left" {if $setting['type'] eq "left"} checked{/if} />
				                	<span class="layout-icon layout-icon_left"></span>
				                </li>
				                <li class="layout-list__i {if $setting['type'] == 'right'}layout-icon_active{/if}">
				                    <input type="radio" name="type" value="right" {if $setting['type'] eq "right"} checked{/if} />
				                    <span class="layout-icon layout-icon_right"></span>
				                </label>
				                <li class="layout-list__i {if $setting['type'] == 'top'}layout-icon_active{/if}">
				                    <input type="radio" name="type" value="top" {if $setting['type'] eq "top"} checked{/if} />
				                    <span class="layout-icon layout-icon_top"></span>
				                </label>
				                <li class="layout-list__i {if $setting['type'] == 'bottom'}layout-icon_active{/if}">
				                    <input type="radio" name="type" value="bottom" {if $setting['type'] eq "bottom"} checked{/if} />
				                    <span class="layout-icon layout-icon_bottom"></span>
				                </label>
				            </ul>
				        </div>
				        <div class="form-group">
			                <label class="col-xs-12">颜色</label>
		                    <div class="js-colorpicker col-xs-4 push-15">
		                        <input type="hidden" name="bgcolor" value="{$setting['bgcolor']}">
		                        <span class="input-group-addon"><i></i> 背景颜色</span>
		                    </div>
		                    <div class="js-colorpicker col-xs-4 push-15">
		                        <input type="hidden" name="titlecolor" value="{$setting['titlecolor']}">
		                        <span class="input-group-addon"><i></i> 标题颜色</span>
				            </div>
		                    <div class="js-colorpicker col-xs-4 push-15">
		                        <input type="hidden" name="contentcolor" value="{$setting['contentcolor']}">
		                        <span class="input-group-addon"><i></i> 文字颜色</span>
		                    </div>
		                    <div class="js-colorpicker col-xs-4">
		                        <input type="hidden" name="btncolor" value="{$setting['btncolor']}">
		                        <span class="input-group-addon"><i></i> 按钮背景</span>
		                    </div>
		                    <div class="js-colorpicker col-xs-4">
		                        <input type="hidden" name="btntxtcolor" value="{$setting['btntxtcolor']}">
		                        <span class="input-group-addon"><i></i> 按钮文字颜色</span>
		                    </div>
				        </div>
				        <div class="form-group">
				            <div class="col-xs-12">
				                <label for="sitename">字体</label>
				                <select class="form-control js-select2" name="font">
					                <option value="Helvetica Neue, Helvetica, Arial, sans-serif" {if $setting['font'] eq "Helvetica Neue, Helvetica, Arial, sans-serif"} selected{/if}>Helvetica Neue, Helvetica, Arial, sans-serif</option>
					                <option value="Georgia, Times New Roman, Times, serif" {if $setting['font'] eq "Georgia, Times New Roman, Times, serif"} selected{/if}>Georgia, Times New Roman, Times, serif</option>
					            </select>
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-xs-12">
				                <label for="sitename">动画</label>
				                <select class="form-control js-select2" name="animation">
					                <option value="None"{if $setting['animation'] eq "None"} selected{/if}>无</option>
					                <option value="fadeIn"{if $setting['animation'] eq "fadeIn"} selected{/if}>Fade</option>
					                <option value="fadeInUp"{if $setting['animation'] eq "fadeInUp"} selected{/if}>Fade up</option>
					                <option value="fadeInLeft"{if $setting['animation'] eq "fadeInLeft"} selected{/if}>Fade left</option>
					                <option value="bounceIn"{if $setting['animation'] eq "bounceIn"} selected{/if}>Bounce</option>
					                <option value="bounceInUp"{if $setting['animation'] eq "bounceInUp"} selected{/if}>Bounce up</option>
					                <option value="bounceInLeft"{if $setting['animation'] eq "bounceInLeft"} selected{/if}>Bounce left</option>
					                <option value="zoomIn"{if $setting['animation'] eq "zoomIn"} selected{/if}>Zoom</option>
					            </select>
				            </div>
				        </div>
				    </div>
			        <div class="tab-pane" id="tab2">
				        <div class="form-group">
				            <div class="col-xs-12">
				                <label for="sitename">标题</label>
				                <input class="form-control" type="text" id="title" name="title" placeholder="输入标题.." value="{$setting['title']}" />
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-xs-12">
				                <label for="tongji">内容</label>
				                <textarea class="form-control tinymce" id="content" name="content" rows="8" placeholder="输入您的内容..">{$setting['content']}</textarea></div>
				        </div>
				        <div class="form-group">
				            <div class="col-xs-12">
				                <label class="control-label" for="sitename">按钮文字</label>
				                <input class="form-control" type="text" id="btntxt" name="btntxt" placeholder="查看详情.." value="{$setting['btntxt']}" />
				            </div>
				        </div>
				        <div class="form-group">
				            <div class="col-xs-12">
				                <label class="control-label" for="sitename">按钮连接</label>
				                <input class="form-control" type="text" id="btnlink" name="btnlink" placeholder="{$systemurl}" value="{$setting['btnlink']}" />
				            </div>
				        </div>
			        </div>
			        <div class="tab-pane" id="tab3">
				        尽情期待
			        </div>
			        <div class="tab-pane" id="tab4">
				        尽情期待
			        </div>
			    </div>
			</div>
		    <div class="col-sm-6">
				<div class="desktop-preview">
					<div class="desktop-preview-url">{$systemurl}</div>
					<div class="desktop-preview-frame preview-frame">
						<iframe src="javascript:void(0)" frameborder="0" style="transform: scale(0.5); transform-origin: 0px 0px 0px; width: 892px; height: 612px;"></iframe>
					</div>
				</div>
				<div class="mobile-preview" style="display: none">
					<div class="mobile-preview-url">{$systemurl}</div>
					<div class="mobile-preview-frame preview-frame">
						<iframe src="javascript:void(0)" frameborder="0" style="width: 324px; height: 482px;"></iframe>
					</div>
				</div>
				<div class="widget-preview__footer">
					<button type="button" class="widget-preview__btn widget-preview__btn_desktop btn btn_sm active">
						<span class="widget-preview__icon"></span>
					</button>
					<button type="button" class="widget-preview__btn widget-preview__btn_mobile btn btn_sm ">
						<span class="widget-preview__icon"></span>
					</button>
				</div>
		    </div>
        </div>
    </div>
    <div class="block-content bg-gray-lighter text-center">
		<button class="btn btn-noborder btn-minw btn-rounded btn-primary push-15-r" type="submit">
			<i class="fa fa-check push-5-r"></i> 确认
		</button>
		<button class="btn btn-noborder btn-minw btn-rounded btn-warning" type="reset">
			<i class="fa fa-refresh push-5-r"></i> 重置
		</button>
	</div>
	</form>
</div>
<div class="desktop-frame frame" style="display: none">
	<link href="{$vars['systemurl']}/modules/addons/Promo_Widget/templates/assets/css/fed.css" rel="stylesheet" type="text/css">
	<div class="promo-widget">
		<div class="promowidget  animated">
			<div class="title"></div>
			<div class="content">
				
			</div>
			<a href="https://neworld.org" tabindex="-1" class="powered" target="_blank">Powered by NeWorld</a>
			<span class="close">&times;</span>
		</div>
	</div>
</div>
<div class="mobile-frame frame" style="display: none">
	<link href="{$vars['systemurl']}/modules/addons/Promo_Widget/templates/assets/css/fed.css" rel="stylesheet" type="text/css">
	<link href="{$vars['systemurl']}/modules/addons/Promo_Widget/templates/assets/css/mobile.css" rel="stylesheet" type="text/css">
	<div class="promo-widget">
		<div class="promowidget  animated">
			<div class="title"></div>
			<div class="content">
				
			</div>
			<a href="https://neworld.org" tabindex="-1" class="powered" target="_blank">Powered by NeWorld</a>
			<span class="close">&times;</span>
		</div>
	</div>
</div>