//
//  IntroViewController.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/3/7.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController
{
    //本地调用html
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let web = UIWebView(frame: CGRectMake(0,0,view.frame.size.width,view.frame.size.height))
        let path = NSBundle.mainBundle().pathForResource("intro", ofType: "html")!
        let str = try! NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
        web.loadHTMLString(str as String, baseURL: NSURL(string: path))
        view.addSubview(web)
        
    }
}