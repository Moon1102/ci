//
//  WriteVC.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/3/26.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class WriteViewController : UIViewController
{
    lazy var toolView = UINib(nibName: "ToolView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! ToolView
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(toolView)
    }
}