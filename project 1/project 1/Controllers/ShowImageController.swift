//
//  ShowImageController.swift
//  project 1
//
//  Created by admin on 8/26/18.
//  Copyright © 2018 admin. All rights reserved.
//


import UIKit

class ShowImageController:UIViewController {
    
    var currentImage: UIImage?  {
        didSet {
            fileImageView.image = currentImage!
        }
    }
    
    lazy var fileImageView: UIImageView = {
        let imageView = UIImageView()
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
        navigationController?.setNavigationBarHidden(true, animated: false)

        
        fileImageView.image = currentImage!
        
        [fileImageView].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            fileImageView.topAnchor.constraint(equalTo: view.topAnchor),
            fileImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            fileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
