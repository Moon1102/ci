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

    var model:WritingModel!
    {
        didSet
        {
            const.format.dateFormat = "yyyy-MM-dd HH:mm"
            timeLabel.text = const.format.stringFromDate(NSDate(timeIntervalSince1970:model.create_dt as! NSTimeInterval))
            contentLabel.text = model.ci_name + "\n" + model.text
        }
    }
    @IBAction func click(sender: UIButton)
    {
        let vc = getCurrentVC()
        let alert = UIAlertController(title: "", message: "", preferredStyle:.ActionSheet)
        alert.addAction(UIAlertAction(title: "编辑", style: .Default, handler: { (UIAlertAction) -> Void in
            let destiVC = UIStoryboard(name: "WriteViewController", bundle: nil).instantiateInitialViewController()! as! WriteViewController
            
            destiVC.dataModel = NameModel.objectWithKeyValues(SQLiteDB.sharedInstance().query("SELECT * FROM cipai WHERE  id = \(self.model.id) ").first!) as! NameModel
            destiVC.editModel = self.model
            
            vc.navigationController?.pushViewController(destiVC, animated: false)
        }))
        alert.addAction(UIAlertAction(title: "删除", style: .Destructive, handler: { (_) -> Void in
            
            let alert = UIAlertController(title: "确认删除？", message: "", preferredStyle:.Alert)
            alert.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: { (_) -> Void in
                
            }))
            alert.addAction(UIAlertAction(title: "确定", style: .Destructive, handler: { (_) -> Void in
                SQLiteDB.sharedInstance().query("DELETE FROM writing WHERE  id = \(self.model.id) ")
                self.removeFromSuperview()
                let data = SQLiteDB.sharedInstance().query("SELECT * FROM writing")
                (vc as! MainVC).scroll.contentOffset = CGPointMake(0, 0)
                (vc as! MainVC).scroll.contentSize = CGSizeMake(const.screenW * CGFloat(data.count + 1) - 50 , 0)
            }))
            vc.presentViewController(alert, animated: true, completion: nil)
        }))
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    func getCurrentVC()->UIViewController
    {
        for (var next = self.superview;next != nil; next = next?.superview)
        {
            let nextRes:UIResponder = (next?.nextResponder())!
            if nextRes.isKindOfClass(UIViewController.classForCoder())
            {
                return nextRes as! UIViewController
            }
        }
        return UIViewController()
    }

}
