//
//  ListAllViewController.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/24.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class ListAllViewController:UIViewController
{
    @IBOutlet weak var segment: UISegmentedControl!
    
    lazy var scroll = UIScrollView()
    lazy var scrollV = UIScrollView()

    lazy var modelArray = NSMutableArray()
    lazy var db = SQLiteDB.sharedInstance()
    
    var nameView:NameView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initData()
    }
    
    //初始化数据
    func initData()
    {
        let data = db.query("SELECT * FROM cipai")
        
        scroll = creatScrollView(data.count)
        scrollV = creatScrollView(data.count)
        
        for index in 0..<data.count
        {
            nameView = UINib(nibName: "NameView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NameView
            nameView.frame = CGRectMake(CGFloat(index) * 90, scroll.frame.size.height / 2 - 65, 80, 170)
            nameView.model = NameModel.objectWithKeyValues(data[index]) as! NameModel
            modelArray.addObject(nameView.model)
            scroll.addSubview(nameView)
        }

        modelArray.sortUsingDescriptors([NSSortDescriptor(key: "wordcount", ascending: true)])

        for index in 0..<modelArray.count
        {
            nameView = UINib(nibName: "NameView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NameView
            nameView.frame = CGRectMake(CGFloat(index) * 90, scroll.frame.size.height / 2 - 65, 80, 170)
            nameView.model = modelArray[index] as! NameModel
            scrollV.addSubview(nameView)
        }
        
        view.addSubview(scroll)
    }
    
    func creatScrollView(count:Int) -> UIScrollView
    {
        let scrollView = UIScrollView(frame: CGRectMake(0,0,const.screenW,const.screenW - 40))
        scrollView.center = view.center
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSizeMake(CGFloat(count) * 90, 0)
        
        return scrollView
    }
    
    //切换排列方式
    @IBAction func change(sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            
        scrollV.removeFromSuperview()
        
        view.addSubview(scroll)
            
        case 1:
        
        scroll.removeFromSuperview()
        
        view.addSubview(scrollV)
            
        default:break
        }
    }
}