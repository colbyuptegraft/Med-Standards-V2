//
//  SubscriptionViewController.swift
//  Med Standards
//
//  Created by Oleksandr on 05.02.2025.
//  Copyright © 2025 ColbyCoApps. All rights reserved.
//

import UIKit

final class SubscriptionViewController: UIViewController, SubscriptionScreen {
    
    // MARK: - Private properties
    
    lazy private var mainView = SubscriptionView(delegate: self)
    // Month subscription model
    private lazy var monthSubscriptionModel: SubscriptionModel? = {
        let subscriptionID = StoreKitConstants.Subscription.month.identifier
        guard let monthSubscription = StoreKitDataManager.shared.getSubscriptionModel(for: subscriptionID)
        else { return nil }
        
        return monthSubscription
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.subscriptionModel = monthSubscriptionModel
    }
    
    // MARK: - Private methods
    
    private func purchaseSubscription() {
        guard let monthSubscription = monthSubscriptionModel else { return }
        
        buySubscription(id: monthSubscription.id) { [weak self] isSuccess in
            if isSuccess {
                self?.closeScreen()
            }
        }
    }
    
    private func closeScreen() {
        dismiss(animated: true)
    }
}

// MARK: - MainView Delegate

extension SubscriptionViewController: SubscriptionViewDelegate {
    func restoreButtonDidTap() {
        restoreAction { [weak self] success in
            guard let self = self, success else { return }
            self.showAlert(alertText: "Purchase successfully restored")
        }
    }
    
    func closeButtonDidTap() {
        dismiss(animated: true)
    }
    
    func selectButtonDidTap() {
        purchaseSubscription()
    }
    
    func termsButtonDidTap() {
        showTermsPrivacyScreen()
    }
    
    func privacyButtonDidTap() {
        showTermsPrivacyScreen()
    }
    
    private func showTermsPrivacyScreen() {
        let text = Constants.Texts.termsAndPrivacy
        let infoScreenVC = InfoScreenViewController(text: text)
        present(infoScreenVC, animated: true)
    }
}
