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
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var nameAlertText: UITextField? //'input' is lost when 'addTextField' closure ends
        ///
        func handleEditRowAlert(actionTarget: UIAlertAction){
            print("nameAlertText --> \(nameAlertText?.text ?? "")")            
        }
        let editRowAlertController = UIAlertController(title: "EDIT", message: "Please enter new name for: \n\(fileDirObjects[indexPath.row].name)", preferredStyle: .alert)
        editRowAlertController.addTextField { (input) in
            input.placeholder = "new name"
            input.clearButtonMode = UITextFieldViewMode.whileEditing
            nameAlertText = input
        }
        let action1 = UIAlertAction(title: "Save", style: .default, handler: handleEditRowAlert)
        //  action1.setValue(#imageLiteral(resourceName: "info_icon"), forKey: "image")  <-- icon needs to be resized
        editRowAlertController.addAction(action1)
        editRowAlertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        ///
        func handleDeleteRowAlert(actionTarget: UIAlertAction){
            print("deleting --> \(nameAlertText?.text ?? "")")
        }
        let deleteRowAlertController = UIAlertController(title: "DELETE", message: "Please confirm deletion of: \n\(fileDirObjects[indexPath.row].name)", preferredStyle: .alert)
        let action2 = UIAlertAction(title: "Save", style: .default, handler: handleDeleteRowAlert)
        //  action2.setValue(#imageLiteral(resourceName: "info_icon"), forKey: "image")  <-- icon needs to be resized
        deleteRowAlertController.addAction(action2)
        deleteRowAlertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        ///
        let deleteRowAction = UITableViewRowAction(style: .destructive, title: "Delete") {[weak self] (_, _) in self?.present(deleteRowAlertController, animated: true  )}
        let editRowAction = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] (_, _) in self?.present(editRowAlertController, animated: true)}
        editRowAction.backgroundColor = UIColor.darkBlue
        return [deleteRowAction, editRowAction]
    }
   
    //MARK:- Functions called by other TableView built-in functions
    @objc fileprivate func handleRowActionDelete(){
        print("Selection = DELETED")
    }
    
    @objc fileprivate func handleRowActionEdit(){
        print("Selection = EDIT ")
    }
    
    fileprivate func FileURLtoUIImageView(currentObject: FileDirObjectStruct)-> UIImage {
        if let image = UIImage(contentsOfFile: currentObject.fileURL.path) {
            return image
        } else {
            return UIImage()
        }
    }
}

