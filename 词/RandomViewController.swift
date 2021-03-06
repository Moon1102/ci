//
//  RandomViewController.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/27.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class RandomViewController:UIViewController
{
    @IBOutlet weak var content: UITextView!//内容View
    @IBOutlet weak var note: UITextView!//注解View
    @IBOutlet weak var nameLabel: UILabel!//词牌名Label
    @IBOutlet weak var enter: UIButton!//进入按钮
    
    lazy var db = SQLiteDB.sharedInstance()
    
    var model:NameModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
  
        initData()
    }
    
    //初始化数据
    func initData()
    {
        let random = (arc4random() % 97) + 1
        
        let data = db.query("SELECT * FROM example WHERE ci_id = \(random) ")
        model = NameModel.objectWithKeyValues(db.query("SELECT * FROM cipai WHERE  id = \(random) ").first!) as! NameModel
        nameLabel.text = model.name
        content.text = "\(data.first!["author"]!)" + "\n\n" + "\(data.first!["text"]!)"
        
        if let _ = data.first!["note"]
        {
            note.text = data.first!["note"]! as! String
        }
        
        enter.layer.cornerRadius = enter.frame.size.width * 0.5
        
        if 0 == db.query("SELECT * FROM cipai WHERE  id = \(random) ").first!["parent_id"]! as! NSObject
        {
            let rgbData = db.query("SELECT * FROM color WHERE id = \(db.query("SELECT * FROM cipai WHERE  id = \(random) ").first!["color_id"]!) ")
            enter.backgroundColor = UIColor(red: CGFloat(rgbData.first!["red"]! as! NSNumber)/255, green: CGFloat(rgbData.first!["green"]! as! NSNumber)/255, blue: CGFloat(rgbData.first!["blue"]! as! NSNumber)/255, alpha: 1)
        }
    }
    //随机一首词
    @IBAction func clickRandom(sender: UIButton)
    {
        note.text = ""
        initData()
    }
    //进入填词
    @IBAction func clickEnter(sender: AnyObject)
    {
        let destiVC = UIStoryboard(name: "WritingViewController", bundle: nil).instantiateInitialViewController()! as! WritingViewController
        destiVC.dataModel = model
        navigationController?.pushViewController(destiVC, animated: false)
    }
    //分享
    @IBAction func clickShare(sender: AnyObject)
    {
        
    }
}
