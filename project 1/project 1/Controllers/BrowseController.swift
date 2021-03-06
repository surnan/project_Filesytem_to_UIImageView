//
//  BrowseController.swift
//  project 1
//
//  Created by admin on 9/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

protocol BrowseControllerDelegate {
    func createFileDirArrayElement(name: String, isFolder: Bool, parentDir: FileDirStruct)
}

class BrowseController: UITableViewController, BrowseControllerDelegate{
    var fileDirArray = [FileDirStruct]()    //TableView.Array
    var parentFolder: FileDirStruct?        //didSelectRowAt
    let fmD = FileManager.default
    private var showLeftBarButton = true
    
    //MARK:- manipulate tableView array
    func renameFileDirArrayElement(currentFileDir: FileDirStruct, newName: String, indexPath: IndexPath){
        if !renameInFileSystem(currentFileDir: currentFileDir, newName: newName) {
            print("Unable to make corresponding change in File System")
            return
        }
        let newArrayElement = FileDirStruct.change(from: currentFileDir, newName: newName)
        fileDirArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        fileDirArray.append(newArrayElement)
        fileDirArray.sort()
        guard let insertionIndex = fileDirArray.index(of: newArrayElement) else {return}
        tableView.insertRows(at: [IndexPath(row: insertionIndex, section: 0)], with: .right)
    }
    
    func deleteFileDirArrayElement(indexPath: IndexPath){
        if !deleteInFileSystem(currentFileDir: fileDirArray[indexPath.row]) {
            print("Unableto make corresponding change in File System")
            return
        }
        fileDirArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
    }
    
    //MARK:- FileSystem Functions
    private func renameInFileSystem(currentFileDir: FileDirStruct, newName: String)-> Bool{
        let newLocation = currentFileDir.currentURL.deletingLastPathComponent().appendingPathComponent(newName)
        do {
            try fmD.moveItem(at: currentFileDir.currentURL, to: newLocation)
            return true
        } catch let moveErr {
            print("Unable to move/rename object: \(moveErr)")
            return false
        }
    }
    
    private func deleteInFileSystem(currentFileDir: FileDirStruct) -> Bool{
        do {
            try fmD.removeItem(at: currentFileDir.currentURL)
            return true
        } catch let deletionErr {
            print("Unable to remove object: \(deletionErr)")
            return false
        }
    }
    
    //MARK:-NavigationBar
    private func setupNavigationBar(){
        navigationItem.title = "File Browser"
        let plusBarButtonFunc = getCustomizedBarButton(name: Constants.plus.rawValue, target: self, action: #selector(handlePlusBarButton))
        let infoBarButtonFunc = getCustomizedBarButton(name: Constants.info.rawValue, target: self, action: #selector(handleInfoBarButton))
        navigationItem.rightBarButtonItems = [infoBarButtonFunc, plusBarButtonFunc]
        let leftBarButtonItem = getCustomizedBarButton(name: Constants.left_arrow.rawValue, target: self, action: #selector(handleLeftArrowBarButton))
        navigationItem.leftBarButtonItem = showLeftBarButton ? leftBarButtonItem : nil
    }
    
    @objc private func handlePlusBarButton(){
        let newCreationController = CreationController()
        newCreationController.parentFolder = parentFolder
        newCreationController.delegate = self
        present(newCreationController, animated: true)
    }
    
    @objc private func handleInfoBarButton(){
        let blur = UIBlurEffect(style: .dark)
        let blurVisualEffectView = UIVisualEffectView(effect: blur)
        blurVisualEffectView.frame = UIScreen.main.bounds
        blurVisualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //        self.view.insertSubview(blurVisualEffectView, at: 0)
        self.view.addSubview(blurVisualEffectView)  //<--- hides everything
        
        let infoAlertController = UIAlertController(title: "Current File System Path", message: "\(parentFolder?.currentURL.path ?? "")", preferredStyle: .alert)
        infoAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            blurVisualEffectView.removeFromSuperview()
        }))
        present(infoAlertController, animated: true)
    }
    
    @objc private func handleLeftArrowBarButton(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BrowseCell.self, forCellReuseIdentifier: Constants.TableID.rawValue)
        view.backgroundColor = UIColor.veryLightGrey
        confirmParentFolder()
        setupNavigationBar()
        loadTableView()
    }
    
    //MARK:- FileSystem functions
    private func loadTableView(){
        do {
            let folderContents = try fmD.contentsOfDirectory(at: (parentFolder?.currentURL)!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            guard let guardParentFolder = parentFolder else {return}
            folderContents.forEach{fileDirArray.append(FileDirStruct(name: $0.lastPathComponent, isFolder: $0.hasDirectoryPath, parentDir: guardParentFolder))}
            fileDirArray.sort()
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
            showLeftBarButton = false
        }
    }
}

/*
 @objc func handleBlurBarButton3(){
 let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()
 blurEffect.setValue(1, forKey: "blurRadius")
 //////
 let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
 blurVisualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
 blurVisualEffectView.frame = UIScreen.main.bounds
 self.view.addSubview(blurVisualEffectView)
 
 let myAlertController = UIAlertController(title: "BLUR", message: "You Are being Blurred", preferredStyle: .alert)
 myAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
 blurVisualEffectView.removeFromSuperview()
 self.navigationController?.isNavigationBarHidden = false
 }))
 present(myAlertController, animated: true)
 }
 */



