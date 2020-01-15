<?php
namespace app\admin\controller;

use think\Cache;
use think\Config;
use think\Controller;
use think\Db;
use think\Request;

class admin extends Controller
{
    public function _initialize()
    {
        //判断是否登入成功
        if(!isAdminLogin()){
            $this->redirect('Login/index');
        }
        $request = Request::instance();
        $moduleName     = $request->module();
        $controllerName = $request->controller();
        $actionName     = $request->action();

        $pdata = db('right')->where(array('control'=>strtolower($controllerName),'act'=>strtolower($actionName)))->where(['pid'=>array('<>',0)])->find();
        if(!$pdata['pid']){
            $pdata2 = db('right')->where(array('control'=>strtolower($controllerName),'act'=>'index'))->where(['pid'=>array('<>',0)])->find();
        }
        $this->assign('pid',$pdata['pid']?$pdata['pid']:$pdata2['pid']);
        $this->assign('id',$pdata['id']);
        $menu_list      = $this->getMenuList();
        //判断权限
        $auth=new \Auth\Auth() or die('加载auth类失败');
        $rule_name=$moduleName.'/'.$controllerName.'/'.$actionName;

        $result=$auth->check($rule_name,session('admin_login.uid'));
        if(!$result){
            //echo '<script>alert(\'对不起,您的权限不足!\');history.go(-1)</script>';exit;
        }
        //记录日志
        $operation_obj = new \Net\Operation();
        if (preg_match('/add|save|saveEdit|delete|edit|ajaxdel|del|dj(.*)?/', $actionName)) {
            $operation_obj->writeLog();
        }
        $info    = session('info');
        $this->assign('menu_list',$menu_list);
        $this->assign('controllerName',strtolower($controllerName));
        $this->assign('actionName',strtolower($actionName));
        $this->assign('info',$info);

    }
    public  function  checkRule(){

    }
    /**
     * 上传一张图片
     */
    public function upload_one(){
        $file = request()->file('file');
        if(!$file){
            $data = array("status" =>0,"error" => '请选择上传图片');
            echo json_encode($data);
            exit;
        }
        $path = ROOT_PATH . 'public' . DS . 'uploads'. DS .'cate_img';
        $info = $file->move($path);
        if($info){
            $picd = 'cate_img/'.$info->getSaveName();
            $pic = Config::get('img_url').$picd;
            $data = array("status" =>1,"pic" => $pic,'picd'=>$picd);
            echo json_encode($data);
            exit;
        }else{
            $data = array("status" =>0,"error" => '上传图片失败');
            echo json_encode($data);
            exit;
        }
    }


    /**
     * 获取菜单列表
     * @return array
     */
    public function getMenuList(){
        $uid = session('info.id');
        if($uid==1){
            $menu_list = $this->getAllMenu();
        }else {
            //查询用户所在分组
            $group_ids = Db::name('auth_group_access')->where(array('uid' => $uid))->column('group_id');


            $group_rules = Db::name('auth_group')->where('id', 'in', $group_ids)->select();
            //6,456,457,461,462,463,495,496,508,510,511,512,475,478,479,480,507

            $rules = "";

            foreach ($group_rules as $k => $v) {
                if ($k == 0) {
                    $rules = $v['rules'];
                }else {
                    $rules .= "," . $v['rules'];
                }
            }
            $rules = explode(',', $rules);


            $rules = array_unique($rules);
            $rule_name = Db::name('auth_rule')->where('id', 'in', $rules)->field('name,title')->select();

            $rule_use = [];
            foreach ($rule_name as $vv) {
                $rule_use[] = strtolower($vv['name']);
            }

            foreach ($rule_use as $vv) {
                $arr = explode('/',$vv);
                $rule_use[] = 'admin/'.$arr[1].'/index';
            }

            $rule_use = array_unique($rule_use);


            $menu_list = $this->getAllMenu();
            foreach ($menu_list as $k => &$v) {
                //去掉1及
                if($v['act']){
                    $url = 'admin/' . $v['control'] . '/' . $v['act'];
                }else{
                    $url = 'admin/' . $v['control'];
                }
                if (!in_array($url, $rule_use)) {
                    unset($menu_list[$k]);
                }
                //去掉二级权限
                if(isset($v['sub_menu'])&&$v['sub_menu']){
                    foreach ($v['sub_menu'] as  $k1=>$v1){
                        if($v1['act']){
                            $url1= 'admin/' . $v1['control'] . '/' . $v1['act'];
                        }else{
                            $url1 = 'admin/' . $v1['control'];
                        }
                        if (!in_array($url1, $rule_use)) {

                            unset($v['sub_menu'][$k1]);
                        }
                    }


                }
            }


        }
        return $menu_list;
    }
    /**
     * 菜单列表详情
     * @return array
     */
    public function getAllMenu(){
        $data=session('allmenu');
        if(!$data){
            $data = Db::name('right')->where(array('pid'=>0,'status'=>1))->order('sort asc')->select();
            foreach($data as $k=>$v){
                $child = Db::name('right')->where(array('pid'=>$v['id'],'status'=>1))->select();
                if($child){
                    $data[$k]['sub_menu'] = $child;
                }
            }
            session('allmenu',$data);
        }

        return $data;

    }

    

    /**
     * 定义方法
     *
     * 重写thinkphp跳转成功方法
     *
     * @param string $message
     * @param string $uri
     * @param bool|mixed $param
     */
    public function success_new($message,$uri="",$param = [])
    {
        if ($uri) {
            $param_str = '';
            if($param) {
                foreach ($param as $k => $v) {
                    $param_str .= '/' . $k . '/' . $v;
                }

                echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><script>alert(\'' . $message . '\');location=\'' . $uri . $param_str . '\'</script>';
            }else{
                echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><script>alert(\'' . $message . '\');location=\'' . $uri .  '\'</script>';
            }
        } else {
            echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><script>alert(\''.$message.'\');history.go(-1)</script>';
        }
        exit;
    }

    /**
     * 定义方法
     *
     * 重写thinkphp跳转失败方法
     *
     * @param string $message
     * @param string $uri
     * @param bool|mixed $param
     */
    public function error_new($message,$uri ="",$param = [])
    {
        if ($uri) {
            if($param) {
                $param_str = '';
                foreach ($param as $k => $v) {
                    $param_str .= '/' . $k . '/' . $v;
                }
                echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><script>alert(\'' . $message . '\');location=\'' . $uri . $param_str . '\'</script>';
            }else{
                echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><script>alert(\'' . $message . '\');location=\'' . $uri .  '\'</script>';
            }
        } else {
            echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><script>alert(\''.$message.'\');history.go(-1)</script>';
        }
        exit;
    }

    public function getNewMessage(){
        $ccRemind = Cache::get('ccRemind');
        if(!$ccRemind){
            $ccRemind['cash'] = 0;
            $ccRemind['charge'] = 0;
            Cache::set('ccRemind',$ccRemind);
        }
        return json($ccRemind);
    }

    /**
     * 通用删除
     */
    public function ajaxdel(Request $request){
        $id = $request->param('id');
        $table = $request->controller();
        $result = db($table)
            ->where(array('id'=>$id))
            ->delete();
        if ($result) {
            $this->success('删除成功',url('index'));
        }else{
            $this->error('删除失败');
        }
    }
}
