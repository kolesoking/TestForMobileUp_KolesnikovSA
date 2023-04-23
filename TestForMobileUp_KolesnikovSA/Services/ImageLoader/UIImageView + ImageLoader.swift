//
//  UIImageView + ImageLoader.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 24.04.2023.
//

import UIKit

extension UIImageView {

    func loadImage(from url: URL) {
        ImageLoader().loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }

}
