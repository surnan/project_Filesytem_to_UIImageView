//
//  ShowImageController.swift
//  project 1
//
//  Created by admin on 8/26/18.
//  Copyright © 2018 admin. All rights reserved.
//


import UIKit

class ShowImageController:UIViewController {

    lazy var fileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "info_icon")
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapFileImage))
        imageView.addGestureRecognizer(tapGesture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    @objc private func handleTapFileImage(){
        print("Image tapped")
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [fileImage].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            fileImage.topAnchor.constraint(equalTo: view.topAnchor),
            fileImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            fileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
}
