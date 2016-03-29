//
//  WritingModel.swift
//  词
//
//  Created by Kiss-shot Acerola-orion Heart-under-blade on 16/2/29.
//  Copyright © 2016年 PX. All rights reserved.
//

import UIKit

class WritingModel: NSObject
{
    /** 内容 */
    var text:String!
    /** 唯一标识 */
    var id:AnyObject!
    /** 词牌名 */
    var ci_name:String!
    /** 创建时间(戳) */
    var create_dt:AnyObject!
    /** 图片id */
    var image_id:AnyObject!
}