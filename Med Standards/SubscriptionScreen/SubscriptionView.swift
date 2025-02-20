//
//  SubscriptionView.swift
//  Med Standards
//
//  Created by Oleksandr on 05.02.2025.
//  Copyright © 2025 ColbyCoApps. All rights reserved.
//

import UIKit

protocol SubscriptionViewDelegate: AnyObject {
    func restoreButtonDidTap()
    func closeButtonDidTap()
    func selectButtonDidTap()
    func termsButtonDidTap()
    func privacyButtonDidTap()
}

final class SubscriptionView: UIView {
    
    var subscriptionModel: SubscriptionModel? {
        didSet {
            guard let subscription = subscriptionModel else { return }
            
            let priceText = subscription.localizedPrice // "$0.99"
            let durationText = subscription.duration
            
            // Create an attributed string
            let attributedString = NSMutableAttributedString()
            
            // Create a string with custom attributes
            let part1 = NSAttributedString(string: priceText, attributes: [.font: UIFont.boldSystemFont(ofSize: 48)])
            let part2 = NSAttributedString(string: durationText, attributes: [.font: UIFont.systemFont(ofSize: 20)])
            
            // Append the attributed strings
            attributedString.append(part1)
            attributedString.append(part2)
            // Set the attributed string to the label
            priceLabel.attributedText = attributedString
        }
    }
    
    // MARK: - Private properties
    
    private weak var delegate: SubscriptionViewDelegate?
    
    // MARK: - Private views
    
    private let backgroundMaskView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexString: "007AFF")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var restoreButton = createButtonsForStackView(
        title: "Restore",
        titleColor: .black.withAlphaComponent(0.5)
    )
    private lazy var privacyButton = createButtonsForStackView(
        title: "Privacy policy",
        titleColor: .black.withAlphaComponent(0.5)
    )
    private lazy var termsButton = createButtonsForStackView(
        title: "Terms of Use",
        titleColor: .black.withAlphaComponent(0.5)
    )
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Subscription plan"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let planeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "plane")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let basicContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    private lazy var basicLabel: UILabel = {
        let label = UILabel()
        label.text = "Basic"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let premiumFeaturesVerticalStackView: UIStackView = .init()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back To Home", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    
    init(delegate: SubscriptionViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
        setupPremiumFeaturesStackView()
        addSubviews()
        setConstraints()
        addButtonsActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        debugPrint(#function)
        configBackgroundView()
        basicContainerView.applyShadow(
            shadowOffSet: CGSize(width: -4, height: -4),
            shadowOpacity: 10,
            shadowRadius: 5,
            color: .black.withAlphaComponent(0.1)
        )
    }
    
    // MARK: - Actions
    
    @objc private func buttonsAction(_ sender: UIButton) {
        switch sender {
        case restoreButton:
            delegate?.restoreButtonDidTap()
        case closeButton:
            delegate?.closeButtonDidTap()
        case selectButton:
            delegate?.selectButtonDidTap()
        case privacyButton:
            delegate?.privacyButtonDidTap()
        case termsButton:
            delegate?.termsButtonDidTap()
        default:
            break
        }
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = .white
    }
    
    private func configBackgroundView() {
        // Drawing code
        // Get Height and Width
        let layerHeight = backgroundMaskView.frame.height
        let layerWidth = backgroundMaskView.frame.width
        // Create Path
        let bezierPath = UIBezierPath()
        //  Points
        let pointA = CGPoint(x: 0, y: layerHeight)
        let pointB = CGPoint(x: 0, y: layerHeight * 0.44)
        let pointC = CGPoint(x: layerWidth, y: layerHeight * 0.36)
        let pointD = CGPoint(x: layerWidth, y: layerHeight)
        // Draw the path
        bezierPath.move(to: pointA)
        bezierPath.addLine(to: pointB)
        bezierPath.addLine(to: pointC)
        bezierPath.addLine(to: pointD)
        bezierPath.close()
        // Mask to Path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.strokeColor = UIColor(hexString: "007AFF").cgColor
        backgroundMaskView.layer.mask = shapeLayer
    }
    
    private func addButtonsActions() {
        restoreButton.addTarget(self, action: #selector(buttonsAction(_:)), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(buttonsAction(_:)), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(buttonsAction(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(buttonsAction(_:)), for: .touchUpInside)
        selectButton.addTarget(self, action: #selector(buttonsAction(_:)), for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(backgroundMaskView)
        topButtonsStackView.addArrangedSubview(termsButton)
        topButtonsStackView.addArrangedSubview(privacyButton)
        topButtonsStackView.addArrangedSubview(restoreButton)
        addSubview(topButtonsStackView)
        addSubview(topLabel)
        addSubview(topSeparatorView)
        addSubview(planeImageView)
        
        basicContainerView.addSubview(basicLabel)
        addSubview(basicContainerView)
        addSubview(priceLabel)
        addSubview(premiumFeaturesVerticalStackView)
        addSubview(selectButton)
        addSubview(closeButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundMaskView.topAnchor.constraint(equalTo: topAnchor),
            backgroundMaskView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundMaskView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundMaskView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            topButtonsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            topButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topButtonsStackView.heightAnchor.constraint(equalToConstant: 30),
            
            topLabel.topAnchor.constraint(equalTo: topButtonsStackView.bottomAnchor, constant: 16.fitH),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 24),
            
            topSeparatorView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 16.fitH),
            topSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            
            planeImageView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: 24),
            planeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            planeImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            planeImageView.heightAnchor.constraint(equalTo: planeImageView.widthAnchor, multiplier: 1),
            
            basicContainerView.topAnchor.constraint(equalTo: planeImageView.bottomAnchor, constant: 20.fitH),
            basicContainerView.widthAnchor.constraint(equalToConstant: 188.fitW),
            basicContainerView.heightAnchor.constraint(equalToConstant: 46.fitH),
            basicContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            basicLabel.centerYAnchor.constraint(equalTo: basicContainerView.centerYAnchor),
            basicLabel.centerXAnchor.constraint(equalTo: basicContainerView.centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: basicContainerView.bottomAnchor, constant: 20.fitH),
            priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            premiumFeaturesVerticalStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 40.fitH),
            premiumFeaturesVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.fitW),
            premiumFeaturesVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 24.fitW),
            
            selectButton.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -8.fitH),
            selectButton.leadingAnchor.constraint(equalTo: closeButton.leadingAnchor),
            selectButton.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: 48),
            
            closeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8.fitH),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.fitW),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.fitW),
            closeButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupPremiumFeaturesStackView() {
        premiumFeaturesVerticalStackView.axis = .vertical
        premiumFeaturesVerticalStackView.spacing = 16
        premiumFeaturesVerticalStackView.translatesAutoresizingMaskIntoConstraints = false

        let firstFeature = createHStack(text: "One month free trial")
        let secondFeature = createHStack(text: "Paid tier has unlimited document views")
        let thirdFeature = createHStack(text: "Free tier document views are limited to \n5 documents per month")
        let fourthFeature = createHStack(text: "Possibility of searching in PDF files")
        
        premiumFeaturesVerticalStackView.addArrangedSubview(firstFeature)
        premiumFeaturesVerticalStackView.addArrangedSubview(secondFeature)
        premiumFeaturesVerticalStackView.addArrangedSubview(thirdFeature)
        premiumFeaturesVerticalStackView.addArrangedSubview(fourthFeature)
    }

    private func createHStack(text: String) -> UIStackView {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 6
        hStack.distribution = .fill
        hStack.alignment = .top
        hStack.addArrangedSubview(imageView)
        hStack.addArrangedSubview(label)

        return hStack
    }
}
