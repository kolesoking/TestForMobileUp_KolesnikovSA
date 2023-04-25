//
//  MoreInfoViewController.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 24.04.2023.
//

import UIKit

class MoreInfoViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let systemNameShareButton = "square.and.arrow.up"
        
        static let dateFormat = "d MMMM yyyy"
    }
    
    // MARK: - Views
    
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.semanticContentAttribute = .playback
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
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: Constants.systemNameShareButton), style: .plain, target: self, action: #selector(shareButtonPressed))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc func shareButtonPressed() {
        let items: [Any] = [mainImage.image as Any]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(avc, animated: true)
        
    }
    
    func getDateFromUnixTime(unixTime: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixTime))
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = Constants.dateFormat
        
        return utcDateFormatter.string(from: date as Date)
    }
    

    
    func setConstreints() {
        view.addSubview(mainImage)
        NSLayoutConstraint.activate([
            mainImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
            mainImage.heightAnchor.constraint(equalToConstant: self.view.bounds.width)
        ])
    }
}
