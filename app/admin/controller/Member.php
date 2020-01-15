<?php
/**
 * Created by PhpStorm.
 * User: tangmusen
 * Date: 2017/9/1
 * Time: 10:04
 */

namespace app\admin\controller;
use app\admin\model\AuthGroupAccess;
use app\admin\model\Cash;
use app\admin\model\Members;
use app\admin\model\Recharge;
use app\admin\model\User;
use think\Db;
use think\Request;


class Member extends Admin
{
    /**
     * 会员信息首页
     */
    public function index(Request $request){

        $username = $request->param('username');
        $from   = $request->param('from');
        $to     = $request->param('to');
        $w=[];
        if($from && $to){
            $from = strtotime($from);
            $to = strtotime($to)+3600*24;
            $w['create_at'] = [['>=',$from],['<=',$to]];
        }
        if($username){
            $w['username']=$username;
        }

        $info=session('info');
        
        $list = Members::where($w)->order('id desc')->paginate(20,false,['query'=>request()->param()]);
        $data = $list->all();
        foreach ( $data as $k=>$v){
            $v['tid_name'] = '无';
            $list[$k] = $v;
        }
        return view('index',[
            'list'=>$list,
            'page'=>$list->render(),
            'info'=>session('info'),
        ]);
    }

    /**
     * 查看会员信息
     */
    public function show_list(Request $request){
        
        $id = $request->param('id');
        $info  = Members::get($id);
        if(!$info){
            $this->error_new('你要查看的用户不存在');
            die;
        }
        return view('edit',[
            'member_info'=>$info,
            //'hand'=>$hand,

        ]);
    }
    
    /**
     * 修改会员信息
     */
    public function edit(Request $request){

       if($request->isPost()){
            $data = $request->post();
            $userInfo=Db::name('member')->where(['id'=>(int)$data['id']])->find();
            if(!$userInfo){
                $this->error_new('你要操作的用户不存在');
                exit;
            }
            $userUpdate=[];
            $validate = validate('User');
            if(!empty($data['repassword'])){
                $checkData['password'] = trim($data['repassword']);
                if(!$validate->scene('resetPass')->check($checkData)){
                    $this->error_new($validate->getError());
                };
                $userUpdate['password'] = md5($data['repassword']);
            }
            Db::startTrans();
            try{
                //修改用户信息
                if($userUpdate){
                    $updatestatus=Db::name('member')->where(['id'=>$userInfo['id']])->update($userUpdate);
                    if($updatestatus===false){
                        $this->error_new('操作失败请重试');
                    }
                }

                Db::commit();
                $this->success_new('操作成功');
                exit;
            }catch (\Exception $exception){
                Db::rollback();
                $this->error_new($exception->getMessage());
            }
           $this->error_new('操作失败');


        }
    }

    
    /**
     * 冻结用户
     */
    public function edit_frozen(Request $request){
        $id = $request->post('id');
        $data['status'] =1;
        $result = Db::name('member')->where(array('id'=>$id))->update($data);

        add_member_msg($id,'您的账号已被冻结，有任何疑意，请联系客服!');
        if($result){
            json_return(200,'成功');
        }else{
            json_return(500,'失败');
        }

    }
    /**
     * 解冻用户
     */
    public function edit_unfreeze(Request $request){
        $id = $request->post('id');
        $data['m_status'] =0;
        $result = Db::name('member')->where(array('id'=>$id))->update($data);

        add_member_msg($id,'恭喜您,您的账号已解冻!');
        if($result){
            json_return(200,'成功');
        }else{
            json_return(500,'失败');
        }

    }

    /**
     * 删除用户
     */
    public function del(Request $request){
        $id          = $request->param('id');
        $username     =  $request->param('username');
       if($username){
           $result = Db::name('member')->where(array('id'=>$id))->delete();

           if ($result) {
               $this->success_new('删除成功',url('Admin/member/index_agent'));
           }else{
               $this->error_new('删除失败');
           }
       }else{
           $result  = Db::name('member')->where(array('id'=>$id))->delete();
           if ($result) {
               $this->success_new('删除成功',url('Admin/member/index'));
           }else{
               $this->error_new('删除失败');
           }
       }

    }

    /**
     * 添加会员
     */
    public function add(Request $request){

        if($request->isPost()) {
            $data = $request->post();
            if (empty($data['username'])) {
                $this->error('账号不能为空');
            }
            if (empty($data['password'])) {
                $this->error('密码不能为空');
            }
            $Member = new Members();
            $whereData['username'] = $data['username'];
            $a = $Member->where($whereData)->find();
            if (!empty($a)) {
                $this->error('已存在用户');
            };
            $data['ip'] = get_client_ip();
            //如果是代理添加用户该用户为代理下用户

            $validate = validate('User');

            $data['password']       = md5($data['password']);
            $data['create_at']      = time();
            $uid =Db::name('member')->insertGetId($data);
            if ($uid) {
                $this->success('添加成功', url('Admin/member/index'));
            } else {
                $this->error('添加失败');
            }
        }
        //$list =Db('hand')->select();
        return view('',[

        ]);
    }

    

    

}