//
//  UIView-Extension.swift
//  CCBase
//
//  Created by xfl on 2019/6/24.
//

import UIKit

public extension UIView {
    
    /// 从xib中创建一个控件
    class func viewFromXib(bundleClass: AnyClass?) -> UIView {
        
        let bundle = bundleClass == nil ? Bundle.main : Bundle(for: bundleClass!)
        return (bundle.loadNibNamed(String(describing: self.self), owner: self, options: nil)?.last)! as! UIView
    }
    
    /// 从静态库bundle中创建view
    class func viewFromStaticXib(bundleName:String) -> UIView {
        
        var view:UIView!
        
        if let resourcePath = Bundle.main.resourcePath {
            let path = resourcePath + "/" + "\(bundleName).bundle"
            let name = String(describing: self.self)
            let bundle = Bundle(path: path)
            view = (bundle?.loadNibNamed(name, owner: nil, options: nil)?.last)! as? UIView
        }
        
        return view
    }
    
    /// 移除所有子视图
    func xfl_removeAllSubViews(){
        
        while subviews.count > 0 {
            subviews.last?.removeFromSuperview()
        }
    }
    
    /// 切圆角
    func xfl_clipRadius( _ cornerRadius:CGFloat){
        
        xfl_makeCornerRadius(rectCorner: .allCorners, width: cornerRadius)
    }
    
    /// 切指定某几个角为圆角
    func xfl_makeCornerRadius(rectCorner:UIRectCorner, width:CGFloat){
        
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorner, cornerRadii: CGSize(width: width, height: width))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    /// view生成图片
    func xfl_imageFromView() -> UIImage? {
        
        var image:UIImage?
        
        // 第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// 父控制器
    var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        
        return nil
    }
}
