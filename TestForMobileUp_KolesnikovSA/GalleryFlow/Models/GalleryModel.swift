//
//  GalleryModel.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 23.04.2023.
//

import Foundation

struct GalleryModel: Decodable {
    var response: Photos
    
    static func getGallery() -> GalleryModel {
        let sizes: [Size] = [
            .init(height: 1, type: "1", width: 1, url: "1")
        ]
        let photo: [Photo] = [
            .init(date: 1, sizes: sizes),
            .init(date: 2, sizes: sizes)
        ]
        let photos = Photos(items: photo)
        return GalleryModel(response: photos)
    }
}

struct Photos: Decodable {
    var items: [Photo]
}

struct Photo: Decodable {
    var date: Int
    var sizes: [Size]
}

struct Size: Decodable {
    var height: Int
    var type: String
    var width: Int
    var url: String
}
