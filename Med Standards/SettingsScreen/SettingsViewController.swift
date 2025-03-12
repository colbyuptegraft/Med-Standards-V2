//
//  SettingsViewController.swift
//  Med Standards
//
//  Created by Oleksandr on 11.02.2025.
//  Copyright © 2025 ColbyCoApps. All rights reserved.
//

import MessageUI
import NVActivityIndicatorView
import UIKit

final class SettingsVC: UIViewController, SubscriptionScreen {
    
    // MARK: - Private properties
    
    private var modelItems: [Setting]
    private let listStackView: UIStackView = .init()
    private let appVersionLabel: UILabel = .init()
    private let storeKitStorage: StoreKitStorage = LocalStorage.shared
    
    // MARK: - Initialisers
    
    init(models: [Setting] = SettingsItem.getAllItems()) {
        self.modelItems = models
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        checkIfUserSubscribed()
    }
}

// MARK: - Private methods

private extension SettingsVC {
    func setupNavigationBar() {
        navigationItem.title = "Settings"
        
        if #available(iOS 13.0, *) {
            let navBarappearance = UINavigationBarAppearance()
            navBarappearance.configureWithOpaqueBackground()
            navBarappearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: global.navBarItemColor]
            navBarappearance.backgroundColor = global.aboutColor
            
            self.navigationController?.navigationBar.standardAppearance = navBarappearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarappearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = global.aboutColor
        
            self.tabBarController?.tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                self.tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
            } else {
                // Fallback on earlier versions
            }
        } else {
            self.navigationController?.navigationBar.backgroundColor = global.aboutColor
            self.tabBarController?.tabBar.backgroundColor = global.aboutColor
        }
    }
    
    func setupUI() {
        view.backgroundColor = .white
        listStackView.axis = .vertical
        listStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listStackView)
        
        NSLayoutConstraint.activate([
            listStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.fitH),
            listStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.fitW),
            listStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.fitW)
        ])
        
        setupListView()
        setupAppVersion()
    }
    
    func setupListView() {
        modelItems.enumerated().forEach { index, model in
            let itemView = SettingsItemView()
            itemView.configure(title: model.title, icon: model.image)
            if SettingsItem(rawValue: index) == .privacyPolicy || SettingsItem(rawValue: index) == .about {
                itemView.canGoForward(true)
            } else {
                itemView.canGoForward(false)
            }
            itemView.onTap = { [weak self] in
                guard let self else { return }
                handleItemTap(at: index)
            }
            
            if index == modelItems.count - 1 {
                itemView.changeLastItem()
            }
            
            listStackView.addArrangedSubview(itemView)
        }
    }
    
    func setupAppVersion() {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersionLabel.textColor = .black.withAlphaComponent(0.75)
            appVersionLabel.font = .systemFont(ofSize: 16)
            appVersionLabel.text = "App version " + appVersion
            appVersionLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(appVersionLabel)
            
            NSLayoutConstraint.activate([
                appVersionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                appVersionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10.fitH)
            ])
        }
    }
    
    func handleItemTap(at index: Int) {
        switch SettingsItem(rawValue: index) {
        case .getPremium:
            presentSubscriptionScreen()
        case .restorePurchase:
            restorePurchase()
        case .rateApp:
            AppRateManager.requestRate()
        case .support:
            showSupport()
        case .shareApp:
            presentShareScreen()
        case .privacyPolicy:
            let text = Constants.Texts.termsAndPrivacy
            let infoScreenVC = InfoScreenViewController(text: text)
            navigationController?.pushViewController(infoScreenVC, animated: true)
        case .about:
            let aboutVC = AboutViewContoller.instantiateFromStoryboard(storyboardName: "Main", identifier: "AboutVCID")
            navigationController?.pushViewController(aboutVC, animated: true)
        default:
            return
        }
    }
    
    func presentSubscriptionScreen() {
        let controller = SubscriptionViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    func restorePurchase() {
        restoreAction { success in
            if success {
                self.showAlert(alertText: "Purchase successfully restored!")
            } else {
                self.showAlert(alertText: "Purchase not restored",
                               alertMessage: "Nothing to Restore")
            }
        }
    }
    
    func showSupport() {
        let supportEmail = Constants.Urls.supportEmail
        let subject = "Med Standards app support"
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([supportEmail])
            mail.setSubject(subject)
            present(mail, animated: true, completion: nil)
        } else {
            if let mailURLString = "mailto:\(supportEmail)?subject=\(subject)".addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ),
               let mailURL = URL(string: mailURLString) {
                // check not needed, but if desired add mailto to LSApplicationQueriesSchemes in Info.plist
                if UIApplication.shared.canOpenURL(mailURL) {
                    view.window?.windowScene?.open(mailURL, options: nil, completionHandler: nil)
                } else {
                    let copyAction = UIAlertAction(title: "Copy email", style: .default) { _ in
                        UIPasteboard.general.string = Constants.Urls.supportEmail
                    }
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    showAlert(with: "Contact support",
                              message: "You can talk to us via email\ninfo@doc-apps.com",
                              actions: [copyAction, okAction]
                    )
                }
            }
        }
    }
    
    func checkIfUserSubscribed() {
        guard storeKitStorage.isBoughtSubscription else { return }
        
        listStackView.subviews.first?.isHidden = true
    }
}

// MARK: - Sharing controller

private extension SettingsVC {
    func presentShareScreen() {
        let text = "Try this Med Standards app!👍"
        let link = Constants.Urls.appLinkInAppStore
        let shareText = text + "\n" + link
        
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(vc, animated: true)
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension SettingsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        controller.dismiss(animated: true)
    }
}
