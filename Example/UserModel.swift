//
//  UserModel.swift
//  Example
//
//  Created by liushuang on 2018/1/19.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import Foundation
//创建一个继承自NSObject的类，并遵守NSCoding协议。遵循该协议的类，可以被序列化和反序列化，这样可以归档到磁盘上或分发到网络上。
class UserModel: NSObject,NSCoding {
    var name:NSString!
    var password:NSString!
    
    //然后添加一个协议方法，用来对模型对象进行序列化操作。
    func encode(with aCoder: NSCoder) {
        //对模型的姓名属性，进行编码操作，并设置对应的键名。
        aCoder.encode(self.name, forKey: "name")
        //对模型的密码属性，进行编码操作，并设置对应的键名。
        aCoder.encode(self.password, forKey: "password")
    }
    
    //接着添加另一个来自协议的方法，用来对模型对象进行反序列化操作。
    required init?(coder aDecoder: NSCoder) {
        super.init()
        //对模型对象的姓名属性，根据对应的键名，进行解码操作。
        self.name = aDecoder.decodeObject(forKey: "name") as! NSString
        //对模型对象的密码属性，根据对应的键名，进行解码操作。
        self.password = aDecoder.decodeObject(forKey: "password") as! NSString
    }
    //最后重载父类的初始化方法。接着然后在项目导航区，打开视图控制器的代码文件。
    override init() {
        
    }
    
}
