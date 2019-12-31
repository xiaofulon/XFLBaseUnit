//
//  String-Extension.swift
//  Alamofire
//
//  Created by xfl on 2019/6/24.
//

import UIKit

public extension String {
   
    /// 字符串截取
    func xfl_substring(from: Int?, to: Int?) -> String {
        
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    /// 字符串截取end = endIndex
    func xfl_substring(from: Int) -> String {
        return self.xfl_substring(from: from, to: nil)
    }
    
    /// 字符串截取,start = 0
    func xfl_substring(to: Int) -> String {
        return self.xfl_substring(from: nil, to: to)
    }
    
    /// 字符串截取,end = from + length
    func xfl_substring(from: Int?, length: Int) -> String {
        
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.xfl_substring(from: from, to: end)
    }
    
    /// 字符串截取,start = to - length
    func xfl_substring(length: Int, to: Int?) -> String {
        
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.xfl_substring(from: start, to: to)
    }
    
    ///对带特殊符号的url进行转译
    func xfl_urlEncoding() -> String? {
        let characters = "`#%^{}\"[]|\\<> "
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.init(charactersIn: characters).inverted)
    }
    
    /// 检查电话号码是否格式正确
    /**
     * 手机号码:
     * 13[0-9], 14[5,7,8,9], 15[0,1,2,3,5,6,7,8,9], 16[5,6], 17[0-8], 18[0-9], 19[1,8,9]
     * 移动号段: 134,135,136,137,138,139,147,148,150,151,152,157,158,159,165,170,172,178,182,183,184,187,188,198
     * 联通号段: 130,131,132,145,155,156,166,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,174,177,180,181,189,191,199
     */
    func xfl_validateTelephoneNumber() -> Bool {
        
        // 去空格, 调用手机通讯录时有可能号码是xxx xxxx xxxx格式, 所以去空格
        let numString = self.replacingOccurrences(of: " ", with: "")
        // 手机号
        let mobile = "^1(3[0-9]|4[5789]|5[0-35-9]|16[56]|7[0-8]|8[0-9]|19[189])\\d{8}$"
        
        // 移动
        let  CM = "^1(3[4-9]|4[78]|5[0-27-9]|6[5]|7[028]|8[2-478]|9[8])\\d{8}$"
        
        // 联通
        let  CU = "^1(3[0-2]|4[5]|5[56]|6[6]|7[0156]|8[56])\\d{8}$"
        
        // 电信
        let  CT = "^1(3[3]|4[9]|53|7[0347]|8[019]|9[19])\\d{8}$"
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        
        if regextestmobile.evaluate(with: numString) == true
            
            || regextestcm.evaluate(with: numString)  == true
            
            || regextestct.evaluate(with: numString) == true
            
            || regextestcu.evaluate(with: numString) == true {
            
            return true
            
        }else {
            
            return false
        }
    }
    
    /// 验证密码是否由8-16位数字和字母组合
    func xfl_verifyPassword() -> Bool {
        
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,16}"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch = pred.evaluate(with: self)
        
        return isMatch
    }
    
    /// 计算文本字符串的宽度
    func xfl_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    /// 计算文本字符串的高度
    func xfl_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    /// 计算文本字符串的高度
    func xfl_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    
    /// 判断是否为空字符串（包含多个空格的情况）
    var xfl_isBlank: Bool {
        let trimmedStr = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
}
