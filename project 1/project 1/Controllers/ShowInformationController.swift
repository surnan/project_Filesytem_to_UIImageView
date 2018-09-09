//
//  ShowInformationController.swift
//  project 1
//
//  Created by admin on 8/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class ShowInformationController: UIViewController {
    
    private let explanationText: UITextView = {
       var txtView = UITextView()
        txtView.text = "Each Row corresponds to a file name.\n\n  Clicking on a row will load its corresponding UIImage.  If you slide row, there is an option to print out its full path to console or UIAlertController"
        txtView.font = UIFont.boldSystemFont(ofSize: 18)
        txtView.backgroundColor = UIColor.white
        txtView.isScrollEnabled = false  //Enabling this allows you to not specify height or bottom Anchor
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()
    
    private lazy var backButton: UIButton = {
       var button = UIButton()
        button.setTitle("BACK", for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchDown)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleShadowColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.lightOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    @objc private func handleBackButton(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightBlue
        [explanationText, backButton].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            explanationText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            explanationText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            explanationText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.topAnchor.constraint(equalTo: explanationText.bottomAnchor, constant: 30)
            ]
        )

        view.insertSubview(backgroundView, belowSubview: explanationText)
        backgroundView.topAnchor.constraint(equalTo: explanationText.topAnchor, constant: 5).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: explanationText.bottomAnchor, constant: 5).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: explanationText.leadingAnchor, constant: 5).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: explanationText.trailingAnchor, constant: 5).isActive = true
    }
}
