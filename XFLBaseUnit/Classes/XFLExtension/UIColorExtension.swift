//
//  UIColor-Extensions.swift
//  06-HYPageView扩展
//
//  Created by xfl on 2019/6/18.
//  Copyright © 2019 xmg. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 根据rgb创建颜色(rgb取值范围0~255)
    public convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    /// 根据rgba创建颜色(rgb取值范围0~255,取值范围0.0~1.0)
    public convenience init(r : CGFloat, g : CGFloat, b : CGFloat, a:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// 创建随机颜色
    public class func xfl_randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    /// 从十六进制字符串获取颜色,
    /// color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
    /// 依赖String-Extension
   public class func xfl_colorTransform(hexString:String, alpha:CGFloat) -> UIColor {
        
        // 删除字符串中的空格
        var cString = hexString.trimmingCharacters(in: CharacterSet.whitespaces).uppercased()
        
        // 小于6个字符直接返回空
        if cString.count < 6 {
            return UIColor.clear
        }
        
        // 若是0X前缀删除OX
        if cString.hasPrefix("0X") {
            cString = cString.xfl_substring(from: 2)
        }
        
        // 若是#前缀删除#
        if cString.hasPrefix("#") {
            cString = cString.xfl_substring(from: 1)
        }
        
        // 删除后如果不是6个字符则直接返回空
        if cString.count != 6 {
            return UIColor.clear
        }
        
        // r
        let rString = cString.xfl_substring(from: 0, to: 1)
        // g
        let gString = cString.xfl_substring(from: 2, to: 3)
        // b
        let bString = cString.xfl_substring(from: 4, to: 5)
        
        // scan values
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
}
