//
//  BrowseController.swift
//  project 1
//
//  Created by admin on 9/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class BrowseController: UITableViewController {
    
    private var fileDirArray = [FileDirStruct]() //array that loads table
    private var parentFolder: FileDirStruct?

    //MARK:- override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        confirmParentFolder()
        loadTableView()
    }
    
    
    //MARK:- FileSystem functions
    private func loadTableView(){
        let fmD = FileManager.default
        do {
            let folderContents = try fmD.contentsOfDirectory(at: (parentFolder?.currentURL)!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            guard let guardParentFolder = parentFolder else {return}
            folderContents.forEach{fileDirArray.append(FileDirStruct(name: $0.lastPathComponent, isFolder: $0.hasDirectoryPath, parentDir: guardParentFolder))}
        } catch let loadingError {
            print("Failure on 'try' to load DocumentDirectory URLs: \(loadingError)")
        }
    }
    
    private func updateParentFolder(subFolderName: String = "<INVALID>")-> FileDirStruct {
        return parentFolder == nil ? FileDirStruct.createFirstParent() : FileDirStruct(name: subFolderName, isFolder: true, parentDir: parentFolder!)
    }
    
    private func confirmParentFolder(){
        if parentFolder == nil {
            parentFolder = FileDirStruct.createFirstParent()
        }
    }
    
    
    //MARK:- TableView Functions
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
        print("Clicked on --> \(fileDirArray[indexPath.row].name)")
        print("Current URL --> \(fileDirArray[indexPath.row].currentURL)\n")
        if fileDirArray[indexPath.row].isFolder {
            let newBrowseController = BrowseController()
            newBrowseController.parentFolder = updateParentFolder(subFolderName: fileDirArray[indexPath.row].name)
            navigationController?.pushViewController(newBrowseController, animated: true)
        } else {
            let newShowImageController = ShowImageController()
            newShowImageController.fileImageView.image = UIImage(named: Constants.background2.rawValue)
            present(newShowImageController, animated: false)
        }
    }
}
