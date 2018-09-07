//
//  FileListController.swift
//  project 1
//
//  Created by admin on 8/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

protocol FileListControllerDelegate {
    func deleteFileDirObject(indexPath: IndexPath)
    func editFileDirObject(indexPath: IndexPath, name: String, fileURL: URL)
    func addFileDirObject(name: String, isFolder: Bool, fileURL: URL)
}

class FileListController: UITableViewController, FileListControllerDelegate {
    var fileDirObjects = [FileDirObjectStruct]()  //Array for TableView IndexPath
    private var navTitleStr : String = "File System"
    private var navLeftBarButtonStr: String = ""
    private var ender = ""
    private let FMd = FileManager.default
    
    private func getFolderToSearch() -> URL {
        var dirPaths = FMd.urls(for: .documentDirectory, in: .userDomainMask)
        let myDocumentsDirectory = dirPaths[0] //.documents folder for the App
        let potentiallyCurrentDirectory = myDocumentsDirectory.appendingPathComponent(ender, isDirectory: true)
        return (ender == "") ? myDocumentsDirectory : potentiallyCurrentDirectory //ender is empty at root folder
    }
    
    
    private func setupTableView(){
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
            self.fileDirObjects.sort()
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK:- Expose Private Variables outside this file
    func updateNavTitle(title: String) {self.navTitleStr = title}
    
    
    //    func updateNavLeftBarButton(title: String) {self.navLeftBarButtonStr = title}
    func updateNavLeftBarButton(titleNeeded: Bool) {
        let customBackButton = getCustomizedBarButton(name: Constants.left_arrow.rawValue, target: self, action: #selector(handleNavLeftBarButton))
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    @objc func handleNavLeftBarButton(){
        navigationController?.popViewController(animated: true)
    }
    
    func updateEnder(path: String) {self.ender = path}
    
    
    //MARK:- Navigation Bar & Background
    private func setupNavigationController(){
        navigationItem.title = navTitleStr
        let customInfoButton = getCustomizedBarButton(name: Constants.info.rawValue, target: self, action: #selector(handleMatch))
        let customPlusButton = getCustomizedBarButton(name: Constants.plus.rawValue, target: self, action: #selector(handleCreate))
        navigationItem.rightBarButtonItems = [customInfoButton, customPlusButton]
    }

    @objc private func handleLeft(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleMatch(){
        present(ShowInformationController(), animated: true, completion: nil)
    }
    
    @objc private func handleCreate(){
        let newCreationController = CreationController()
        newCreationController.currentUNC = getFolderToSearch()
        newCreationController.delegate = self
        navigationController?.pushViewController(newCreationController, animated: true)
    }

    //MARK:- Override Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        view.backgroundColor = UIColor.mediumBlue
        tableView.register(FileListCell.self, forCellReuseIdentifier: Constants.TableID.rawValue)
        setupTableView()
    }
    
    //MARK:- EXTRAS
    //    var dirPaths = [URL]() <-- needed for below functions
    public func showDirectories(){
        var dirPaths = FMd.urls(for: .documentDirectory, in: .userDomainMask)
        let myDocumentsDirectory = dirPaths[0]
        print("myDocumentsDirectory --> \(myDocumentsDirectory.path)")
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
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    public func printCurrentPath(){print("Current Path = \(Bundle.main.resourcePath ?? "")")}
}
