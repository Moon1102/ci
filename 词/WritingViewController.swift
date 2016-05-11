//
//  WriteViewController.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/27.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class WritingViewController : WriteViewController,UITableViewDataSource,UITableViewDelegate
{
    lazy var dataArr = Dictionary<Int, String>()
    
    var dataModel:NameModel!
    var editModel:WritingModel!
    
    lazy var isPing = false
    lazy var cellArr:Array<PingZeCell> = []

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var toolBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        titleLabel.text = dataModel.name
        
        for _ in 0..<getString(dataModel.pingze).count
        {
            let cell =  UINib(nibName: "PingZeCell", bundle: nil).instantiateWithOwner(nil, options: nil).first as! PingZeCell
            cellArr.append(cell)
        }
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        toolView.hidden = true
    }
    //MARK:数据源方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return getString(dataModel.pingze).count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        cellArr[indexPath.row].contentLabel.attributedText = getString(dataModel.pingze)[indexPath.row]
        cellArr[indexPath.row].input.tag = indexPath.row
        cellArr[indexPath.row].isPing = isPing
        
        if editModel != nil && editModel.text != ""
        {
            let arr = editModel.text.componentsSeparatedByString("\n")

            if indexPath.row <= arr.count - 1
            {
                cellArr[indexPath.row].input.text = arr[indexPath.row]
            }
        }
        return cellArr[indexPath.row]
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 88
    }
    
    //点击，显示
    @IBAction func clickTab(sender: UIButton)
    {
        toolView.hidden = false
    }
    //搜索韵脚按钮
    @IBAction func search(sender: UIButton)
    {
        let destiVC = UIStoryboard(name: "PingZeSearchViewController", bundle: nil).instantiateInitialViewController()! as! PingZeSearchViewControlller
        navigationController?.pushViewController(destiVC, animated: false)
    }
    //介绍按钮
    @IBAction func intro(sender: UIButton)
    {
        navigationController?.pushViewController(IntroViewController(), animated: false)
    }
    //遍历字符串，做对应文字的映射
    func getString(str:String)->Array<NSMutableAttributedString>
    {
        var array:Array<NSMutableAttributedString>! = []
        var tempStr = ""
        var tempAttributedString:NSMutableAttributedString!
        for c in str.characters
        {
            switch c
            {
            case"中":tempStr += "⌾"
            case"仄":tempStr += "●"
            case"平":tempStr += "○"
            case"、":tempStr += "、"
            case"，":tempStr += "，"
            case"『":tempStr += "『"
            case"』":tempStr += "』"
            case"〖":tempStr += "〖"
            case"〗":tempStr += "〗"
            case"韵":
                if tempStr.characters.last == "○"
                {
                    tempStr.removeAtIndex(tempStr.endIndex.advancedBy(-1))
                    tempStr += "●"
                    tempAttributedString =  NSMutableAttributedString(string: tempStr)
                    tempAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSMakeRange(tempStr.characters.count - 1, 1))
                    isPing = true
                }
                else
                {
                    tempAttributedString =  NSMutableAttributedString(string: tempStr)
                    tempAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(tempStr.characters.count - 1, 1))
                }
            case"。":tempStr += "。"
            array.append(tempAttributedString)
            tempStr = ""
            default:break
            }
        }
        return array
    }
}
