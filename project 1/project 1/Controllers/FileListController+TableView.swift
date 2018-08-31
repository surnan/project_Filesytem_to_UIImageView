//
//  ViewController+TableViewFunctions.swift
//  project 1
//
//  Created by admin on 8/26/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

extension FileListController {
    //MARK:- TableView Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileDirObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: databaseID, for: indexPath) as! FileListCellController
        let tempFileDirObject = fileDirObjects[indexPath.row]
        cell.currentFileDirObject = tempFileDirObject
        cell.backgroundColor = (tempFileDirObject.isFolder ? UIColor.lightOrange : UIColor.lightPurple)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFileDir = fileDirObjects[indexPath.row]
        if currentFileDir.isFolder {
            let newController = FileListController()
            newController.navTitleStr = currentFileDir.name
            newController.navLeftBarButtonStr = currentFileDir.name
            newController.ender = currentFileDir.name
            navigationController?.pushViewController(newController, animated: true)
        } else {
            let tempController = ShowImageController()
            tempController.currentImage = FileURLtoUIImageView(currentObject: fileDirObjects[indexPath.row])
            navigationController?.pushViewController(tempController, animated: true)
        }
    }
    
    
    fileprivate func FileURLtoUIImageView(currentObject: FileDirObjectStruct)-> UIImage {
        if let image = UIImage(contentsOfFile: currentObject.fileURL.path) {
            return image
        } else {
            return UIImage()
        }
    }
}

















