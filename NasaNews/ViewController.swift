//
//  ViewController.swift
//  NasaNews
//
//  Created by Denisa Ionascu on 08.05.2022.
//

import UIKit

struct NasaNewsModel : Decodable{
    
    var items: [Item] = []
    
}

struct Item : Decodable{
    let id: Int
    let title: String
    let date: String
    let body: String
}

class ViewController: UIViewController {
    
    private var model = NasaNewsModel()
    private let pageSize: Int = 10
    private var page: Int = 0

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        requestItems()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loadItems(_ sender: Any) {

        page += 1
        requestItems()
    }
    
    private func requestItems(){
        let pathString = "https://mars.nasa.gov/api/v1/news_items/?page=\(page)&per_page=\(pageSize)&order=publish_date+desc,created_at+desc"
        let url = URL(string: pathString)!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error{
//                print("here::", error.localizedDescription)
                return
            }
            let jsonDecoder = JSONDecoder()
            guard let data = data else {
                return
            }

            guard let items = try? jsonDecoder.decode(NasaNewsModel.self, from: data) else {return}
            self?.model.items.append(contentsOf: items.items)
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
    //            print(items)
            }
          
            

        }
        
        task.resume()
    }
    
    private func requestNewItems(){
        page += 1
        requestItems()
        
    }

    private func configure(){
        
        title = "Nasa News"
        navigationController?.navigationBar.prefersLargeTitles = true 
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NasaNewsTableViewCell.self, forCellReuseIdentifier: NasaNewsTableViewCell.cellId)
    }
    private func navigate(item: Item){
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "ArtricleViewController")
                as? ArtricleViewController else {return}
//        viewController.textView?.text = item.body
        viewController.item = item
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NasaNewsTableViewCell.cellId, for: indexPath) as? NasaNewsTableViewCell else {return UITableViewCell() }
        
        let cellModel = model.items[indexPath.row]
        cell.setUp(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.items.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath ) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = model.items[indexPath.row]
        navigate(item: item)
    }
    
    func tableView(_tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let count = model.items.count - 1
        if indexPath.row == count {
            requestNewItems()
    
        
        }
    }
    

}


