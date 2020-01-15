<?php
/**
 * Created by PhpStorm.
 * User: tangmusen
 * Date: 2017/10/30
 * Time: 11:08
 */

namespace app\home\controller;

use app\admin\model\Members;
use think\Controller;
use think\Db;
use think\Request;
use think\Cache;

class Home extends Controller
{
    public $uid;
    public function _initialize()
    {

        //判断是否登入成功
        if(!isHomeLogin()){
            //$this->redirect('Login/index');
        }
        $this->uid = session('member_info.uid');
        $request = Request::instance();
        $controllerName = $request->controller();
        $this->assign('controllerName',strtolower($controllerName));
          
    }

}
