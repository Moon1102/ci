//
//  ListOneViewController.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/27.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class ListOneViewController:UIViewController
{
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    var model:NameModel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
 
        midView.layer.cornerRadius = midView.frame.size.width * 0.5
        midView.backgroundColor = model.getColor(SQLiteDB.sharedInstance())
        NameLabel.text = model.name
        content.text = model.source
        countLabel.text = (model.wordcount as! Int) < 100 ? "0\(model.wordcount)" :  "\(model.wordcount)"
    }
    @IBAction func clickEnter(sender: UIButton)
    {
        let destiVC = UIStoryboard(name: "WriteViewController", bundle: nil).instantiateInitialViewController()! as! WriteViewController
        destiVC.dataModel = model
        navigationController?.pushViewController(destiVC, animated: false)
    }
}

