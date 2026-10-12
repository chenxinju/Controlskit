//
//  UIView+CKCorner.swift
//  AxcUIKit
//
//  UIView 通用圆角（Swift）。与 UIView+CKCorner.h/.m 能力对等。
//  OC：ck_setCornerRadius: / ck_setLayerCornerRadius:
//  Swift：ck_applyCornerRadius / ck_applyLayerCornerRadius（避免与桥接进来的 OC 方法重名）
//

import UIKit

public extension UIView {

    /// 四角相同圆角（CAShapeLayer mask）
    @objc(ck_applyCornerRadius:)
    func ck_applyCornerRadius(_ radius: CGFloat) {
        ck_applyCornerRadius(radius, corners: .allCorners)
    }

    /// 指定角圆角（CAShapeLayer mask）。bounds 变化后需再调一次。
    @objc(ck_applyCornerRadius:corners:)
    func ck_applyCornerRadius(_ radius: CGFloat, corners: UIRectCorner) {
        if bounds.isEmpty {
            layoutIfNeeded()
        }
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }

    /// 系统 layer 圆角（masksToBounds）。会清掉已有的 CAShapeLayer mask。
    @objc(ck_applyLayerCornerRadius:)
    func ck_applyLayerCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        if layer.mask is CAShapeLayer {
            layer.mask = nil
        }
    }
}
