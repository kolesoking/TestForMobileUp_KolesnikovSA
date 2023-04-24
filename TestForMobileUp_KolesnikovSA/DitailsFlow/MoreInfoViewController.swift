//
//  MoreInfoViewController.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 24.04.2023.
//

import UIKit

class MoreInfoViewController: UIViewController {
    
    // MARK: - Views
    
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Properties
    
    var creationDate = 0 {
        didSet {
            self.navigationItem.title = getDateFromUnixTime(unixTime: creationDate)
        }
    }
    
    var imageURLString = "" {
        didSet {
            guard let url = URL(string: imageURLString) else {
                return
            }
            mainImage.loadImage(from: url)
        }
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

}

// MARK: - PrivateMethods

private extension MoreInfoViewController {
    func configureAppearance() {
        setConstreints()
        configureNavBar()
        view.backgroundColor = .white
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    func getDateFromUnixTime(unixTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixTime))
        let utcDateFormatter = DateFormatter()
//        utcDateFormatter.dateStyle = .medium
//        utcDateFormatter.timeStyle = .none
        utcDateFormatter.dateFormat = "d MMMM yyyy"
        
        return utcDateFormatter.string(from: date as Date)
    }
    
    func setConstreints() {
        view.addSubview(mainImage)
        NSLayoutConstraint.activate([
            mainImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: view.bounds.width),
            mainImage.heightAnchor.constraint(equalToConstant: view.bounds.width)
        ])
    }
}
