//
//  XFLConstant.swift
//  XFLBaseUnit
//
//  Created by xfl on 2019/12/31.
//

import UIKit

// 屏幕宽度
public let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.width

// 屏幕高度
public let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.height

// 屏幕缩放比例
public let SCREEN_SCALE:CGFloat = UIScreen.main.scale

// 设备是否为苹果手机
public let IS_IPHONE:Bool = ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone )

// 设备是否为iphone4、4s。(3.5英寸)
public let IS_IPONE4:Bool = ( IS_IPHONE && SCREEN_HEIGHT < 568.0 )

// 设备是否为iphone5、5s、SE。(4英寸)
public let IS_IPONE5:Bool = ( IS_IPHONE && SCREEN_HEIGHT == 568.0 )

// 设备是否为iphone6、6s。(4.7英寸)
public let IS_IPONE6:Bool = ( IS_IPHONE && SCREEN_HEIGHT == 667.0 )

// 设备是否为iphone6 plus、6s plus。(5.5英寸)
public let IS_IPONE6_PLUS:Bool = ( IS_IPHONE && SCREEN_HEIGHT == 736.0 )

// 设备是否为iphoneX系列
public let IS_IPHONEX:Bool = {
    var isIphoneX = false
    if #available(iOS 11.0, *) {
        if let bottom = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom {
            if bottom > 0.0 {
                isIphoneX = true
            }
        }
    }
    return isIphoneX
}()

// 状态栏高度(iPhoneX为44, 其他机型均为20)
public let STATUS_HEIGHT:CGFloat = UIApplication.shared.statusBarFrame.size.height

// 标题栏高度(因为项目中不设置大标题,所以固定为44)
public let TITLE_HEIGHT:CGFloat = 44.0

// 导航条高度
public let NAV_HEIGHT:CGFloat = (STATUS_HEIGHT + TITLE_HEIGHT)

// tabBar视图高度
public let TAB_BAR_HEIGHT:CGFloat = IS_IPHONEX ? 83.0 : 49.0

//MARK:-自定义打印日志
public func CLog<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    
    #if DEBUG
    // 要把路径最后的字符串截取出来
    let fName = ((fileName as NSString).pathComponents.last!)
    print("\(fName).\(methodName)[\(lineNumber)]: \(message)")
    #endif
}

public func CLog<T>(_ message: T) {
    
    #if DEBUG
    print("\(message)")
    #endif
}
