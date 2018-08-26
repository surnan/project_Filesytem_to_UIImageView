//
//  ViewController.swift
//  project 1
//
//  Created by admin on 8/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class FileListController: UITableViewController {
    
    var pictures = [String]()
    let databaseID = "adsfasdf"

    
    
    private func loadPicturesWithFileStrings(){
        let localFileManager = FileManager.default
        guard let path = Bundle.main.resourcePath else {return}
        
        do {
            let files = try localFileManager.contentsOfDirectory(atPath: path)
            
            for file in files {
                if file.hasPrefix("nssl"){
                    pictures.append(file)
                }
            }
        } catch let contentsErr {
            print("Unable to get contentsOfDirectory : \(contentsErr)")
        }
     print(pictures)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        view.backgroundColor = UIColor.lightBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: databaseID)
        loadPicturesWithFileStrings()
    }
    
    private func setupNavigationController(){
        navigationItem.title = "Filesystem Images   "
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(handleInfo))
        let myInfoButton = getCustomizedBarButton(name: "info_icon", action: #selector(handleMatch))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Folder", style: .done, target: self, action: #selector(handleFolder)),
                                              myInfoButton]
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    private func getCustomizedBarButton(name: String, action: Selector) -> UIBarButtonItem {
        let infoButton = UIButton(type: .custom)
        infoButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        infoButton.setImage(UIImage(named: name), for: .normal)
        infoButton.addTarget(self, action: action, for: .touchUpInside)
        let menuBarButtonItem = UIBarButtonItem(customView: infoButton)
        menuBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return menuBarButtonItem
    }
    
    
    @objc private func handleInfo(){
        print("Info button pressed")
        present(ShowInformationController(), animated: true, completion: nil)
    }

    @objc private func handleMatch(){
        print("Match button pressed")
        present(ShowInformationController(), animated: true, completion: nil)
    }
    
    @objc private func handleFolder(){
        print("Folder button pressed")
        present(ShowInformationController(), animated: true, completion: nil)
    }
}

