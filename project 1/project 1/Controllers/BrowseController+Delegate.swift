//
//  BrowseController+Delegate.swift
//  project 1
//
//  Created by admin on 9/9/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

extension BrowseController{
    func createFileDirArrayElement(name: String, isFolder: Bool, parentDir: FileDirStruct) {
        let fmD = FileManager.default
        let newPath = parentDir.currentURL.appendingPathComponent(name)
        if isFolder {
            do {
                try fmD.createDirectory(atPath: newPath.path, withIntermediateDirectories: false, attributes: nil)
            } catch let createDirError {
                print("Problem creating directory at: \(newPath.path).  Error = \(createDirError)")
                return
            }
        } else {
            let tempImage = #imageLiteral(resourceName: "background2")
            let newPath = parentDir.currentURL.appendingPathComponent(name)
            fmD.createFile(atPath: newPath.path, contents: tempImage.png, attributes: nil)
        }
        let newArrayElement = FileDirStruct(name: name, isFolder: isFolder, parentDir: parentDir)
        fileDirArray.append(newArrayElement)
        fileDirArray.sort()
        guard let insertionIndex = fileDirArray.index(of: newArrayElement) else {return}
        tableView.insertRows(at: [IndexPath(row: insertionIndex, section: 0)], with: .right)
    }
}
