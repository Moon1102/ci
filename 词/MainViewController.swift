//
//  MainViewController.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/24.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class MainVC:UIViewController
{
    lazy var scroll = UIScrollView(frame: CGRectMake(0,0,const.screenW - 40,const.screenW - 40))
    lazy var buttonView = UIView(frame: CGRectMake(30,30,const.screenW - 100,const.screenW - 100))
    lazy var listBtn = UIButton(frame: CGRectMake(20,40,const.screenW - 140,50))
    lazy var randomBtn = UIButton(frame: CGRectMake(20,130,const.screenW - 140,50))
    lazy var tempCount = 0
    
    var workView:WorksView!

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //查询数据库，获得数据
        let data = SQLiteDB.sharedInstance().query("SELECT * FROM writing")
        
        for sub in scroll.subviews
        {
            if sub.isKindOfClass(WorksView.classForCoder())
            {
                tempCount++
            }
        }
        
        scroll.contentSize = CGSizeMake(const.screenW * CGFloat(data.count + 1) - 50 , 0)
        
        //有新数据就添加对应的View
        if tempCount < data.count
        {
                workView = UINib(nibName: "WorksView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! WorksView
                workView.model = WritingModel.objectWithKeyValues(data[data.count - 1]) as! WritingModel
                workView.frame = CGRectMake(30 + (const.screenW) * CGFloat(data.count),30,const.screenW - 100,const.screenW - 100)
                scroll.addSubview(workView)
        }
    }
    //清掉tempCount
    override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        tempCount = 0
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUp()
    }
    
    //初始化
    func setUp()
    {
        let data = SQLiteDB.sharedInstance().query("SELECT * FROM writing")
        scroll.center = view.center
        scroll.contentSize = CGSizeMake(const.screenW * CGFloat(data.count + 1) - 50 , 0)
        scroll.showsHorizontalScrollIndicator = false
        
        listBtn.setBackgroundImage(UIImage(named: "browseall"), forState: .Normal)
        listBtn.addTarget(self, action: Selector("listAll"), forControlEvents: .TouchUpInside)
        
        randomBtn.setTitle("随机一首词", forState: .Normal)
        randomBtn.titleLabel?.font = UIFont(name: "FZQingKeBenYueSongS-R-GB", size: 20)
        randomBtn.addTarget(self, action: Selector("randomOne"), forControlEvents: .TouchUpInside)
        
        buttonView.addSubview(listBtn)
        buttonView.addSubview(randomBtn)
        
        scroll.addSubview(buttonView)
        view.addSubview(scroll)
        
        guard data.count < 1  else
        {
            for i in 0..<data.count
            {
                workView = UINib(nibName: "WorksView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! WorksView
                workView.model = WritingModel.objectWithKeyValues(data[i]) as! WritingModel
                workView.frame = CGRectMake(30 + (const.screenW) * CGFloat(i+1),30,const.screenW - 100,const.screenW - 100)
                scroll.addSubview(workView)
            }
            return
        }
    }
    //跳转显示所有词牌
    func listAll()
    {
        navigationController?.pushViewController(UIStoryboard(name: "ListAllViewController", bundle: nil).instantiateInitialViewController()!, animated: false)
        
    }
    //跳转随机一首词
    func randomOne()
    {
       navigationController?.pushViewController(UIStoryboard(name: "RandomViewController", bundle: nil).instantiateInitialViewController()!, animated: false)
    }
    //添加
    @IBAction func add(sender: UIButton)
    {
        
    }
    //设置
    @IBAction func setting(sender: UIButton)
    {
        
    }
}

