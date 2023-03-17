//
//  WarningPaddingLabel.swift
//  GBShop
//
//  Created by Artem Mayer on 08.03.2023.
//

import UIKit

final class WarningPaddingLabel: UILabel {

    // MARK: - Private properties

    private let topInset: CGFloat = 5.0
    private let bottomInset: CGFloat = 5.0
    private let leftInset: CGFloat = 10.0
    private let rightInset: CGFloat = 10.0

    // MARK: - Constructions
    
    init(frame: CGRect = .zero, text: String = "", font: UIFont = .systemFont(ofSize: 16)) {
        super.init(frame: frame)

        self.text = text
        self.font = font
        textColor = .systemRed
        backgroundColor = .systemBackground
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        layer.sublayers?.removeAll()
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
        borderLayer.strokeStart = 0.494
        borderLayer.strokeEnd = getEndPoint()
        
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }

    func getEndPoint() -> Double {
        let angleCircleRadius = 10.0
        let topSide = bounds.width
        let bottomSide = topSide - (angleCircleRadius * 2)
        let rightSide = bounds.height - angleCircleRadius
        let lengthSides = rightSide * 2
        let widthSides = topSide + bottomSide
        let anglesLength = Double.pi * angleCircleRadius
        let pathLength = lengthSides + widthSides + anglesLength
        let endPoint = pathLength - rightSide
        let roundedStrokeEnd = round((endPoint/pathLength)*1000)/1000

        return roundedStrokeEnd
    }
}
