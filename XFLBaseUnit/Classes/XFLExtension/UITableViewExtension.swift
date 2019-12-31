//
//  UITableView.swift
//  CCBase
//
//  Created by xfl on 2019/6/24.
//

import UIKit

public extension UITableView {
    
    func xfl_longScreenShots() -> UIImage? {
        
        var image:UIImage?
        let savedContentOffset = contentOffset
        let savedFrame = frame
        UIGraphicsBeginImageContextWithOptions(contentSize, true, UIScreen.main.scale)
        let navH = UIApplication.shared.statusBarFrame.size.height + 44
        for _ in 0..<3 {
            contentOffset = CGPoint.zero
            frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height + navH)
            layer.render(in: UIGraphicsGetCurrentContext()!)
        }
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        frame = savedFrame
        contentOffset = savedContentOffset
        return image
    }
}
