<?php
namespace app\admin\controller;
use app\admin\model\Cate as CateM;
use think\Request;

/**
 * 后台菜单管理
 */
class Cate extends Admin{
	/**
	 * 菜单列表
	 */
	public function index(){
		$AdminCate = new CateM();
		$data=$AdminCate->getTreeDatas('tree','sort,id');
		$parentdata=db("cate")->where('pid=0')->select();
		
		$assign=array(
			'data'=>$data,
			'parentdata'=>$parentdata
			);
		$this->assign($assign);
		return view();
	}

	/**
	 * 添加菜单
	 */
	public function add(Request $request){
		$data = $request->post();
		unset($data['id']);
		$AdminCate = new CateM();
		$result=$AdminCate->addData($data);
		if ($result) {
			$this->success_new('添加成功',url('index'));
		}else{
			$this->error_new('添加失败');
		}
	}

	/**
	 * 修改菜单
	 */
	public function edit(Request $request){
		$data = $request->post();
		$map=array(
			'id'=>$data['id']
			);
		$AdminCate = new CateM();
		$result=$AdminCate->editData($map,$data);
		if ($result) {
			$this->success_new('修改成功',url('index'));
		}else{
			$this->error_new('修改失败');
		}
	}

	/**
	 * 删除菜单
	 */
	public function delete(Request $request){
		$id = $request->param('id');
		$map=array(
			'id'=>$id
			);
		$AdminCate = new CateM();
		$result=$AdminCate->deleteDataa($map);
		if($result){
			$this->success_new('删除成功',url('index'));
		}else{
			$this->error_new('请先删除子菜单');
		}
	}

	/**
	 * 菜单排序
	 */
	public function order(Request $request){
		$data = $request->post();

		$AdminCate = new CateM();
		$result=$AdminCate->orderData($data);
		if ($result) {
			$this->success_new('排序成功',url('Admin/Nav/index'));
		}else{
			$this->error_new('排序失败');
		}
	}



}
