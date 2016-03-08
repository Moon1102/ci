//
//  NavgationController.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/28.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class NavgationController:UINavigationController
{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationBar.shadowImage = UIImage()
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool)
    {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back2")?.imageWithRenderingMode(.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("popViewControllerAnimated:"))
        viewController.navigationItem.leftBarButtonItem?.title = ""
        
        super.pushViewController(viewController, animated: animated)
    }
}