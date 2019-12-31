//
//  UIImage-Extension.swift
//  Alamofire
//
//  Created by xfl on 2019/6/20.
//

import UIKit
import AVFoundation

public extension UIImage {
    
    /// 获取不同bundle的图片
    ///
    /// - Parameters:
    ///   - name: 图片名字(不需要@nx)
    ///   - bundleClass: 用到图片的类名,nil时使用mainBundle
    ///   - bundleFile: bundle的名称
    /// - Returns: 获取到的图片
    static func xfl_image(name: String, currentClass: AnyClass?, bundleFile: String? = nil) -> UIImage? {
        
        var image: UIImage?
        let bundle = currentClass == nil ? Bundle.main : Bundle(for: currentClass!)
        image = self.init(named: name, in: bundle, compatibleWith: nil)
        if image == nil, let path = bundle.path(forResource: bundleFile, ofType: "bundle") {
            image = self.init(named: name, in: Bundle.init(path: path), compatibleWith: nil)
        }
        if image == nil && currentClass != nil {
            let nameSpace = NSStringFromClass(currentClass!).components(separatedBy: ".").first
            if let nameS = nameSpace,  let path = bundle.path(forResource: nameS, ofType: "bundle"){
                image = self.init(named: name, in: Bundle.init(path: path), compatibleWith: nil)
            }
        }
        
        return image
    }
    
    /// 返回一张填充好颜色并且设置任意个圆角的图片
    /**
     color          填充颜色
     strokeColor    边框颜色
     borderWidth    边框宽度
     corners        需要设置圆角的角
     rect           范围
     cornerRadio    圆角大小
     */
    class func xfl_createCornersImage(_ color: UIColor, strokeColor: UIColor, borderWidth: CGFloat, corners: UIRectCorner, rect: CGRect, cornerRadio: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 2.0)
        var bezierPath:UIBezierPath?
        bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadio, height: cornerRadio))
        bezierPath?.addClip()
        color.setFill()
        bezierPath?.fill()
        bezierPath?.lineWidth = borderWidth
        strokeColor.setStroke()
        bezierPath?.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// 根据颜色生成图片
    class func xfl_createColorImage(_ color: UIColor) -> UIImage? {
        
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
    
    /// 返回一张填充好颜色，并且设置好圆角的图片
    /**
     color          填充颜色
     rect           范围
     cornerRadius   圆角大小
     */
    class func xfl_createRadiusImage(color: UIColor, cornerRadius:CGFloat, rect:CGRect) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 2.0)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        path.addClip()
        color.setFill()
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
    
    /// 返回一张虚线图片
    ///
    /// - Parameters:
    ///   - rect: 虚线范围
    ///   - color: 虚线颜色
    ///   - lineL: 虚线长度
    ///   - blankL: 空白长度
    ///   - lineWidth: 线宽
    /// - Returns: 虚线图片
    class func xfl_creatDottedLine(rect: CGRect, color: UIColor,lineL: CGFloat,blankL: CGFloat,lineWidth: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(rect.size) // 位图上下文绘制区域
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setLineCap(CGLineCap.square)
        let lengths:[CGFloat] = [blankL,lineL] // 绘制 跳过 无限循环
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        context.setLineDash(phase: 0, lengths: lengths)
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: rect.size.width, y: 0))
        context.strokePath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image ?? nil
    }
    
     /// 两张图片合成一张
     func xfl_composeImage(image2:UIImage) -> UIImage? {
        
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width:size.width, height:size.height))
        image2.draw(in: CGRect(x: (size.width - image2.size.width) / 2, y: (size.height - image2.size.height) / 2, width: image2.size.width, height: image2.size.height))
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultingImage
    }
    
    /// 修复图片旋转, 解决拍照后照片旋转90度的问题
    func xfl_fixOrientation() -> UIImage {
        
        if self.imageOrientation == .up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
            
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }
        
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        
        return img
    }
    
    
    /// *获取视频第一帧,用时较长,外部使用时y需异步
    ///
    /// - Parameters:
    ///   - urlString: 视频链接地址
    ///   - islocal: 是否本地视频
    /// - Returns: 图片
    class func xfl_getFrameImage(_ urlString:String?,islocal:Bool = false) -> UIImage? {
        
        guard let urlStr = urlString else {
            return nil
        }
        
        var Url:URL?
        
        if islocal {
            Url = URL(fileURLWithPath: urlStr)
        }else{
            Url = URL(string: urlStr)
        }
        
        guard let url = Url else {
            return nil
        }
        
        //获取网络视频
        let avAsset = AVURLAsset(url: url)
        //生成视频截图
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0,preferredTimescale: 600)
        var actualTime:CMTime = CMTimeMake(value: 0,timescale: 0)
        var image:UIImage?
        do {
            let imageRef:CGImage = try generator.copyCGImage(at: time, actualTime: &actualTime)
            image = UIImage(cgImage: imageRef)
        } catch _ {
            image = nil
        }
        return image
    }
    
    /// 图片去除渲染
    func xfl_originalImage() -> UIImage? {
        self.withRenderingMode(.alwaysOriginal)
        return self
    }
    
}
