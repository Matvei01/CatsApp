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
    let lifeSpan: String?
    let weight: Weight?
    let image: Image?
    
    init(catData: [String: Any]) {
        name = catData["name"] as? String
        temperament = catData["temperament"] as? String
        origin = catData["origin"] as? String
        lifeSpan = catData["life_span"] as? String
        let weightDictionary = catData["weight"] as? [String: Any] ?? [:]
        weight = Weight(catData: weightDictionary)
        let imageDictionary = catData["image"] as? [String: Any] ?? [:]
        image = Image(catData: imageDictionary)
        
    }
    
    static func getCats(from value: Any) -> [Cat] {
        guard let catsData = value as? [[String: Any]] else { return [] }
        var cats: [Cat] = []
        for catData in catsData {
            let cat = Cat(catData: catData)
            cats.append(cat)
        }
        return cats
    }
    
    var fullInformation: String {
        """
    Name: \(name ?? "")
    Weight:
    - imperial: \(weight?.imperial ?? "")
    - metric: \(weight?.metric ?? "")
    Temperament: \(temperament ?? "")
    Origin: \(origin ?? "")
    Life span: \(lifeSpan ?? "")
    """
    }
}

struct Weight: Decodable {
    let imperial: String?
    let metric: String?
    
    init(catData: [String: Any]) {
        imperial = catData["imperial"] as? String
        metric = catData["metric"] as? String
    }
}

struct Image: Decodable {
    let url: String?
    
    init(catData: [String: Any]) {
        url = catData["url"] as? String
    }
}
