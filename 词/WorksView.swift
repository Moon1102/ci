//
//  WorksView.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/29.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class WorksView: UIView
{
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var backgroundV: UIImageView!

    var model:WritingModel!
    {
        //模型赋值
        didSet
        {
            const.format.dateFormat = "yyyy-MM-dd HH:mm"
            timeLabel.text = const.format.stringFromDate(NSDate(timeIntervalSince1970:model.create_dt as! NSTimeInterval))
            contentLabel.text = model.ci_name + "\n" + model.text
  
            let id = model.image_id as! Int
    
            if id != 0
            {
                backgroundV.image = UIImage(named: "\("0" + (id < 10 ? "0\(model.image_id)" : "\(model.image_id)"))")
            }
            else
            {
                backgroundV.backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    
    //点击方法
    @IBAction func click(sender: UIButton)
    {
        let vc = getCurrentVC()
        
        //添加UIAlertController
        let alert = UIAlertController(title: "", message: "", preferredStyle:.ActionSheet)
        
        //UIAlertController的方法
        alert.addAction(UIAlertAction(title: "编辑", style: .Default, handler: { (UIAlertAction) -> Void in
            let destiVC = UIStoryboard(name: "WritingViewController", bundle: nil).instantiateInitialViewController()! as! WritingViewController
            
            destiVC.dataModel = NameModel.objectWithKeyValues(SQLiteDB.sharedInstance().query("SELECT * FROM cipai WHERE  id = \(self.model.id) ").first!) as! NameModel
            destiVC.editModel = self.model
            
            vc.navigationController?.pushViewController(destiVC, animated: false)
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .Default, handler: { (UIAlertAction) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
   
        alert.addAction(UIAlertAction(title: "删除", style: .Destructive, handler: { (_) -> Void in
            
            let alert = UIAlertController(title: "确认删除？", message: "", preferredStyle:.Alert)
            alert.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: { (_) -> Void in
                
            }))
            alert.addAction(UIAlertAction(title: "确定", style: .Destructive, handler: { (_) -> Void in
                SQLiteDB.sharedInstance().query("DELETE FROM write WHERE  id = \(self.model.id) ")
                self.removeFromSuperview()
                let data = SQLiteDB.sharedInstance().query("SELECT * FROM write")
                (vc as! MainVC).scroll.contentOffset = CGPointMake(0, 0)
                (vc as! MainVC).scroll.contentSize = CGSizeMake(const.screenW * CGFloat(data.count + 1) - 50 , 0)
            }))
            vc.presentViewController(alert, animated: true, completion: nil)
        }))
    
        vc.presentViewController(alert, animated: true, completion: nil)
    }
}
