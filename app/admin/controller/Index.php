<?php
namespace app\admin\controller;



use think\Db;
use think\Request;
use app\admin\model\Detail;
use app\admin\model\Members;
use app\admin\model\Recharge;

class Index extends Admin
{
    public function index_bakk()
    {
        $sys_info = $this->get_sys_info();
        $this->assign('sys_info',$sys_info);
        return view();
    }

    public function index()
    {
        $info    = session('info');
        $list = Members::where([])->order('id desc')->paginate(10,false,['query'=>request()->param()]);
        $list = $list->all();
        $this->assign('list',$list);
        $this->assign('info',$info);
        return view();
    }

    /**
     * 获取系统信息
     */
    public function get_sys_info(){
        $sys_info['os']             = PHP_OS;
        $sys_info['zlib']           = function_exists('gzclose') ? 'YES' : 'NO';//zlib
        $sys_info['safe_mode']      = (boolean) ini_get('safe_mode') ? 'YES' : 'NO';//safe_mode = Off
        $sys_info['timezone']       = function_exists("date_default_timezone_get") ? date_default_timezone_get() : "no_timezone";
        $sys_info['curl']           = function_exists('curl_init') ? 'YES' : 'NO';
        $sys_info['web_server']     = $_SERVER['SERVER_SOFTWARE'];
        $sys_info['phpv']           = phpversion();
        $sys_info['ip']             = GetHostByName($_SERVER['SERVER_NAME']);
        $sys_info['fileupload']     = @ini_get('file_uploads') ? ini_get('upload_max_filesize') :'unknown';
        $sys_info['max_ex_time']    = @ini_get("max_execution_time").'s'; //�ű����ִ��ʱ��
        $sys_info['set_time_limit'] = function_exists("set_time_limit") ? true : false;
        $sys_info['domain']         = $_SERVER['HTTP_HOST'];
        $sys_info['memory_limit']   = ini_get('memory_limit');
        $sys_info['version']        = '1.1.0';
        //$mysqlinfo = Db::query("SELECT VERSION() as version");
        $sys_info['mysql_version']  = 5.4;
        if(function_exists("gd_info")){
            $gd = gd_info();
            $sys_info['gdinfo']     = $gd['GD Version'];
        }else {
            $sys_info['gdinfo']     = "δ֪";
        }
        return $sys_info;
    }
}
