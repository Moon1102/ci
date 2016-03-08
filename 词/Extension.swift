//
//  Extension.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/29.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

extension NameModel
{
    func getColor(db:SQLiteDB)->UIColor
    {
        if 0 == parent_id as! NSObject
        {
            let rgbData = db.query("SELECT * FROM color WHERE id = \(color_id) ")
            return  UIColor(red: CGFloat(rgbData.first!["red"]! as! NSNumber)/255, green: CGFloat(rgbData.first!["green"]! as! NSNumber)/255, blue: CGFloat(rgbData.first!["blue"]! as! NSNumber)/255, alpha: 1)
        }
        return UIColor.blackColor()
    }
}
extension NSObject{
    class func objectWithKeyValues(keyValues:NSDictionary) -> AnyObject{
        let model = self.init()
        //存放属性的个数
        var outCount:UInt32 = 0
        //获取所有的属性
        let properties = class_copyPropertyList(self.classForCoder(), &outCount)
        //遍历属性
        for var i = 0;i < Int(outCount);i++ {
            //获取第i个属性
            let property = properties[i]
            //得到属性的名字
            let key = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)!
            if let value = keyValues[key]{
                //为model类赋值
                model.setValue(value, forKey: key as String)
            }
        }
        return model
    }
}