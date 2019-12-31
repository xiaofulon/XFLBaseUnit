//
//  Person.swift
//  XFLBaseUnit_Example
//
//  Created by xfl on 2019/12/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import XFLBaseUnit

class Person: Mapable {
    
    var age:Int?
    var name:String?
    var id:String?
    var dog:Dog?
}


class Dog: Mapable {
    
    var age:Int?
    var name:String?
}
