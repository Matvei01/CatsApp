//
//  NetworkManager.swift
//  CatsApp
//
//  Created by Matvei Khlestov on 17.11.2022.
//

import Foundation

enum Link: String {
    case url = "https://api.thecatapi.com/v1/breeds?limit=50"
}

enum typeError: Error {
    case errorURL
    case errorData
    case errorDecoder
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchCats(from url: String, complition: @escaping(Result<[Cat],
                                                           typeError>) -> Void) {
        guard let url = URL(string: Link.url.rawValue) else {
            complition(.failure(.errorURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                complition(.failure(.errorData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let cats = try JSONDecoder().decode([Cat].self, from: data)
                DispatchQueue.main.async {
                    complition(.success(cats))
                }
            } catch let error {
                complition(.failure(.errorDecoder))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImage(from url: String, complition: @escaping(Result<Data,
                                                            typeError>) -> Void) {
        DispatchQueue.global().async {
            guard let url = URL(string: url) else {
                complition(.failure(.errorURL))
                return
            }
            
            guard let imageData = try? Data(contentsOf: url) else {
                complition(.failure(.errorData))
                return
            }
            
            DispatchQueue.main.async {
                complition(.success(imageData))
            }
        }
    }

    private init() {}
}

