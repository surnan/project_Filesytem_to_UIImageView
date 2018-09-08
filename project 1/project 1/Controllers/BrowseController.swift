//
//  BrowseController.swift
//  project 1
//
//  Created by admin on 9/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreText


class BrowseController: UITableViewController{
    var fileDirArray = [FileDirStruct]() //array that loads table
    var parentFolder: FileDirStruct?

    //MARK:- override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.veryLightGrey
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
    
    func updateParentFolder(subFolderName: String = "<INVALID>")-> FileDirStruct {
        return parentFolder == nil ? FileDirStruct.createFirstParent() : FileDirStruct(name: subFolderName, isFolder: true, parentDir: parentFolder!)
    }
    
    private func confirmParentFolder(){
        if parentFolder == nil {
            parentFolder = FileDirStruct.createFirstParent()
        }
    }
}
