//
//  CatTableViewCell.swift
//  CatsApp
//
//  Created by Matvei Khlestov on 17.11.2022.
//

import UIKit

class CatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with cat: Cat) {
        nameLabel.font = UIFont(name: "Noto Sans Myanmar", size: 20)
        nameLabel.text = cat.name
        
        catImage.layer.cornerRadius = catImage.frame.width / 2
        NetworkManager.shared.fetchImage(from: cat.image?.url ?? "") { result in
            switch result {
            case .success(let imageData):
                self.catImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
