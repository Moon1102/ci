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
    
    lazy var scroll = UIScrollView(frame: CGRectMake(0,0,const.screenW,const.screenW - 40))
    lazy var scrollV = UIScrollView(frame: CGRectMake(0,0,const.screenW,const.screenW - 40))
    
    lazy var nameArray:Array<NameView> = []
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

        for model in data
        {
            nameView = UINib(nibName: "NameView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NameView
            nameView.frame = CGRectMake(0 + (model["id"] as! CGFloat - 1) * 90, scroll.frame.size.height / 2 - 65, 80, 170)
            nameView.model = NameModel.objectWithKeyValues(model) as! NameModel
            nameArray.append(nameView)
            scroll.addSubview(nameView)
        }
        
        scroll.center = view.center
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentSize = CGSizeMake(CGFloat(data.count) * 90, 0)
        view.addSubview(scroll)
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
        
        if scrollV.subviews.count == 0
        {
            let sorted = nameArray.sort({ ($0.model.wordcount as! Int ) < ($1.model.wordcount as! Int)})
            var i:CGFloat = 0
            
            for v in sorted
            {
                nameView = UINib(nibName: "NameView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NameView
                nameView.frame = CGRectMake(0 + i * 90, scroll.frame.size.height / 2 - 65, 80, 170)
                nameView.model = v.model
                scrollV.addSubview(nameView)
                i++
            }
            scrollV.center = view.center
            scrollV.showsHorizontalScrollIndicator = false
            scrollV.contentSize = CGSizeMake(CGFloat(sorted.count) * 90, 0)
        }

        view.addSubview(scrollV)
            
        default:break
        }
    }
}