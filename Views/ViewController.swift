//
//  ViewController.swift
//  M18homework
//
//  Created by Владимир Бурлинов on 11.09.2022.
//

import UIKit
import SnapKit

class ViewControllerMain: UIViewController {
    
     let viewModel = FilmsViewModel()
    
    var isDataLoaded = false
    
    let networkDataFetcher = NetworkDataFetcher()
    let searchController = UISearchController(searchResultsController: nil)
          
    private var timer: Timer?
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.separatorColor = .gray
        table.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
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
//        viewModel.films.count
        if isDataLoaded {
            return viewModel.films.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        
        cell.configure(with: (viewModel.films[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieViewController()
        vc.indicator.startAnimating()
        guard let apiURL = URL(string: (viewModel.films[indexPath.row].posterURL)) else { return }
        
        vc.configure1(with: (viewModel.films[indexPath.row]))
        
        URLSession.shared.dataTask(with: apiURL) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                vc.imageView.image = UIImage(data: data)
                vc.indicator.stopAnimating()
            }
        }.resume()
             
        vc.title = viewModel.films[indexPath.row].nameEn
    
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -  extension SearchController
extension ViewControllerMain: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(searchText)"
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            self.isDataLoaded = true
            self.viewModel.fetchFilms(urlString: urlString) { (searchResponse) in
                DispatchQueue.main.async {
//                    self.table.reloadData()
                }
                guard let searchResponse = searchResponse else { return }
                self.viewModel.films.append(contentsOf: searchResponse.films)
                //self.table.reloadData()
                self.viewModel.delegate?.didUpdateFilms()
                
            }
//            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.table.reloadData()
        }
    }
}
