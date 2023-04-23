//
//  ImageLoader.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 24.04.2023.
//

import Foundation
import UIKit

struct ImageLoader {

    let session = URLSession(configuration: .default)

    func loadImage(from url: URL, _ onLoadWasCompleted: @escaping (_ result: Result<UIImage, Error>) -> Void) {
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                onLoadWasCompleted(.failure(error))
            }
            if let data = data, let image = UIImage(data: data) {
                onLoadWasCompleted(.success(image))
            }
        }
        .resume()
    }

}
