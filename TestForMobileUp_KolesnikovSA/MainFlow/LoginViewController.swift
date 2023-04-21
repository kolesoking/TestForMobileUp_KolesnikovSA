//
//  LoginViewController.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 20.04.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        
        // titleLabel
        
        static let titleLabelText = "Mobile Up \nGalery"
        static let titleLabelTextColor: UIColor = .black
        static let titleLabelFontSize: CGFloat = 44
        
        static let titleLabelLeftAnchor: CGFloat = 24
        static let titleLabelRightAnchor: CGFloat = -24
        static let titleLabelTopAnchor: CGFloat = 170
        
        // signInButton
        
        static let signInButtonBackgroundColor: UIColor = .black
        static let signInButtonTitleText = "Вход через VK"
        static let signINButtonFontSize: CGFloat = 15
        static let signInButtonCornerRadius: CGFloat = 12
        
        static let signInButtonLeftAnchor: CGFloat = 16
        static let signinButtonRightAnchor: CGFloat = -16
        static let signInButtonBottomAnchor: CGFloat = -42
        static let signInButtonHeightAnchor: CGFloat = 52
    }
    
    // MARK: - Views
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleLabelText
        label.textColor = Constants.titleLabelTextColor
        label.font = .systemFont(ofSize: Constants.titleLabelFontSize, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.signInButtonBackgroundColor
        button.setTitle(Constants.signInButtonTitleText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.signINButtonFontSize, weight: .medium)
        button.layer.cornerRadius = Constants.signInButtonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureAppearance()
    }
}

// MARK: - PrivateMethods

private extension LoginViewController {
    
    func configureAppearance() {
        setConstreints()
    }
    
    func setConstreints() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.titleLabelLeftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.titleLabelRightAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.titleLabelTopAnchor)
        ])
        
        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.signInButtonLeftAnchor),
            signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.signinButtonRightAnchor),
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.signInButtonBottomAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: Constants.signInButtonHeightAnchor)
        ])
    }
}
