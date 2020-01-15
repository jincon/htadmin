<?php
namespace app\admin\controller;
use think\Request;
use app\admin\model\Article as Articles;
use app\admin\model\Cate as CateM;

use think\Db;

/**
 * 文章控制器
 */
class Article extends Admin{

    /**
     * 首页
     */
    public function index(Request $request){
        $title = $request->param('title');
        $cid = $request->param('cid');
        $from   = $request->param('from');
        $to     = $request->param('to');
        $w=[];
        if($from && $to){
            $from = strtotime($from);
            $to = strtotime($to)+3600*24;
            $w['dateline'] = [['>=',$from],['<=',$to]];
        }
        if($title){
            $w['title']= ['like',"%".$title."%"];
        }
        if($cid){
            $w['cid']= $cid;
        }

        $list = Articles::where($w)->order('id desc')->paginate(20,false,['query'=>request()->param()]);
        $data = $list->all();
        foreach($data as $k=>$v){
            $data[$k]['cate'] = db('cate')->where(['id'=>$v['cid']])->value('name');
        }
        $AdminCate = new CateM();
        $cate=$AdminCate->getTreeDatas('tree','sort,id');

        return view('index',[
            'list'=>$data,
            'page'=>$list->render(),
            'cate'=>$cate,
        ]);

    }

    /**
     * 编辑房间
     */
    public function show(Request $request){

        $id = $request->param('id');
        $data = Db::name('article')
            ->where(array('id'=>$id))
            ->find();
        $AdminCate = new CateM();
        $cate=$AdminCate->getTreeDatas('tree','sort,id');

        return view('edit',[
            'data'=>$data,
            'cate'=>$cate,
        ]);
    }

    /**
     * 编辑房间
     */
    public function edit(Request $request){
        if($request->isPost()){
            $data = $request->post();
            $map=array(
                'id'=>$data['id']
            );
            if(!$data['title']){
                $this->success_new('请添加内容哦',url('index'));
            }
            if(!$data['cid']){
                $this->success_new('请选择栏目哦',url('index'));
            }

            $data['dateline'] = date("Y-m-d H:i:s");
            $result=Db::name('article')->where($map)->update($data);

            /*
             // 启动事务
                Db::startTrans();
                try{
                    Db::table('think_user')->find(1);
                    Db::table('think_user')->delete(1);
                    // 提交事务
                    Db::commit();
                } catch (\Exception $e) {
                    // 回滚事务
                    Db::rollback();
                }
            */
            if ($result!==false) {
                $this->success_new('修改成功',url('index'));
            }else{
                $this->error_new('修改失败');
            }
        }
    }

    public function add(Request $request){
        if($request->isPost()){
            $data = $request->post();
            if(!$data['title']){
                $this->success_new('请添加内容哦',url('index'));
            }
            if(!$data['cid']){
                $this->success_new('请选择栏目哦',url('index'));
            }
            $data['dateline'] = date("Y-m-d H:i:s");
            $result=Db::name('article')->insert($data);
            $rid = Db::name('article')->getLastInsID();

            if ($result) {
                $this->success_new('添加成功',url('index'));
            }else{
                $this->error_new('添加失败');
            }
            exit;
        }
        //$department = db('cate')->select();
        $AdminCate = new CateM();
        $cate=$AdminCate->getTreeDatas('tree','sort,id');

        return view('',[
            'cate'=>$cate
        ]);
    }
}