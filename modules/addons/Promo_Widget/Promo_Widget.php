<?php
if (!defined('WHMCS')) {
	die('This file cannot be accessed directly');
}
use WHMCS\Database\Capsule;
// NeWorld Manager 开始

// 引入文件
require  ROOTDIR . '/modules/addons/NeWorld/library/class/NeWorld.Common.Class.php';

// NeWorld Manager 结束

// 判断函数是否不存在
if (!function_exists('Promo_Widget_config')) {
    // 设置项目
    function Promo_Widget_config() {
        // 实例化扩展类
        $ext = new NeWorld\Extended;

        // 返回结果
        return [
            'name' => 'Promo Widget',
            'description' => '这是基于 WHMCS 平台的一个推广信息展现模块',
            'version' => '1.0',    // 读取配置文件中的版本
            'author' => '<a target="_blank" href="https://neworld.org/">NeWorld</a>',
        ];
    }
}

// 判断函数是否不存在
if (!function_exists('Promo_Widget_activate')) {
    // 插件激活
	function Promo_Widget_activate() {
		// NeWorld Manager 开始
		try {
		    // 实例化模块类
		    $addons = new NeWorld\Addons('WeLogin');
		
		    // 授权返回内容（一个数组，包含有 code/time/info 三个键，分别代表“额外代码”、“验证时间”、“授权信息”）
		    $addons = $_SESSION['NeWorld'][$addons->license];
		
		    // 返回信息
		// NeWorld Manager 结束
			try {
				if (!Capsule::schema()->hasTable('mod_promo_widget')) {
					Capsule::schema()->create('mod_promo_widget', function ($table) {
						$table->increments('id');
						$table->text('type');
						$table->text('title');
						$table->text('content');
						$table->dateTime('date')->default('0000-00-00 00:00:00');
						$table->text('font');
						$table->text('animation');
						$table->text('btntxt');
						$table->text('btnlink');
						$table->text('btntxtcolor');
						$table->text('btncolor');
						$table->text('bgcolor');
						$table->text('titlecolor');
						$table->text('contentcolor');
						$table->text('activated');
						$table->text('views');
					});
				}
			} catch (Exception $e) {
				return [
					'status' => 'error',
					'description' => '不能创建表 mod_promo_widget: ' . $e->getMessage()
				];
			}
			return [
				'status' => 'success',
				'description' => '模块激活成功. 点击 配置 对模块进行设置。'
			];
		// NeWorld Manager 开始
		}
		catch (Exception $e)
		{
		    // 返回信息
			return [
				'status' => 'error',
				'description' => '授权失败: ' . $e->getMessage()
			];
		}
		// NeWorld Manager 结束
	}
}

// 判断函数是否不存在
if (!function_exists('Promo_Widget_deactivate')) {
    // 插件卸载
	function Promo_Widget_deactivate() {
		try {
			Capsule::schema()->dropIfExists('mod_promo_widget');
			return [
				'status' => 'success',
				'description' => '模块卸载成功'
			];
		} catch (Exception $e) {
			return [
				'status' => 'error',
				'description' => 'Unable to drop tables: ' . $e->getMessage()
			];
		}
	}
}

// 判断函数是否不存在
if (!function_exists('Promo_Widget_output')) {
    // 插件输出
    function Promo_Widget_output($vars) {
	    $modulelink = $vars['modulelink'];
        try {
            // 实例化扩展类
            $ext = new NeWorld\Extended;

            try {
                // 实例化数据库类
                $db = new NeWorld\Database;

                // 读取数据库中已激活的产品
                $getData = $db->runSQL([
                    'action' => [
                        'list' => [
                            'sql' => 'SELECT * FROM mod_promo_widget',
                            'all' => true,
                        ],
                    ],
                    'trans' => false,
                ]);
                
				$result['action'] = $_REQUEST['action'];
				
                switch ( $result['action'] ) {
					case 'add':
						// 判断是否有 POST
				        if (!empty($_POST)) {
							$type 			= $_REQUEST['type'];
							$title 			= $_REQUEST['title'];
							$font			= $_REQUEST['font'];
							$animation		= $_REQUEST['animation'];
							$url 			= $_REQUEST['url'];
							$content 		= $_REQUEST['content'];
							$btntxt 		= $_REQUEST['btntxt'];
							$btnlink 		= $_REQUEST['btnlink'];
							$btncolor 		= $_REQUEST['btncolor'];
							$bgcolor 		= $_REQUEST['bgcolor'];
							$titlecolor 	= $_REQUEST['titlecolor'];
							$contentcolor 	= $_REQUEST['contentcolor'];
				            try {
					            \Illuminate\Database\Capsule\Manager::table('mod_promo_widget')->insert([
					            	'type' 			=> $type,
					            	'title' 		=> $title, 
					            	'content' 		=> $content, 
					            	'date' 			=> date('Y-m-d H:i:s'), 
					            	'font' 			=> $font, 
					            	'animation' 	=> $animation, 
					            	'btntxt' 		=> $btntxt, 
					            	'btnlink' 		=> $btnlink, 
					            	'btncolor' 		=> $btncolor, 
					            	'bgcolor' 		=> $bgcolor, 
					            	'titlecolor' 	=> $titlecolor, 
					            	'contentcolor' 	=> $contentcolor, 
					            	'activated' 	=> 'on'
					            ]);
				
				                // 返回成功的通知
				                $result['notice'] .= $ext->getSmarty([
				                    'file' => 'tips/success',
				                    'vars' => [
				                        'message' => '操作成功，相应的设置已保存',
				                    ],
				                ]);
				            }
				            catch (Exception $e) {
				                $result['notice'] .= $ext->getSmarty([
				                    'file' => 'tips/danger',
				                    'vars' => [
				                        'message' => '操作失败，错误信息: '.$e->getMessage(),
				                    ],
				                ]);
				            }
				        }
						$result['PageName'] = 'content';
						break;
					case 'edit':
						try {
							$id = (int) $_REQUEST['id'];
							// 判断是否有 POST
					        if (!empty($_POST)) {
								$type 			= $_REQUEST['type'];
								$title 			= $_REQUEST['title'];
								$font			= $_REQUEST['font'];
								$animation		= $_REQUEST['animation'];
								$url 			= $_REQUEST['url'];
								$content 		= $_REQUEST['content'];
								$btntxt 		= $_REQUEST['btntxt'];
								$btnlink 		= $_REQUEST['btnlink'];
								$btncolor 		= $_REQUEST['btncolor'];
								$bgcolor 		= $_REQUEST['bgcolor'];
								$titlecolor 	= $_REQUEST['titlecolor'];
								$contentcolor 	= $_REQUEST['contentcolor'];
					            try {
						            \Illuminate\Database\Capsule\Manager::table('mod_promo_widget')->where('id', $id)->update([
						            	'type' 			=> $type,
						            	'title' 		=> $title, 
						            	'content' 		=> $content, 
						            	'date' 			=> date('Y-m-d H:i:s'), 
						            	'font' 			=> $font, 
						            	'animation' 	=> $animation, 
						            	'btntxt' 		=> $btntxt, 
						            	'btnlink' 		=> $btnlink, 
						            	'btncolor' 		=> $btncolor, 
						            	'bgcolor' 		=> $bgcolor, 
						            	'titlecolor' 	=> $titlecolor, 
						            	'contentcolor' 	=> $contentcolor, 
						            ]);
					
					                // 返回成功的通知
					                $result['notice'] .= $ext->getSmarty([
					                    'file' => 'tips/success',
					                    'vars' => [
					                        'message' => '操作成功，相应的设置已保存',
					                    ],
					                ]);
					            }
					            catch (Exception $e) {
					                $result['notice'] .= $ext->getSmarty([
					                    'file' => 'tips/danger',
					                    'vars' => [
					                        'message' => '操作失败，错误信息: '.$e->getMessage(),
					                    ],
					                ]);
					            }
					        }
					        // 读取数据库中的数据
					        $getData = $db->runSQL([
					            'action' => [
					                'setting' => [
					                    'sql' => 'SELECT * FROM mod_promo_widget WHERE id = ?',
					                    'pre' => [$id],
					                ],
					            ],
					            'trans' => false,
					        ]);
					
					        // 声明一个空的关联数组
					        $setting = [];
					
					    	// 默认会返回控制台的变量组
						    $result['setting'] = $getData['setting']['result'];
						    $result['id'] = $id;
							$result['PageName'] = 'content';
							
						} catch (Exception $e) {
							// 返回提示
	                        $result['notice'] .= $ext->getSmarty([
	                            'file' => 'tips/danger',
	                            'vars' => [
	                                'message' => '当前没有激活的主题模板，错误信息: '.$e->getMessage(),
	                            ],
	                        ]);
						}
						break;
					case 'act':
						$id = (int) $_REQUEST['id'];
						// 判断是否有 POST
				        if (!empty($_POST)) {
				            try {
					            // 读取数据库中的数据
						        $getData = $db->runSQL([
						            'action' => [
						                'setting' => [
						                    'sql' => 'SELECT * FROM mod_promo_widget WHERE id = ?',
						                    'pre' => [$id],
						                ],
						            ],
						            'trans' => false,
						        ]);
						        
						        $activated = $getData['setting']['result']['activated'];
						        $title = $getData['setting']['result']['title'];
						        
						        if ( empty( $activated ) ) {
							        \Illuminate\Database\Capsule\Manager::table('mod_promo_widget')->where('id', $id)->update([
							            'activated' 	=> 'on' 
							        ]);
							        $activated = '显示';
							        $cssclass = 'success';
						        } else {
							        \Illuminate\Database\Capsule\Manager::table('mod_promo_widget')->where('id', $id)->update([
							            'activated' 	=> '' 
							        ]);
							        $activated = '隐藏';
							        $cssclass = 'danger';
						        }
								$value = [
									'status' 		=> 'success',
									'class' 		=> $cssclass,
									'msg' 			=> $activated,
									'title' 		=> $title,
								];
				            }
				            catch (Exception $e) {
				                $value = [
									'status' => 'danger',
									'msg'	 => $e->getMessage(),
								];
				            }
				            die(json_encode($value));
				        }
						break;
					case 'del':
			            $id = (int) $_REQUEST['id'];
						// 判断是否有 POST
				        if (!empty($_POST)) {
				            try {
					            \Illuminate\Database\Capsule\Manager::table('mod_promo_widget')->where('id', $id)->delete();
								$value = [
									'status' => 'success',
								];
				            }
				            catch (Exception $e) {
				                $value = [
									'status' => 'error',
									'msg'	 => $e->getMessage(),
								];
				            }
				            die(json_encode($value));
				        }
						break;
					default:
				
		                // 返回给模板
		                $result['promo'] = $getData['list']['result'];
		
		                // 遍历产品数组
		                foreach ($result['promo'] as $key => $value) {
		                    try {
		                        $result['promo'][$key]['title'] = $result['promo'][$key]['title'];
		
		                    }
		                    catch (Exception $e) {
		                        // 销毁要返回的数组
		                        unset($result['promo'][$key]);
		
		                        // 返回提示
		                        $result['notice'] .= $ext->getSmarty([
		                            'file' => 'tips/danger',
		                            'vars' => [
		                                'message' => '无法获取标题 [ '.$value['title'].' ] 在数据库中的信息，错误信息: '.$e->getMessage(),
		                            ],
		                        ]);
		                    }
		                }
						$result['PageName'] = 'index';
						break;
				}
				
				$result['assets'] = $ext->getSystemURL().'modules/addons/'.$vars['module'].'/templates/';
				$result['version'] = $vars['version'];
				$result['module'] = $vars['modulelink'];

                // 把 $result 放入模板需要输出的变量组中
                $result = $ext->getSmarty([
					'dir' => __DIR__ . '/templates/',
                    'file' => 'home',
                    'vars' => $result,
                ]);
            }
            catch (Exception $e) {
                // 输出错误信息
                $result = $ext->getSmarty([
                    'file' => 'tips/danger',
                    'vars' => [
                        'message' => $e->getMessage(),
                    ],
                ]);
            }
            finally {
                echo $result;
            }
        }
        catch (Exception $e) {
            // 如果报错则终止并输出错误
            die($e->getMessage());
        }
    }
}