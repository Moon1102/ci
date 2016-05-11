//
//  ToolView.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/3/26.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class ToolView: UIView
{
    @IBOutlet weak var changeBtn: UIButton!
    
    var vc:UIViewController!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        vc = getCurrentVC()
        
        frame = CGRectMake(0,vc.view.frame.size.height - 44 ,vc.view.frame.size.width,44)
        
        changeBtn.setImage(UIImage(named: "layout_bg_paper"), forState: .Normal)
        changeBtn.setImage(UIImage(named: "layout_bg_paper_sel"), forState: .Selected)
    }
    
    //点击，隐藏
    @IBAction func clickCancel(sender: UIButton)
    {
        vc = getCurrentVC()
        
        if vc.classForCoder == ChooseBgViewController.classForCoder()
        {
            vc.dismissViewControllerAnimated(false, completion: nil)
        }

        hidden = true
    }
    //改变背景
    @IBAction func clickBG(sender: UIButton)
    {
        vc = getCurrentVC()
        
        let destiVC = UIStoryboard(name: "ChooseBgViewController", bundle: nil).instantiateInitialViewController()! as! ChooseBgViewController
        vc.navigationController?.presentViewController(destiVC, animated: false, completion: { [weak self]() -> Void in
            destiVC.contentLabel.text = (self!.vc as! WritingViewController).titleLabel.text! + "\n" +
            self!.ContentText((self!.vc as! WritingViewController).dataArr)
            destiVC.model = (self!.vc as! WritingViewController).dataModel
        })
    }
    //保存按钮
    @IBAction func clickSave(sender: UIButton)
    {
        vc = getCurrentVC()
        
        if vc.classForCoder == WritingViewController.classForCoder()
        {
            let controller = vc as! WritingViewController
            let temp = ContentText(controller.dataArr)
    
            SQLiteDB.sharedInstance().execute("INSERT OR REPLACE INTO write VALUES('\(controller.dataModel.id)','\(temp)','\(controller.dataModel.name)','\(NSDate().timeIntervalSince1970)',NULL)")
              vc.navigationController?.popToRootViewControllerAnimated(true)
        }
        else
        {
            let controller = vc as! ChooseBgViewController
            let temp = controller.contentLabel.text?.subStringFrom((controller.contentLabel.text?.positionOf("\n"))! + 1)

            SQLiteDB.sharedInstance().execute("INSERT OR REPLACE INTO write VALUES('\(controller.model.id)','\(temp!)','\(controller.model.name)','\(NSDate().timeIntervalSince1970)','\(controller.imageName    )')")
            vc.dismissViewControllerAnimated(false, completion: {() -> Void in
            (UIApplication.sharedApplication().keyWindow?.rootViewController as! NavgationController).popToRootViewControllerAnimated(false)
            })
        }
    }
    
    func ContentText(var dataArr:Dictionary<Int, String>)->String
    {
        var temp = ""
        
        for i in 0..<dataArr.count
        {
            if dataArr[i] == nil
            {
                dataArr[i] = "\n"
            }
            temp += dataArr[i]! + "\n"
        }
        
        return temp
    }
}