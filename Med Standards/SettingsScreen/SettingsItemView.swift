//
//  SettingsItemView.swift
//  Med Standards
//
//  Created by Oleksandr on 11.02.2025.
//  Copyright © 2025 ColbyCoApps. All rights reserved.
//

import UIKit

final class SettingsItemView: UIView {

    var onTap: (() -> Void)?

    // MARK: - Private properties

    private let titleLabel: UILabel = .init()
    private let settingIconView: UIImageView = .init()
    private let chevronImageView: UIImageView = .init(image: UIImage(systemName: "chevron.right"))
    private let separatorView: UIView = .init()

    // MARK: - Initialisers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func configure(title: String, icon: UIImage?) {
        titleLabel.text = title
        settingIconView.image = icon
        settingIconView.contentMode = .scaleAspectFit
    }

    func changeLastItem() {
        separatorView.isHidden = true
    }
    
    func canGoForward(_ isCanForward: Bool) {
        chevronImageView.isHidden = !isCanForward
    }
}

// MARK: - Private methods

private extension SettingsItemView {
    func setupView() {
        backgroundColor = .clear
        chevronImageView.tintColor = .lightGray
        chevronImageView.contentMode = .scaleAspectFit
        separatorView.backgroundColor = .gray.withAlphaComponent(0.3)
        titleLabel.font = .systemFont(ofSize: 17)
        titleLabel.textColor = .black

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)

        setupConstraints()
    }

    @objc func handleTap() {
        backgroundColor = .gray.withAlphaComponent(0.6)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.backgroundColor = .clear
        }

        onTap?()
    }

    func setupConstraints() {
        let iconSize: CGFloat = 24
        [settingIconView, titleLabel, chevronImageView, separatorView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            
            settingIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.fitW),
            settingIconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingIconView.widthAnchor.constraint(equalToConstant: iconSize),
            settingIconView.heightAnchor.constraint(equalToConstant: iconSize),
            
            titleLabel.leadingAnchor.constraint(equalTo: settingIconView.trailingAnchor, constant: 32),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.fitW),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: iconSize),
            chevronImageView.heightAnchor.constraint(equalToConstant: iconSize),
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
