//
//  User+CoreDataProperties.swift
//  Example
//
//  Created by liushuang on 2018/1/19.
//  Copyright © 2018年 liushuang. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var userName: String?

}
