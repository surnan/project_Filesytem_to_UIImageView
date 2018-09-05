//
//  FileListController+DelegateProtocol.swift
//  project 1
//
//  Created by admin on 9/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

extension FileListController{
    func editFileDirObject(indexPath: IndexPath, name: String, fileURL: URL) {
        let isFolderStatus = fileDirObjects[indexPath.row].isFolder
        deleteFileDirObject(indexPath: indexPath)
        fileDirObjects.append(FileDirObjectStruct(name: name, isFolder: isFolderStatus, url: fileURL))
        fileDirObjects.sort()
        var insertionIndex = 0
        for (index, currentObject) in fileDirObjects.enumerated() {
            if currentObject.fileURL == fileURL {
                insertionIndex = index
                break
            }
        }
        let insertionIndexPath = IndexPath(row: insertionIndex, section: 0)
        tableView.insertRows(at: [insertionIndexPath], with: .right)
    }
    
    func deleteFileDirObject(indexPath: IndexPath) {
        fileDirObjects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    func addFileDirObject(name: String, isFolder: Bool, fileURL: URL) {
        fileDirObjects.append(FileDirObjectStruct(name: name, isFolder: isFolder, url: fileURL))
        fileDirObjects.sort()
        var insertionIndex = 0
        for (index, currentObject) in fileDirObjects.enumerated() {
            if currentObject.fileURL == fileURL {
                insertionIndex = index
                break
            }
        }
        let insertionIndexPath = IndexPath(row: insertionIndex, section: 0)
        tableView.insertRows(at: [insertionIndexPath], with: .right)
    }
}
