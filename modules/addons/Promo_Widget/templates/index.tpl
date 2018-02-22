<div class="block block-rounded block-bordered">
    <div class="block-content" style="padding:0">
        <table id="license-list" class="table table-hover small" style="margin-bottom:0">
	        <colgroup>
	        	<col width="60%">
	        	<col width="13%">
	        	<col width="5%">
	        	<col width="12%">
	        </colgroup>
            <thead>
	            <tr>
	                <th>标题</th>
	                <th class="hidden-xs">添加时间</th>
	                <th class="text-center">状态</th>
	                <th class="text-right">操作</th>
	            </tr>
            </thead>
            <tbody>
            {if $promo}
                {foreach $promo as $value}
                    <tr id="promo_{$value['id']|trim}">
                        <td>{$value['title']}</td>
                        <td class="hidden-xs">{$value['date']|date_format:"%Y-%m-%d"}</td>
                        <td class="text-center">
	                        {if $value['activated'] == 'on'}
	                        	<a id="act_{$value['id']|trim}" onClick="javascript:acT({$value['id']|trim});" class="label label-success">显示</a>
	                        {else}
	                        	<a id="act_{$value['id']|trim}" onClick="javascript:acT({$value['id']|trim});" class="label label-danger">隐藏</a>
	                        {/if}
                        </td>
                        <td>
                            <a class="btn btn-danger btn-xs pull-right" onClick="javascript:Delete({$value['id']|trim});">
                                <span class="glyphicon glyphicon-floppy-remove"></span> 删除
                            </a>
                            <a class="btn btn-info btn-xs pull-right push-10-r" href="./{$module}&action=edit&id={$value['id']|trim}">
                                <span class="glyphicon glyphicon-floppy-saved"></span> 编辑
                            </a>
                        </td>
                    </tr>
                {/foreach}
            {else}
                <tr id="message">
                    <td colspan="6" class="text-center">
                        当前还没有添加任何内容
                    </td>
                </tr>
            {/if}
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript">
function Delete( ID ) {
	$.ajax({
		method: "POST",
		url: "{$module}&action=del",
		data: { id: ID },
		dataType: 'json',
		cache: false,
		beforeSend:function() {
			completeFlag = false;
		},
		complete:function() {
			completeFlag = true;
		},
		success: function(data) {
			if(data.status=='success') {
				$.growl.notice({
					title: "成功",
					message: "已成功删除!"
				});
			} else if (data.status=='error') {
				$.growl.warning({
		    		title: "错误",
					message: data.msg
		    	});
			};
			$('#promo_'+ID).hide(1000, function(){
				$('#promo_'+ID).animate({
                    "opacity":"0"
                },800);
			});
		},
		error:function() {
			$.growl.warning({
	    		title: "错误",
				message: "服务器忙，请稍后重试"
	    	});
		}
	});
}
function acT( ID ) {
	$.ajax({
		method: "POST",
		url: "{$module}&action=act",
		data: { id: ID },
		dataType: 'json',
		cache: false,
		beforeSend:function() {
			completeFlag = false;
		},
		complete:function() {
			completeFlag = true;
		},
		success: function(data) {
			if(data.status=='success') {
				if ( data.class == 'success' ) {
					$('#act_'+ID).removeClass('label-danger').addClass('label-success').text(data.msg);
				} else {
					$('#act_'+ID).removeClass('label-success').addClass('label-danger').text(data.msg);
				}
				$.growl.notice({
					title: "成功"+data.msg,
					message: data.title
				});
			} else if (data.status=='danger') {
				$.growl.warning({
		    		title: "错误",
					message: data.msg
		    	});
			};
		},
		error:function() {
			$.growl.warning({
	    		title: "错误",
				message: "服务器忙，请稍后重试"
	    	});
		}
	});
}
</script>