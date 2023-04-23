//
//  GalleryCollectionViewCell.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 23.04.2023.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views

    @IBOutlet weak var mainImage: UIImageView!
    
    // MARK: - Properties
    
    var imageURLString: String = "" {
        didSet {
            guard let url = URL(string: imageURLString) else {
                return
            }
            mainImage.loadImage(from: url)
        }
    }
    
    // MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

// MARK: - PrivateMethods

private extension GalleryCollectionViewCell {
    func configureAppearance() {
        mainImage.contentMode = .scaleAspectFill
        backgroundColor = .lightGray
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
