//
//  KMCornerShadowViewController.swift
//  AxcUIKit
//
//  KMCornerShadow 演示：圆角 + 阴影（独立 shadow 层，避免 clipsToBounds 裁切）
//

import UIKit

@objc(KMCornerShadowViewController)
class KMCornerShadowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground

        let scroll = UIScrollView(frame: view.bounds)
        scroll.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scroll.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(scroll)

        let configs: [(String, UIColor, CGFloat, CGFloat, Float, CGSize)] = [
            ("蓝影圆角", UIColor(red: 42/255, green: 122/255, blue: 255/255, alpha: 1), 12, 8, 0.45, CGSize(width: 0, height: 4)),
            ("绿影圆角", UIColor(red: 45/255, green: 213/255, blue: 140/255, alpha: 1), 20, 10, 0.4, CGSize(width: 0, height: 6)),
            ("橙影圆角", UIColor(red: 255/255, green: 91/255, blue: 40/255, alpha: 1), 8, 6, 0.5, CGSize(width: 2, height: 4)),
            ("黄影圆角", UIColor(red: 255/255, green: 186/255, blue: 0/255, alpha: 1), 50, 12, 0.35, CGSize(width: 0, height: 8)),
        ]

        let cardW: CGFloat = 140
        let cardH: CGFloat = 100
        let padding: CGFloat = 30
        let startY: CGFloat = 40
        let cols = 2
        let totalW = view.bounds.width

        for (idx, item) in configs.enumerated() {
            let col = idx % cols
            let row = idx / cols
            let x = (totalW - CGFloat(cols) * cardW - CGFloat(cols - 1) * padding) / 2 + CGFloat(col) * (cardW + padding)
            let y = startY + CGFloat(row) * (cardH + 50)

            let card = UIView(frame: CGRect(x: x, y: y, width: cardW, height: cardH))
            card.backgroundColor = .white
            card.createShadow(cornerRadius: item.2, shadowRadius: item.3, shadowOpacity: item.4, shadowColor: item.1, shadowOffset: item.5)
            scroll.addSubview(card)
            // km_ApplyShadow 依赖已加入 superview，需在 addSubview 之后调用
            card.km_ApplyShadow()

            let label = UILabel(frame: card.bounds)
            label.text = item.0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .darkGray
            card.addSubview(label)
        }

        let tip = UILabel(frame: CGRect(x: 20, y: startY + 2 * (cardH + 50) + 10, width: totalW - 40, height: 60))
        tip.numberOfLines = 0
        tip.font = UIFont.systemFont(ofSize: 12)
        tip.textColor = .gray
        tip.text = "KMCornerShadow：createShadow 设置圆角/阴影参数后，调用 km_ApplyShadow() 用独立层绘制阴影，避免 clipsToBounds 裁切阴影。"
        tip.autoresizingMask = [.flexibleWidth]
        scroll.addSubview(tip)

        scroll.contentSize = CGSize(width: totalW, height: tip.frame.maxY + 40)
    }
}
