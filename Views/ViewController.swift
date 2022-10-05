//
//  ViewController.swift
//  M18homework
//
//  Created by Владимир Бурлинов on 11.09.2022.
//

import UIKit
import SnapKit

class ViewControllerMain: UIViewController {
    
    var movies1 = [Result1]()
    
    let networkDataFetcher = NetworkDataFetcher()
    
    var searchResponse: Welcome? = nil
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let identifier = "cell"
  
    private var timer: Timer?
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.separatorColor = .gray
        table.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        return table
    }()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Searh"
        
        table.dataSource = self
        table.delegate = self
        
        setupSearchBar()
        setupView()
        setupConstraints()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    private func setupView() {
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        
        table.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}



//MARK: - extension TableView

extension ViewControllerMain: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        
        cell.configure(with: movies1[indexPath.row])
        
        return cell
    }
}



//MARK: -  extension SearchController
extension ViewControllerMain: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let urlString = "https://imdb-api.com/API/Search/k_a11p9jp6/\(searchText)"//Avatar""https://imdb-api.com/swagger/index.html"
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchData(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                
                self.searchResponse = searchResponse
                self.movies1.append(contentsOf: searchResponse.results)
                
                self.table.reloadData()
            }
        })
    }
}
