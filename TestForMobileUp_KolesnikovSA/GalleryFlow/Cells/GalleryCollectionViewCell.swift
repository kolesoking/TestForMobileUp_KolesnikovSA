//
//  GalleryCollectionViewCell.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 23.04.2023.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    
    var titleLabel = "" {
        didSet {
            mainLabel.text = titleLabel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

private extension GalleryCollectionViewCell {
    func configureAppearance() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
