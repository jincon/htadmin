<?php
/**
 * Created by PhpStorm.
 * User: tangmusen
 * Date: 2017/9/4
 * Time: 9:36
 */

namespace app\admin\controller;

use app\admin\model\Odds;
use think\Cache;
use think\Request;
use think\Db;

class Advertise extends Admin
{
    /**
     * 广告首页
     */
    public function index(Request $request){
        $type = $request->param('type');
        $w = [];
        if($type){
            $w['type'] = $type;
        }
        $title = $request->param('title');
        if($title){
            $w['title'] = $title;
        }
        $data = Db::name('advertise')
            ->where($w)
            ->order('id desc')
            ->select();
        return view('',[
            'data'=>$data
        ]);
    }

    /**
     * 编辑广告
     */
    public function show(Request $request){
        $id = $request->param('id');
        $data = Db::name('advertise')
            ->where(array('id'=>$id))
            ->find();
        return view('edit',[
            'data'=>$data
        ]);
    }

    /**
     * 编辑广告
     */
    public function edit(Request $request){
        if($request->isPost()){
            $data = $request->post();
            $map=array(
                'id'=>$data['id']
            );
            $result=Db::name('advertise')->where($map)->update($data);
            if ($result) {
                $this->success_new('修改成功',url('index'));
            }else{
                $this->error_new('修改失败');
            }
        }
    }

    /**
     * 删除广告
     */
    public function del(Request $request){
        $id = $request->param('id');
        $result = Db::name('advertise')
            ->where(array('id'=>$id))
            ->delete();
        if ($result) {
            $this->success_new('删除成功',url('index'));
        }else{
            $this->error_new('删除失败');
        }
    }

    /**
     * 添加广告
     */
    public function add(Request $request){
        if($request->isPost()){
            $data = $request->post();
            //return json($data);
            $result=Db::name('advertise')->insert($data);
            if ($result) {
                $this->success_new('添加成功',url('index'));
            }else{
                $this->error_new('添加失败');
            }
        }
    }

}