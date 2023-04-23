//
//  AuthViewController.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 22.04.2023.
//

import UIKit
import WebKit

final class AuthViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        
        // - UserDefaultsKeys
        
        static let tokenKey = "token"
        
        // - URLComponents
        
        static let rideredctUri = "https://oauth.vk.com/blank.html"
        static let clientID = "51622874"
        static let display = "mobile"
        static let responceType = "token"
        
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
        webView.navigationDelegate = self
        
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
    
    func makeURL() -> URL? {
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.clientID),
            URLQueryItem(name: "redirect_uri", value: Constants.rideredctUri),
            URLQueryItem(name: "display", value: Constants.display),
            URLQueryItem(name: "response_type", value: Constants.responceType)
        ]
        
        return urlComponents.url
    }
    
    func loadRequest() {
        guard let url = makeURL() else { return }
        webView.load(URLRequest(url: url))
    }
    
    func presentGalleryVC() {
        let galleryVC = GalleryViewController()
        let navController = UINavigationController(rootViewController: galleryVC)
        navController.modalPresentationStyle = .overFullScreen
        present(navController, animated: true)
    }
}

extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String: String]()) { res, param in
                var dict = res
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        
        if let token = params["access_token"] {
            
            TokenManager.token = token
            // TODO: - Убарть Print
            print("Token : \(token)")
        }
        
        // TODO: - Исправить баг с неоткрывающимся окном
        
        decisionHandler(.allow)
        self.dismiss(animated: true)
        presentGalleryVC()
    }
}
