//
//  SSMap.swift
//  IOHealth
//
//  Created by xiaofulon on 2019/5/8.
//  Copyright © 2019 Loong. All rights reserved.
//  codable转模型

/*  使用方式
 *  1.模型遵循Mapable协议
 *  2.字典转模型,模型类名调用转模型方法mapFromDict
 *  3.数组转模型,数组调用转模型方法mapFromArray
 
 *  注意事项:
 *  1.不需要的字段可以不写入,可以更新字段名,如下:
    class Person: Mappable {
        var name : String = ""
        var age : Int = 0
        var score : Double = 0.00
        enum CodingKeys : String, CodingKey {
            case name = "name_a"
            case age
        }
    }
 *  2.为了统一适配后端返回null的情况,
    将json中的所有的[:null]和[:NULL]统一处理为空字符串
 *  3.为了处理后端返回的类型和定义的模型类型不一致,
    在JSONDecoderExtesion中覆盖decodeIfPresent方法,模型为可选时,依然可以解析
    如果模型是不可选的,必须确定后端返回的类型和模型一致
 *
 */

public enum MapError: Error {
    
    case jsonToModelFail    //json转model失败
    case jsonToDataFail     //json转data失败
    case dictToJsonFail     //字典转json失败
    case jsonToArrFail      //json转数组失败
}

public protocol Mapable: Codable {
    
}

public extension Mapable {

    ///字典转模型
    static func mapFromDict<T : Mapable>(_ dict : [String:Any], _ type:T.Type) throws -> T {
        
        guard let JSONString = dict.toJSONString() else {
            throw MapError.dictToJsonFail
        }
        
        let jsonStr0 = JSONString.replacingOccurrences(of: ":null", with: ":\"\"")
        let jsonStr1 = jsonStr0.replacingOccurrences(of: ":NULL", with: ":\"\"")
        guard let jsonData = jsonStr1.data(using: .utf8) else {
            throw MapError.jsonToDataFail
        }
        
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        
        throw MapError.jsonToModelFail
    }
    
    
    //JSON转模型
    static func mapFromJson<T : Mapable>(_ JSONString : String, _ type:T.Type) throws -> T {
        
        let jsonStr0 = JSONString.replacingOccurrences(of: ":null", with: ":\"\"")
        let jsonStr1 = jsonStr0.replacingOccurrences(of: ":NULL", with: ":\"\"")
        guard let jsonData = jsonStr1.data(using: .utf8) else {
            throw MapError.jsonToDataFail
        }
        
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        
        throw MapError.jsonToModelFail
    }
    
    // 模型转字典
    func toDict() -> [String:Any]? {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:Any] else {
            return nil
        }
        
        return dict ;
    }
}


public extension Array {
    
    // 字典数组转模型数组
    func mapFromArray<T : Mapable>(_ type:[T].Type) throws -> Array<T> {
        
        guard let JSONString = self.toJSONString() else {
            throw MapError.dictToJsonFail
        }
        
        let jsonStr0 = JSONString.replacingOccurrences(of: ":null", with: ":\"\"")
        let jsonStr1 = jsonStr0.replacingOccurrences(of: ":NULL", with: ":\"\"")
        guard let jsonData = jsonStr1.data(using: .utf8) else {
            throw MapError.jsonToDataFail
        }
        
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        
        throw MapError.jsonToArrFail
    }
    
    // 数组转json字符串
    func toJSONString() -> String? {
        
        if (!JSONSerialization.isValidJSONObject(self)) {
            return nil
        }
        if let newData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            let jsonString = String(data: newData, encoding: .utf8)
            return jsonString ?? nil
        }
        
        return nil
    }
}


public extension Dictionary {
    
    // 字典转字符串
    func toJSONString() -> String? {
        
        if (!JSONSerialization.isValidJSONObject(self)) {
            return nil
        }
        
        if let newData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            let jsonString = String(data: newData, encoding: .utf8)
            return jsonString ?? nil
        }
        
        return nil
    }
}


public extension String {
    
    // json字符串转字典
    func toDict() -> [String:Any]? {
        
        guard let jsonData = self.data(using: .utf8) else {
            return nil
        }
        
        if let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
            return dict as? [String : Any]
        }
        
        return nil
    }
}

