//
//  ViewController.swift
//  XFLBaseUnit
//
//  Created by xiaofulon on 12/31/2019.
//  Copyright (c) 2019 xiaofulon. All rights reserved.
//

import UIKit
import XFLBaseUnit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         toModelTest()
         revoseGeo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func toModelTest() {
        
        let stu = [["age":"18","name":"jack","id":nil,"dog":["age":3,"name":"xiaoHei"]],
                    ["age":"19","name":"stefen","id":222,"dog":["age":4,"name":"xiaoBai"]],
                    ["age":"20","name":"frank","id":333,"dog":["age":5,"name":"xiaoZi"]]] as [Any]
        if let stuMdls = try? stu.mapFromArray([Person].self) {
            print("\(stuMdls)")
        }
    }
    
    fileprivate func revoseGeo() {
        
        XFLLocationUtils.reverseGeocode(23.4567, longitude: 115.0987) { (location) in
            print("\(location.address!)")
        }
    }
}

