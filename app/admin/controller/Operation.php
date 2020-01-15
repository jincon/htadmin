<?php
namespace app\admin\controller;
use think\Cache;
use think\Db;
use think\Request;

/**
 * 操作记录类
 *
 * Class OperationController
 * @package Admin\Controller
 */
class Operation extends Admin {
    /**
     * 显示操作记录
     */
    public function showlist(Request $request)
    {
        $begin_time = $request->get('from');
        $end_time   = $request->get('to');

        $operation_obj = new \Net\Operation();
        $where = [];
        if ($begin_time || $end_time){
            if ($begin_time){
                $where['operation_time'] = array('>',$begin_time);

                $this ->assign('begin_time',$begin_time);
            }
            if ($end_time){
                $where['operation_time'] = array('<',$end_time);
                $this ->assign('end_time',$end_time);
            }
        }

        $log_list = Db::name('operation_log')
            ->alias('o')
            ->field('o.*,u.username')
            ->join('dl_user u','u.id = o.operation_uid')
            ->order('o.id desc')
            ->paginate(30);

        $list = $log_list->all();
        foreach ( $list as $k=>$v){
            $cz = strtolower('admin/'.	$v['operation_node']);
            $do_name =  Db::name('auth_rule')
                ->where('name',$cz)
                ->value('title');
            if(!$do_name){
                $do_name = '未可知';
            }
            $v['do_name'] = $do_name;
            $log_list[$k] = $v;
        }
        return view('showlist',[
            'log_list'=>$log_list,
            'page'=>$log_list->render(),
        ]);

    }

    /**
     * 定义方法
     *
     * 删除时间段操作记录
     *
     * @param $d_begin_time string 开始时间
     * @param $d_end_time string 结束时间
     */
    public function del($d_begin_time,$d_end_time)
    {
        if (!$d_begin_time) {
            echo '<script>alert(\'请输入删除开始时间!\');history.back()</script>';
            return false;
        } elseif(!$d_end_time) {
            echo '<script>alert(\'请输入删除结束时间!\');history.back()</script>';
            return false;
        }
        $where['time'] = array('egt',strtotime($d_begin_time,' 00:00:00'));
        $where['time'] = array('elt',strtotime($d_end_time.' 23:59:59'));
        $result = M('operation_log') ->where($where) ->delete();
        if ($result) {
            echo '<script>alert(\'删除记录成功!\');history.back()</script>';
        } else {
            echo '<script>alert(\'删除记录失败!\');history.back()</script>';
        }
    }

    /**
     * 软件参数设置
     */
    public function index(Request $request){
        $_config = db("setting")->select();
        foreach($_config as $v){
            $config[$v['key']] = $v['value'];
        }
        return view('',["config"=>$config]);
    }

    /**
     * 修改系统参数
     */
    public function edit(Request $request){
        if($request->isPost()){
            $data = $request->post();
            foreach($data['config'] as $key=>$val){
                $_data['value'] = $val;
                if(Db::name('setting')->where(array("key"=>$key))->find()){
                    $result=Db::name('setting')->where(array("key"=>$key))->update($_data);
                }else{
                    $_data['key'] = $key;
                    $result=Db::name('setting')->insert($_data);
                }
            }
            if ($result) {
                $this->success_new('修改成功',url('Admin/operation/index'));
            }else{
                $this->error_new('修改失败');
            }
        }
    }

    /**
     * 根据IP获取地址
     */
    public function get_addr(Request $request){
        $ip = $request->param('ip');
        $addr = get_city_id($ip);
        Cache::store('redis')->set($ip,$addr);
        $data['operation_addr'] = $addr;
        $result = Db::name('operation_log')
            ->where(array('operation_ip'=>$ip,'operation_addr'=>0))
            ->update($data);
        if ($result) {
            $this->success_new('获取成功',url('Admin/operation/showlist'));
        }else{
            $this->error_new('获取失败');
        }
    }

    /**
     * 删除数据
     */
    public function sc_show(){
        return view('do_delete',[

        ]);
    }

    /**
     * 删除数据
     */
    public function do_delete(Request $request){
        $id  = $request->post('id');
        $day = $request->post('day');

        if($id==3){
            $del_day = "-".$day." day";
            $del_time = date("Y-m-d",strtotime($del_day));
            $table_name = "operation_log";
            Db::name($table_name)->whereTime('operation_time','<',$del_time)->delete();

        }
        if(in_array($id,[1,2,5,6,7,8])) {
            $del_day = "-".$day." day";
            $del_time =strtotime($del_day);

            if ($id == 2) {
                $table_name = "login_log";
            }
            if ($id == 5) {
                $table_name = "recharge";
            }
            if ($id == 6) {
                $table_name = "withdrawals";
            }
            if ($id == 8) {
                $table_name = "detail";
            }
            Db::name($table_name)->where('create_at', '<', $del_time)->delete();
        }
        json_return(200,'清理成功');
    }


 

    public function upload_one(){
        if($this->request->isPost()){
            //接收参数
            $images = $this->request->file('file');

            //计算md5和sha1散列值，TODO::作用避免文件重复上传
            $md5 = $images->hash('md5');
            $sha1= $images->hash('sha1');

            //判断图片文件是否已经上传
            $img = Db::name('qrcode')->where(['md5'=>$md5,'sha1'=>$sha1])->find();//我这里是将图片存入数据库，防止重复上传
            if(!empty($img)){
                return json(['status'=>1,'msg'=>'上传成功','data'=>['picd'=>$img['id'],'pic'=>$this->request->root(true).'/'.$img['path']]]);
            }else{
                // 移动到框架应用根目录/public/uploads/picture/目录下
                $imgPath = 'public' . DS . 'uploads' . DS . 'picture';
                $info = $images->move(ROOT_PATH . $imgPath);
                $path = 'uploads/picture/'.date('Ymd',time()).'/'.$info->getFilename();
                return json(['status'=>1,'msg'=>'上传成功','data'=>['picd'=>1,'pic'=>$this->request->root(true).'/'.$path]]);

            }
        }else{
            return ['status'=>0,'msg'=>'非法请求!'];
        }
    }
    
}