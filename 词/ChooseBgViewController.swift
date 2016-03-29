//
//  ChooseBgViewController.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/3/26.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class ChooseBgViewController: WriteViewController
{
    @IBOutlet weak var contentView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    lazy var scroll = UIScrollView(frame: CGRectMake(0,const.screenH - 170,const.screenW,100))
    lazy var imageName = ""
    
    var model:NameModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        toolView.changeBtn.selected = true
        
        scroll.showsHorizontalScrollIndicator = false
        scroll.bounces = false
        scroll.contentSize = CGSizeMake(11 * 200, 0)
        
        for i in 1..<12
        {
            let backgroundV = UIButton()
            backgroundV.frame = CGRectMake(200 * CGFloat(i - 1),0,200,100)
            backgroundV.setImage(UIImage(named: "0" + (i < 10 ? "0\(i)" : "\(i)")), forState: .Normal)
            backgroundV.addTarget(self, action: Selector("click:"), forControlEvents: .TouchUpInside)
            backgroundV.tag = i
            scroll.addSubview(backgroundV)
        }

        view.addSubview(scroll)
    }
    
    func click(sender:UIButton)
    {
        imageName = "0" + (sender.tag < 10 ? "0\(sender.tag)" : "\(sender.tag)")
        contentView.image = UIImage(named: imageName)
    }
}
