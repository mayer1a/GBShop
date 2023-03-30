//
//  ChangeableStepper.swift
//  GBShop
//
//  Created by Artem Mayer on 30.03.2023.
//

import UIKit

final class ChangeableStepper: UIView {

    // MARK: - Properties

    var stepperAction: ((Int) -> Void)? {
        didSet {
            if stepperAction == nil {
                minusButton.removeTarget(self, action: #selector(minusButtonDidTap), for: .touchUpInside)
                plusButton.removeTarget(self, action: #selector(plusButtonDidTap), for: .touchUpInside)
            }
        }
    }

    // MARK: - Private properties

    private var value: Int {
        get { return _value }
        set {
            guard newValue != _value else { return }
            _value = getAvailableValue(newValue)
            valueDidChanged()
        }
    }

    private var _value: Int
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    private let numberLabel = UILabel()
    private let horizontalStack = UIStackView()

    // MARK: - Constructions

    init(value: Int) {
        self._value = StepperConstants.minStepperValue
        super.init(frame: .zero)
        configureVieComponents()
    }

    override init(frame: CGRect) {
        self._value = StepperConstants.minStepperValue
        super.init(frame: frame)
        configureVieComponents()
    }

    required init?(coder: NSCoder) {
        self._value = StepperConstants.minStepperValue
        super.init(coder: coder)
        configureVieComponents()
    }

    // MARK: - Functions

    func setupValue(_ value: Int) {
        self.value = value
    }

    // MARK: - Private functions

    private func configureVieComponents() {
        backgroundColor = .white
        addSubview(horizontalStack)

        setupHorizontalStack()
        configureStepperButton()
        configureLabel()
    }

    private func configureStepperButton() {
        generalButtonSetup(minusButton, imageName: "minus")
        generalButtonSetup(plusButton, imageName: "plus")
        minusButton.addTarget(self, action: #selector(minusButtonDidTap), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonDidTap), for: .touchUpInside)

        NSLayoutConstraint.activate([
            minusButton.leftAnchor.constraint(equalTo: horizontalStack.leftAnchor),
            minusButton.topAnchor.constraint(equalTo: horizontalStack.topAnchor),
            minusButton.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor),

            plusButton.rightAnchor.constraint(equalTo: horizontalStack.rightAnchor),
            plusButton.topAnchor.constraint(equalTo: horizontalStack.topAnchor),
            plusButton.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor),
        ])
    }

    private func configureLabel() {
        numberLabel.font = .monospacedDigitSystemFont(ofSize: 16.0, weight: .semibold)
        numberLabel.textAlignment = .center
        numberLabel.backgroundColor = .lightGray
        numberLabel.textColor = .black
        numberLabel.numberOfLines = 1
        numberLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            numberLabel.leftAnchor.constraint(equalTo: minusButton.rightAnchor),
            numberLabel.rightAnchor.constraint(equalTo: plusButton.leftAnchor),
            numberLabel.topAnchor.constraint(equalTo: horizontalStack.topAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor),
        ])
    }

    private func generalButtonSetup(_ button: UIButton, imageName: String) {
        button.setImage(.init(systemName: imageName), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.setPreferredSymbolConfiguration(.init(weight: .semibold), forImageIn: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupHorizontalStack() {
        horizontalStack.addArrangedSubview(minusButton)
        horizontalStack.addArrangedSubview(numberLabel)
        horizontalStack.addArrangedSubview(plusButton)

        horizontalStack.axis = .horizontal
        horizontalStack.backgroundColor = .lightGray
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.layer.cornerRadius = StepperConstants.cornerRadius
        horizontalStack.layer.borderWidth = 1.0
        horizontalStack.layer.borderColor = UIColor.white.cgColor
        horizontalStack.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            horizontalStack.leftAnchor.constraint(equalTo: leftAnchor),
            horizontalStack.rightAnchor.constraint(equalTo: rightAnchor),
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func getAvailableValue(_ value: Int) -> Int {
        switch value {
        case ...StepperConstants.minStepperValue:
            minimalValueDidSet()
            return StepperConstants.minStepperValue
        case StepperConstants.maxStepperValue...:
            maximumValueDidSet()
            return StepperConstants.maxStepperValue
        default:
            normalValueDidSet()
            return value
        }
    }

    private func valueDidChanged() {
        numberLabel.text = "\(value)"
    }

    private func minimalValueDidSet() {
        minusButton.isEnabled = false
    }

    private func maximumValueDidSet() {
        plusButton.isEnabled = false
    }

    private func normalValueDidSet() {
        plusButton.isEnabled = true
        minusButton.isEnabled = true
    }

    @objc private func minusButtonDidTap(_ sender: UIButton) {
        value -= 1
        stepperAction?(value)
    }

    @objc private func plusButtonDidTap(_ sender: UIButton) {
        value += 1
        stepperAction?(value)
    }
}
