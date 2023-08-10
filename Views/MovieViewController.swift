//
//  MovieViewController.swift
//  
//
//  Created by Владимир Бурлинов on 11.04.2023.
//

import UIKit
import SnapKit

struct CellWithImageAndTitleViewModel {
    
   // let title: String
    let image: UIImage
    
}

class MovieViewController: UIViewController {
    
    let indicator = UIActivityIndicatorView()
    let image1 = [Result1]()
    var img: Welcome?
 
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 500, y: 500, width: 300, height: 300))
        image.center = view.center
        //image.image = UIImage(systemName: "smoke")
        return image
    }()
    
    lazy var labelName: UILabel = {
        let label = UILabel()
        //label.text = img?.title
        label.textAlignment = .center
        return label
    }()
    
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        //label.text = img?.resultDescription

        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(indicator)
        indicator.center = view.center
       // indicator.startAnimating()
        //setupImage()
        setupConstraints()
        //labelName.text = img?.results[indexPath].title
//        labelTitle.text = img?.results[].resultDescription
    }
    
    func configure1(with model: Result1) {
        self.labelName.text = model.title
        self.labelTitle.text = model.resultDescription
    }
    
    private func setupConstraints() {
        view.addSubview(labelName)
        view.addSubview(labelTitle)
        self.labelName.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.topMargin.equalTo(imageView.snp_bottomMargin).inset(-20)
        }
        
        self.labelTitle.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.topMargin.equalTo(labelName.snp_bottomMargin).inset(-20)
        }
    }
    
    func configure(_ viewModel: Result1) {
        //        labelTitle.text = viewModel.title
        //        image.image = viewModel.image
        imageView.image = UIImage(contentsOfFile: viewModel.image)
    }
    
    
//    private func setupImage() {
//
//        let image = UIImageView(frame: CGRect(x: view.center.x, y: view.center.y, width: 300, height: 300))
//        self.view.addSubview(image)
//        image.backgroundColor = .green
////        DispatchQueue.main.async {
////            image.image = UIImage(contentsOfFile: (self.img?.image)!)
////        }
//
//
//    }
}
