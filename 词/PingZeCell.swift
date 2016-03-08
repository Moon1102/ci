//
//  PingZeView.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/28.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class PingZeCell:UITableViewCell
{
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var input: UITextField!
    
    lazy var isPing = false
    
    @IBAction func change(sender: UITextField)
    {
        let res = compare(change(),array2: pingzepanduan(input.text!))
        
        if res == [] || res == [0] { return }
   
        colorText(UIColor.redColor(),array: res)
    }
    @IBAction func click(sender: UITextField)
    {
        if input.text! != "" { colorText(UIColor.blackColor(),array: [1]) }
    }
    @IBAction func outputText(sender: UITextField)
    {
        (getCurrentVC() as! WriteViewController).dataArr[sender.tag] = sender.text
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
    func colorText(color:UIColor,array:Array<Int>)
    {
        let tempAttributedString = NSMutableAttributedString(string:"\(input.text!)")
        
        for i in array
        {
            tempAttributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(i, 1))
        }
        input.attributedText = tempAttributedString
    }
    func pingzepanduan(str:String)->Array<Int>
    {
        let temp = NSMutableString(string:str) as CFMutableStringRef
        
        if CFStringTransform(temp, nil, kCFStringTransformMandarinLatin, false)
        {
            var res:Array<Int> = []
            let arr = (temp as String).componentsSeparatedByString(" ")
            for index in 0..<arr.count
            {
                if (arr[index].rangeOfCharacterFromSet(NSCharacterSet(charactersInString: "ǔùǐìǎàèěǒò")) != nil)
                {
                    res.append(1)
                }
                else
                {
                    res.append(0)
                }
            }
            return res
        }
        return []
    }
    func change()->Array<Int>
    {
        var res:Array<Int> = []
        
        for c in (contentLabel.text?.characters)!
        {
            if  c == "●" || c == "⌾" || c == "○"
            {
                c == "●" ?  res.append(1) : res.append(0)
            }
        }
        
        if isPing
        {
            res.removeLast()
            res.append(0)
        }
        return res
    }
    func compare(array1:Array<Int>,array2:Array<Int>)->Array<Int>
    {
        var res:Array<Int> = []

        let count =  array1.count <= array2.count ? array1.count : array2.count
        
        for index in 0..<count
        {
            if array1[index] != array2[index]
            {
                res.append(index)
            }
        }
        return res
    }
}