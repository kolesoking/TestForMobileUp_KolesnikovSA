//
//  GalleryViewController.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 23.04.2023.
//

import UIKit

class GalleryViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        
    }
    
    // MARK: - Properties
    

    
    // MARK: - Views
    
    
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    // MARK: - Methods
    
}

private extension GalleryViewController {
    
    func configureAppearance() {
        setConstraints()
        TokenManager.token = ""
        view.backgroundColor = .red
    }
    
    func setConstraints() {
        // TODO
    }
}
