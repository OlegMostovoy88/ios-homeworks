//
//  Photo.swift
//  Navigation
//
//  Created by Олег Мостовой on 18.03.2023.
//

import Foundation

struct Photo {
    let id: Int
    let imageName: String
}

struct SectionPhoto {
    let sectionName: String
    var photos: [Photo]
}

struct Source {
    
    static func makePhoto() -> [Photo] {
        [
            .init(id: 1, imageName: "2"),
            .init(id: 1, imageName: "3"),
            .init(id: 1, imageName: "4"),
            .init(id: 1, imageName: "5"),
            .init(id: 1, imageName: "6"),
            .init(id: 1, imageName: "7"),
            .init(id: 1, imageName: "8"),
            .init(id: 1, imageName: "9"),
            .init(id: 1, imageName: "10"),
            .init(id: 1, imageName: "11"),
            .init(id: 1, imageName: "12"),
            .init(id: 1, imageName: "13"),
            .init(id: 1, imageName: "14"),
            .init(id: 1, imageName: "15"),
            .init(id: 1, imageName: "16"),
            .init(id: 1, imageName: "17"),
            .init(id: 1, imageName: "18"),
            .init(id: 1, imageName: "18"),
            .init(id: 1, imageName: "19"),
            .init(id: 1, imageName: "20"),
        ]
    }
}
