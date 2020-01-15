<?php
/**
 * Created by PhpStorm.
 * User: tangmusen
 * Date: 2017/10/30
 * Time: 11:08
 */
namespace app\home\controller;
use app\admin\model\MsscStage;
use think\Cache;
use think\Config;
use think\Db;
use think\Request;

class Index extends Home
{
    public function index(Request $request){

        
        return view('','');
    }

}
