//
//  WarningPaddingLabel.swift
//  GBShop
//
//  Created by Artem Mayer on 08.03.2023.
//

import UIKit

final class WarningPaddingLabel: UILabel {

    // MARK: - Private properties

    private var topInset: CGFloat = 5.0
    private var bottomInset: CGFloat = 5.0
    private var leftInset: CGFloat = 10.0
    private var rightInset: CGFloat = 10.0

    // MARK: - Properties
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let widthWithInsets = size.width + leftInset + rightInset
        let heightWithInsets = size.height + topInset + bottomInset

        return CGSize(width: widthWithInsets, height: heightWithInsets)
    }

    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }

    // MARK: - Lifecycle

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
        addBottomBorder()
    }

    // MARK: - Private functions

    private func addBottomBorder(){
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomRight, .bottomLeft],
            cornerRadii: CGSize(width: 10, height: 10))

        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = path.cgPath
        layer.mask = maskLayer

        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.systemRed.cgColor
        borderLayer.lineWidth = 2
        borderLayer.strokeStart = 0.49
        borderLayer.strokeEnd = 0.96
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}
