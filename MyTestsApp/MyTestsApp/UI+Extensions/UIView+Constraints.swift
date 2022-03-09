//
//  UIView+Constraints.swift
//  Prototype
//
//  Created by Kanyan Zheng on 2022/3/7.
//

import UIKit

extension UIView {
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first {
                $0.firstAttribute == .height && $0.relation == .equal
            }
        }
        set {
            setNeedsLayout()
        }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first {
                $0.firstAttribute == .height && $0.relation == .equal
            }
        }
        set {
            setNeedsLayout()
        }
    }
    
    var leadingConstraint: NSLayoutConstraint? {
        get {
            return constraints.first {
                $0.firstAttribute == .leading && $0.relation == .equal
            }
        }
        set {
            setNeedsLayout()
        }
    }
}
