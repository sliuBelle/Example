//
//  SingletonClass.swift
//  Example
//
//  Created by liushuang on 2018/1/19.
//  Copyright © 2018年 liushuang. All rights reserved.
//

import Foundation
class Singleton
{
    var action = "Run"
    static let singleton = Singleton()
    func doSomthing(){
        print(action)
    }
    
}
