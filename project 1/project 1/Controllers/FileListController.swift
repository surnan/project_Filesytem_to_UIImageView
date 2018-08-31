//
//  FileListController.swift
//  project 1
//
//  Created by admin on 8/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class FileListController: UITableViewController {
    
    var fileDirObjects = [FileDirObjectStruct]()  //Array for TableView IndexPath
    let databaseID = "databaseID"
    var navTitleStr : String = "File System"
    var navLeftBarButtonStr: String = ""
    var ender = ""
    
    fileprivate func getFolderToSearch() -> URL {
        let fm = FileManager.default
        var dirPaths = fm.urls(for: .documentDirectory, in: .userDomainMask)
        let myDocumentsDirectory = dirPaths[0]
        let potentiallyCurrentDirectory = myDocumentsDirectory.appendingPathComponent(ender, isDirectory: true)
        return (ender == "") ? myDocumentsDirectory : potentiallyCurrentDirectory
    }
    
    fileprivate func setupTableView(){
        let currentFolder = getFolderToSearch()
        var directoryContents = [URL]()
        do {
            directoryContents = try FileManager.default.contentsOfDirectory(at: currentFolder, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            let subdirs = directoryContents.filter{ $0.hasDirectoryPath }
            let subdirNamesStr = subdirs.map{ $0.lastPathComponent }
            let onlyFileNames = directoryContents.filter{ !$0.hasDirectoryPath }
            let onlyFileNamesStr = onlyFileNames.map { $0.lastPathComponent }
            print(subdirNamesStr); print(onlyFileNamesStr)
            directoryContents.forEach{

                self.fileDirObjects.append(FileDirObjectStruct(name: $0.lastPathComponent, isFolder: $0.hasDirectoryPath, url: $0.absoluteURL))
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK:- Navigation Bar
    fileprivate func setupNavigationController(){
        navigationItem.title = navTitleStr
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: navLeftBarButtonStr, style: .plain, target: self, action: #selector(handleLeft))
        let myInfoButton = getCustomizedBarButton(name: "info_icon", action: #selector(handleMatch))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Folder", style: .done, target: self, action: #selector(handleFolder)),
                                              myInfoButton]
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    fileprivate func getCustomizedBarButton(name: String, action: Selector) -> UIBarButtonItem {
        let infoButton = UIButton(type: .custom)
        infoButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        infoButton.setImage(UIImage(named: name), for: .normal)
        infoButton.addTarget(self, action: action, for: .touchUpInside)
        let menuBarButtonItem = UIBarButtonItem(customView: infoButton)
        menuBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return menuBarButtonItem
    }
    
    @objc fileprivate func handleLeft(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func handleMatch(){
        print("Match button pressed")
        present(ShowInformationController(), animated: true, completion: nil)
    }
    
    @objc fileprivate func handleFolder(){
        print("Folder button pressed")
        present(ShowInformationController(), animated: true, completion: nil)
    }
    
    
    
    //MARK:- Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        printCurrentPath()
        setupNavigationController()
        view.backgroundColor = UIColor.lightBlue
        tableView.register(FileListCellController.self, forCellReuseIdentifier: databaseID)
        setupTableView()
//        showDirectories()


    }
    
    
    
    
    //MARK:- EXTRAS
    //    var dirPaths = [URL]() <-- needed for below functions
    fileprivate func showDirectories(){
        let filemgr = FileManager.default
        var dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)
        let myDocumentsDirectory = dirPaths[0]
        let newDocumentsDirectory = myDocumentsDirectory.appendingPathComponent(ender, isDirectory: true)
        var directoryContents = [URL]()
        let firstTerm = (ender == "") ? myDocumentsDirectory : newDocumentsDirectory
        do {
            directoryContents = try FileManager.default.contentsOfDirectory(at: firstTerm, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            let onlyFileNames = directoryContents.filter{ !$0.hasDirectoryPath }
            let onlyFileNamesStr = onlyFileNames.map { $0.lastPathComponent }
            let subdirs = directoryContents.filter{ $0.hasDirectoryPath }
            let subdirNamesStr = subdirs.map{ $0.lastPathComponent }
            print("ALL FILE NAMES --> \(onlyFileNamesStr)")
            print("ALL DIRECTORY NAMES --> \(subdirNamesStr)")
            // now do whatever with the onlyFileNamesStr & subdirNamesStr
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    fileprivate func printCurrentPath(){
        print("Current Path = \(Bundle.main.resourcePath ?? "")")
    }
    
}

