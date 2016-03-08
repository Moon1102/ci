//
//  PingZeSearchViewControlller.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/28.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class PingZeSearchViewControlller: UITableViewController,UISearchDisplayDelegate,UISearchBarDelegate
{
    lazy var dic = ["a":"一麻","o":"二波","ie":"三皆","ai":"四开","ei":"五微","ao":"六豪","ou":"七尤","an":"八寒","en":"九文","ang":"十唐","eng":"十一庚"]
    lazy var data = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "DataCell", bundle: nil), forCellReuseIdentifier: "data")
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UINib(nibName: "DataCell", bundle: nil).instantiateWithOwner(nil, options: nil).first  as! DataCell
        cell.content.text = data
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 270
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        guard pingzepanduan(searchText).1.first != nil else
        {
            return
        }
        if let res = SQLiteDB.sharedInstance().query("SELECT * FROM zhonghuaxinyun WHERE tone = \(pingzepanduan(searchText).1.first!) AND section_desc = '\(pingzepanduan(searchText).0)'").first
        {
            data = res["glys"]! as! String
            
            tableView.reloadData()
        }
    }
    func pingzepanduan(str:String)->(String,Array<Int>)
    {
        if let tempRes = tiquzhongwen(str)
        {
            let temp = NSMutableString(string:tempRes) as CFMutableStringRef
            
            if CFStringTransform(temp, nil, kCFStringTransformMandarinLatin, false)
            {
                var res:(String,Array<Int>) = ("",[])
                
                let arr = (temp as String).componentsSeparatedByString(" ")
                
                for index in 0..<arr.count
                {
                    if (arr[index].rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "ǔùǐìǎàèěǒò")) != nil)
                    {
                        res.1.append(20)
                    }
                    else
                    {
                        res.1.append(10)
                    }
                }
                
                if CFStringTransform(temp, nil, kCFStringTransformStripDiacritics, false)
                {
                    let tempStr = (temp as String).componentsSeparatedByString(" ").first!
                    
                    if (tempStr.rangeOfString("a") != nil)
                    {
                        res.0 = dic["a"]!
                        
                        if tempStr.hasSuffix("ao")
                        {
                            res.0 = dic["ao"]!
                        }
                        else if tempStr.hasSuffix("an")
                        {
                            res.0 = dic["an"]!
                        }
                        else if tempStr.hasSuffix("ai")
                        {
                            res.0 = dic["ai"]!
                        }
                        else if tempStr.hasSuffix("ang")
                        {
                            res.0 = dic["ang"]!
                        }
                    }
                    else if (tempStr.rangeOfString("o") != nil)
                    {
                        res.0 = dic["o"]!
                        
                        if tempStr.hasSuffix("ou")
                        {
                            res.0 = dic["ou"]!
                        }
                    }
                    else if (tempStr.rangeOfString("e") != nil)
                    {
                        res.0 = dic["ie"]!
                        
                        if tempStr.hasSuffix("ei")
                        {
                            res.0 = dic["ei"]!
                        }
                        else if tempStr.hasSuffix("en")
                        {
                            res.0 = dic["en"]!
                        }
                        else if tempStr.hasSuffix("eng")
                        {
                            res.0 = dic["eng"]!
                        }
                        else if tempStr.hasSuffix("ue")
                        {
                            res.0 = dic["ie"]!
                        }
                        else if tempStr.hasSuffix("e")
                        {
                            res.0 = dic["o"]!
                        }
                    }
                    else if (tempStr.rangeOfString("u") != nil)
                    {
                        res.0 = "十四姑"
                        
                        if tempStr.hasSuffix("ui")
                        {
                            res.0 = "五微"
                        }
                        else if tempStr.hasPrefix("q") || tempStr.hasPrefix("y") || tempStr.hasPrefix("x") || tempStr.hasPrefix("j")
                        {
                            res.0 = "十二齐"
                        }
                    }
                    else if tempStr.hasSuffix("i")
                    {
                        res.0 =  "十三支"
                        if tempStr.hasPrefix("q") || tempStr.hasPrefix("y") || tempStr.hasPrefix("x") || tempStr.hasPrefix("n") || tempStr.hasPrefix("j")
                        {
                            res.0 = "十二齐"
                        }
                    }
                }
                return res
            }
        }
        return ("",[])
    }
    func tiquzhongwen(str:NSString)->String?
    {
        var tempArr:Array<String> = []
        
        for i in 0..<str.length
        {
            if str.characterAtIndex(i) > 0x4e00 && str.characterAtIndex(i) < 0x9fff
            {
                tempArr.append(str.substringWithRange(NSRange(location: i, length: 1)))
            }
        }
        return tempArr.first
    }
    func searchDisplayControllerWillBeginSearch(controller: UISearchDisplayController) {
        searchDisplayController?.searchBar.showsCancelButton = true
        var cancelBtn:UIButton!
        for sub in (searchDisplayController?.searchBar.subviews.first?.subviews)!
        {
            if sub.isKindOfClass(NSClassFromString("UINavigationButton")!){
                cancelBtn = sub as! UIButton
            }
        }
        if (cancelBtn != nil)
        {
            cancelBtn.setTitle("取消", forState: .Normal)
        }
    }
}
