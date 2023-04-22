//
//  AuthViewController.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 22.04.2023.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let urlString = "https://www.google.com/"
    }
    
    // MARK: - Views
    
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    // MARK: - UIView Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureAppearance()
    }
}

// MARK: - PrivateMethods

private extension AuthViewController {
    
    func configureAppearance() {
        setConstraints()
        loadRequest()
    }
    
    func setConstraints() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func loadRequest() {
        guard let url = URL(string: Constants.urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
    }
    
}
