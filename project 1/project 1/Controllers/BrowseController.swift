//
//  BrowseController.swift
//  project 1
//
//  Created by admin on 9/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class BrowseController: UITableViewController {
    
    var fileDirArray = [FileDirStruct]()
    var parentFolder: FileDirStruct?
    
    private func loadTableView(){
        let fmD = FileManager.default
        let allURL = fmD.urls(for: .documentDirectory, in: .userDomainMask)
        do {
            let folderContents = try fmD.contentsOfDirectory(at: allURL.first!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            folderContents.forEach{fileDirArray.append(FileDirStruct(name: $0.lastPathComponent, isFolder: $0.hasDirectoryPath, parentDir: nil))}
        } catch let loadingError {
            print("Unable to load TableView \(loadingError)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        loadTableView()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileDirArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = fileDirArray[indexPath.row].name
        cell.backgroundColor = fileDirArray[indexPath.row].isFolder ? UIColor.lightBlue : UIColor.lightBrown
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fileDirArray[indexPath.row].isFolder {
            let newBrowseController = BrowseController()
            navigationController?.pushViewController(newBrowseController, animated: true)
        } else {
            let newShowImageController = ShowImageController()
            newShowImageController.fileImageView.image = UIImage(named: Constants.background2.rawValue)
            present(newShowImageController, animated: false)
        }
    }
}
