//
//  NameModel.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/24.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class NameView: UIView
{
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var circleLabel: UILabel!
    
    lazy var EnNameLabel = UILabel(frame: CGRectZero)
    lazy var db = SQLiteDB.sharedInstance()
 
    var model:NameModel!
    {
        didSet
        {
            EnNameLabel.text = model.enname
            NameLabel.text = model.name
            countLabel.text = (model.wordcount as! Int) < 100 ? "0\(model.wordcount)" :  "\(model.wordcount)"

            NameLabel.textColor = model.getColor(SQLiteDB.sharedInstance())
            EnNameLabel.textColor = model.getColor(SQLiteDB.sharedInstance())
            countLabel.textColor = model.getColor(SQLiteDB.sharedInstance())
            circleLabel.textColor = model.getColor(SQLiteDB.sharedInstance())
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clearColor()
        
        EnNameLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI) * 0.5)
        EnNameLabel.frame = CGRectMake(5,48, 30, 240)
        EnNameLabel.font = UIFont(name: "FZQingKeBenYueSongS-R-GB", size: 15)
        addSubview(EnNameLabel)
    }
    
    
    @IBAction func clickView(sender: UIButton)
    {
        let destiVC = UIStoryboard(name: "ListOneViewController", bundle: nil).instantiateInitialViewController()! as! ListOneViewController
        destiVC.model = model
        (getCurrentVC() as! ListAllViewController).navigationController?.pushViewController(destiVC, animated: false)
        
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

