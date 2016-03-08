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
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var enter: UIButton!
    
    lazy var db = SQLiteDB.sharedInstance()
    
    var model:NameModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
  
        initData()
    }
    
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
    @IBAction func clickRandom(sender: UIButton)
    {
        note.text = ""
        initData()
    }

    @IBAction func clickEnter(sender: AnyObject)
    {
        let destiVC = UIStoryboard(name: "WriteViewController", bundle: nil).instantiateInitialViewController()! as! WriteViewController
        destiVC.dataModel = model
        navigationController?.pushViewController(destiVC, animated: false)
    }

    @IBAction func clickShare(sender: AnyObject)
    {
        
    }
}
