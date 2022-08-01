//
//  CardView.swift
//  SouthSystemProject
//
//  Created by Cesar Comelli on 31/07/22.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {

    @IBInspectable var shadowOffsetWidth: Int = 1
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor(red: 0, green: 0, blue: 0, alpha: 0.24)
    @IBInspectable var shadowOpacity: Float = 1
    @IBInspectable var cornerRadius: CGFloat = 10

    let contentView = UIView()

    private let showShadow: Bool

    init(showShadow: Bool = true) {
        self.showShadow = showShadow
        super.init(frame: .zero)
        setupView()
    }

    override init(frame: CGRect) {
        self.showShadow = true
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        self.showShadow = true
        super.init(coder: aDecoder)
    }

    private func setupView() {
        addSubview(contentView)
        contentView.anchorToEntireView(of: self)
        contentView.backgroundColor = .white
    }

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        contentView.layer.cornerRadius = cornerRadius
        contentView.clipsToBounds = true

        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        if showShadow {
            layer.masksToBounds = false
            layer.shadowColor = shadowColor?.cgColor
            layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
            layer.shadowOpacity = shadowOpacity
            layer.shadowPath = shadowPath.cgPath
        }
    }

}

extension UIView {

    func anchorToEntireView(of view: UIView, padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
    }
}
