//
//  Cell.swift
//  15 Homework
//
//  Created by Владимир Бурлинов on 09.08.2022.
//

import UIKit
import SnapKit


class CustomCell: UITableViewCell {
    
    static let identifier = "customCell"
    
    let activityIndicator = UIActivityIndicatorView()
    
    private lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieDescription: UILabel = {
        let label = UILabel()
        label.text = "test2"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(movieLabel)
        contentView.addSubview(movieDescription)
        contentView.addSubview(movieImage)
        contentView.addSubview(activityIndicator)
                
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
               self.movieLabel.snp.makeConstraints { make in
                    make.left.equalTo(movieImage).inset(60)
                    make.top.equalToSuperview().inset(0)
                    make.bottom.equalToSuperview().inset(76)
                }
       
               self.movieImage.snp.makeConstraints { make in
                   make.height.equalTo(75)
                   make.width.equalTo(56)
                   make.left.equalToSuperview().inset(14)
                   make.top.equalToSuperview().inset(10)
               }
       
               self.movieDescription.snp.makeConstraints { make in
                   make.height.equalToSuperview()
                   make.width.equalToSuperview().inset(40)
                   make.top.equalTo(movieLabel).inset(13)
                   make.left.equalTo(movieImage).inset(59)
               }
            
                self.activityIndicator.snp.makeConstraints { make in
                    make.center.equalTo(self.movieImage)
                }
    }
    
    func configure(with model: Film) {
        self.movieLabel.text = model.nameRu
        self.movieDescription.text = model.description
        
        self.activityIndicator.startAnimating()

        DispatchQueue.global(qos: .background).async {
        
            let url = model.posterURL
            if let data = try? Data(contentsOf: URL(string: url)!) {
              
                DispatchQueue.main.async {
                    self.movieImage.image = UIImage(data: data)
                    self.activityIndicator.stopAnimating()
                }
            }
            }
    }
}
