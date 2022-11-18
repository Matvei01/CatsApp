//
//  CatsDetailViewController.swift
//  CatsApp
//
//  Created by Matvei Khlestov on 17.11.2022.
//

import UIKit

class CatsDetailViewController: UIViewController {
    
    @IBOutlet weak var catDetailImage: UIImageView! 
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
     var cat: Cat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        
        view.backgroundColor = .secondarySystemBackground
        
        title = cat.name
        
        descriptionLabel.text = cat.fullInformation
        
        fetchImage()
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: cat.image?.url ?? "") { result in
            switch result {
                
            case .success(let imageData):
                self.catDetailImage.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
