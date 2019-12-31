//
//  CCLocationUtils.swift
//  CCBase
//
//  Created by xfl on 2019/9/3.
//  逆地理解析服务

import UIKit
import CoreLocation

public struct XFLLocation {
    /// 纬度
   public var latitude:Double?
    /// 经度
   public var longitude:Double?
    /// 省份
   public var province:String?
    /// 行政区划自治区等
   public var subProvince:String?
    /// 城市
   public var city:String?
    /// 区
   public var area:String?
    /// 街道
   public var street:String?
    /// 门牌号
   public var numberPlate:String?
    /// 具体地址
   public var address:String?
}

public class XFLLocationUtils: NSObject {
    
    /// 地理信息反编码(通过经纬度获取地址)
    public static func reverseGeocode(_ latitude:Double, longitude:Double,
                                       completion:@escaping (_ address:XFLLocation) -> Void) {
        let geocoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            
            // 强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            var location = XFLLocation()
            location.latitude = latitude
            location.longitude = longitude
            
            // 显示所有信息
            if error == nil {
                
                var address = ""
                
                if let p = placemarks?[0]{
                    
                    // 省份
                    if let administrativeArea = p.administrativeArea {
                        address.append("\(administrativeArea)")
                        location.province = administrativeArea
                    }
                    // 其他行政区域信息（自治区等
                    if let subAdministrativeArea = p.subAdministrativeArea {
                        address.append("\(subAdministrativeArea)")
                        location.subProvince = subAdministrativeArea
                    }
                    // 城市
                    if let locality = p.locality {
                        address.append("\(locality)")
                        location.city = locality
                    }
                    // 区划
                    if let subLocality = p.subLocality {
                        address.append("\(subLocality)")
                        location.area = subLocality
                    }
                    // 街道
                    if let thoroughfare = p.thoroughfare {
                        address.append("\(thoroughfare)")
                        location.street = thoroughfare
                    }
                    // 门牌
                    if let subThoroughfare = p.subThoroughfare {
                        address.append("\(subThoroughfare)")
                        location.numberPlate = subThoroughfare
                    }
                    location.address = address
                }
                else {
                    location.address = ""
                }
                
                // 主线程异步执行
                DispatchQueue.main.async {
                    completion(location)
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(location)
                }
            }
        })
    }
}
