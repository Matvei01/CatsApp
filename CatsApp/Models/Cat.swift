//
//  Cat.swift
//  CatsApp
//
//  Created by Matvei Khlestov on 17.11.2022.
//

import Foundation

struct Cat: Decodable {
    
    let name: String?
    let temperament: String?
    let origin: String?
    let life_span: String?
    let weight: Weight?
    let image: Image?
    
    var fullInformation: String {
        """
    Name: \(name ?? "")
    Weight:
    - imperial: \(weight?.imperial ?? "")
    - metric: \(weight?.metric ?? "")
    Temperament: \(temperament ?? "")
    Origin: \(origin ?? "")
    Life span: \(life_span ?? "")
    """
    }
}

struct Weight: Decodable {
    let imperial: String?
    let metric: String?
}

struct Image: Decodable {
    let url: String?
}
