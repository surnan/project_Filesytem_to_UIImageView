////
////  ViewController+TableViewFunctions.swift
////  project 1
////
////  Created by admin on 8/26/18.
////  Copyright © 2018 admin. All rights reserved.
////
//
//import UIKit
//
//extension FileListController {
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fileDirObjects.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableID.rawValue, for: indexPath) as! FileListCell
//        let tempFileDirObject = fileDirObjects[indexPath.row]
//        cell.currentFileDirObject = tempFileDirObject
//        cell.backgroundColor = (indexPath.row % 2 == 0 ? UIColor.white : UIColor.lightBlue)
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let currentFileDir = fileDirObjects[indexPath.row]
//        if currentFileDir.isFolder {
//            let newContoller2 = childNavigationController(title: currentFileDir.name, enderPathString: currentFileDir.name, backIconNeeded: true)
//            navigationController?.pushViewController(newContoller2, animated: true)
//        } else {
//            let newImageController = ShowImageController()
//            newImageController.currentImage = fileDirObjects[indexPath.row].FileURLtoUIImageView()
//            navigationController?.pushViewController(newImageController, animated: true)
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        var nameAlertText: UITextField? //'input' is lost when 'addTextField' closure ends
//        let fmd = FileManager.default
//        func handleDeleteRowAlert(actionTarget: UIAlertAction){
//            do {
//                try fmd.removeItem(at: fileDirObjects[indexPath.row].fileURL)
//                deleteFileDirObject(indexPath: indexPath)
//            } catch let deleteFileErr {
//                print("Error deleting file from fileSystem \(deleteFileErr)")
//            }
//        }
//        func handleEditRowAlert(actionTarget: UIAlertAction){
//                let components = fileDirObjects[indexPath.row].fileURL.path.split(separator: "/")
//                let directory = components.dropLast(1).map(String.init).joined(separator: "/")
//                let newPath = "/" + directory + "/" + (nameAlertText?.text)!
//                do {
//                    try fmd.moveItem(atPath: fileDirObjects[indexPath.row].fileURL.path, toPath: newPath)
//                    guard let newName = (nameAlertText?.text), let newUNC = URL(string: newPath) else { return }
//                    editFileDirObject(indexPath: indexPath, name: newName, fileURL: newUNC)
//                } catch let moveErr {
//                    print("Error trying to rename/move file: \(moveErr)")
//                }
//        }
//        let editRowAlertController = UIAlertController(title: "EDIT", message: "Please enter new name for: \n\(fileDirObjects[indexPath.row].name)", preferredStyle: .alert)
//        editRowAlertController.addTextField { (input) in
//            input.placeholder = "new name"
//            input.clearButtonMode = UITextFieldViewMode.whileEditing
//            nameAlertText = input
//        }
//        let action1 = UIAlertAction(title: "Save", style: .default, handler: handleEditRowAlert)
//        editRowAlertController.addAction(action1)
//        editRowAlertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//        let deleteRowAlertController = UIAlertController(title: "DELETE", message: "Please confirm deletion of: \n\(fileDirObjects[indexPath.row].name)", preferredStyle: .alert)
//        let action2 = UIAlertAction(title: "Save", style: .default, handler: handleDeleteRowAlert)
//        deleteRowAlertController.addAction(action2)
//        deleteRowAlertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//        let deleteRowAction = UITableViewRowAction(style: .destructive, title: "Delete") {[weak self] (_, _) in self?.present(deleteRowAlertController, animated: true  )}
//        let editRowAction = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] (_, _) in self?.present(editRowAlertController, animated: true)}
//        editRowAction.backgroundColor = UIColor.darkBlue
//        return [deleteRowAction, editRowAction]
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return fileDirObjects.count != 0 ? 0 : 250
//    }
//    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerLabel = UILabel()
//        footerLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        footerLabel.text = "This Folder is Empty\n\nClick plus icon to create file or subfolder"
//        footerLabel.numberOfLines = -1
//        footerLabel.textAlignment = .center
//        footerLabel.backgroundColor = .white
//        footerLabel.textColor = .red
//        return footerLabel
//    }
//
//    
//    //MARK:- UINavigationController Functions
//    func childNavigationController(title: String, enderPathString: String, backIconNeeded: Bool) -> FileListController {
//        let newController = FileListController()
//        newController.updateNavTitle(title: title)
//        newController.updateNavLeftBarButton(titleNeeded: true)
//        newController.updateEnder(path: enderPathString)
//        return newController
//    }
//}
//
