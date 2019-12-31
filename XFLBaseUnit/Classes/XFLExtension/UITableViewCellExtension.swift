//
//  UITableViewCell-Extension.swift
//  CCBase
//
//  Created by xfl on 2019/6/24.
//

import UIKit

public extension UITableViewCell {
    
    /// cell刷新时的动画效果
    enum CellAnimation: NSInteger {
        /// 没有动画
        case none = 0
        /// 左侧插入动画
        case left = 1
        /// 右侧插入动画
        case right = 2
        
    }
    
    /// cell刷新时的动画效果
    func insertAnimation(_ type:CellAnimation){
        
        // 左侧插入动画
        if type == .left {
            var center = self.center
            let orgCenter = center
            center.x += bounds.size.width
            self.center = center
            UIView.animate(withDuration: 0.15) {
                self.center = orgCenter
            }
        }
            // 右侧插入动画
        else if type == .right {
            var center = self.center
            let orgCenter = center
            center.x -= self.bounds.size.width
            self.center = center
            UIView.animate(withDuration: 0.15) {
                self.center = orgCenter
            }
        }
    }
}
