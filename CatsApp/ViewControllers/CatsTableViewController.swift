//
//  CatsTableViewController.swift
//  CatsApp
//
//  Created by Matvei Khlestov on 17.11.2022.
//

import UIKit
import Alamofire

class CatsTableViewController: UITableViewController {
    
    var cats: [Cat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 102
        
        fetchCatsWithAlamofire()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        cats.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell",
                                                 for: indexPath) as! CatTableViewCell
        
        let cat = cats[indexPath.row]
        cell.backgroundColor = .secondarySystemBackground
        cell.configure(with: cat)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let catsDetailVC = segue.destination as? CatsDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let cat = cats[indexPath.row]
        catsDetailVC.cat = cat
    }
}

// MARK: - Networking
extension CatsTableViewController {
    func fetchCatsWithAlamofire() {
        AF.request(Link.url.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    self.cats = Cat.getCats(from: value)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}

