//
//  ShowImageController.swift
//  project 1
//
//  Created by admin on 8/26/18.
//  Copyright © 2018 admin. All rights reserved.
//


import UIKit

class ShowImageController:UIViewController {
    //Both lazy var UIImageViews because we need them to be ".isUserEnabled"
    lazy var fileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapFileImage))
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapGesture)
        imageView.addGestureRecognizer(doubleTapGesture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var escapeView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    
    @objc private func handleTapFileImage(){
        print("Executing Single Tap")
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = fileImageView.bounds
        escapeView.frame = fileImageView.bounds
        modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.fileImageView.addSubview(blurEffectView)
        self.view.addSubview(blurEffectView)
        self.view.addSubview(escapeView)
    }
    
    @objc private func handleDoubleTap(){
        print("Executing Double Tap")
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        definesPresentationContext = true
        [fileImageView].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            fileImageView.topAnchor.constraint(equalTo: view.topAnchor),
            fileImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            fileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
