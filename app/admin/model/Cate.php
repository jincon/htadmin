<?php
/**
 * 菜单
 *
 * 右侧菜单管理
 * @author      LouisLivi<574747417@qq.com>
 * @version     1.0
 * @since       1.0
 */
namespace app\admin\model;



/**
 * 菜单操作model
 */
class Cate extends Base{

	protected $table = 'dl_cate';

	/**
	 * 删除数据
	 * @param	array	$map	where语句数组形式
	 * @return	boolean			操作是否成功
	 */
	public function deleteDataa($map){
		$count=$this
			->where(array('pid'=>$map['id']))
			->count();

		if($count!=0){
			return false;
		}

		$this->where($map)->delete();
		return true;
	}

	public function getParentCate(){
		$data=$this->where('pid=0')->select();
		return $data;
	}

	/**
	 * 获取全部菜单
	 * @param  string $type tree获取树形结构 level获取层级结构
	 * @return array       	结构数据
	 */
	public function getTreeDatas($type='tree',$order=''){
		// 判断是否需要排序
		if(empty($order)){
			$data=$this->select();

		}else{
			$data=$this->order('sort is null,'.$order)->select();

		}
		// 获取树形或者结构数据
		if($type=='tree'){
			$data=\Nx\Data::tree($data,'name','id','pid');
		}elseif($type="level"){
			$data=\Nx\Data::channelLevel($data,0,'&nbsp;','id');
			
		}

		return $data;

	}


}
