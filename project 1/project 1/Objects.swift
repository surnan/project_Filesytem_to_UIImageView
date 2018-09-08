//
//  Objects.swift
//  project 1
//
//  Created by admin on 8/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


struct FileDirStruct: Comparable {
    let isFolder: Bool
    let currentURL : URL
    var name: String {
        get {
            return currentURL.lastPathComponent
        }
    }

    init(name: String, isFolder: Bool, parentDir: FileDirStruct?){
        self.isFolder = isFolder
        if let existingParentDir = parentDir {
            self.currentURL = existingParentDir.currentURL.appendingPathComponent(name)
        } else {
            let FMd = FileManager.default
            var dirPaths = FMd.urls(for: .documentDirectory, in: .userDomainMask)
            let myDocumentsDirectory = dirPaths[0] //.documents folder for the App
            self.currentURL = myDocumentsDirectory.appendingPathComponent(name)
        }
    }

    private init(currentURL: URL, isFolder: Bool){
        self.currentURL = currentURL
        self.isFolder = isFolder
    }
    
    static func change(from: FileDirStruct, newName: String)->FileDirStruct {
        let tempUNC = from.currentURL.deletingLastPathComponent()
        let tempUNC2 = tempUNC.appendingPathComponent(newName)
        let tempFileDirObject = FileDirStruct(currentURL: tempUNC2, isFolder: from.isFolder)
        return tempFileDirObject
    }

    func FileURLtoUIImageView()-> UIImage {
        if let image = UIImage(contentsOfFile: currentURL.path) {
            return image
        } else {
            return UIImage()
        }
    }
    
    static func < (lhs: FileDirStruct, rhs: FileDirStruct) -> Bool {
        let answer = (lhs.isFolder == rhs.isFolder) ? (lhs.name.capitalized < rhs.name.capitalized) : lhs.isFolder
        return answer
    }
}



//    init(parentDir: FileDirStruct, name: String, isFolder: Bool){
//        self.isFolder = isFolder
//        self.currentURL = parentDir.currentURL.appendingPathComponent(name)
//    }
//
//    init(name: String, isFolder: Bool){
//        let FMd = FileManager.default
//        var dirPaths = FMd.urls(for: .documentDirectory, in: .userDomainMask)
//        let myDocumentsDirectory = dirPaths[0] //.documents folder for the App
//        self.isFolder = isFolder
//        self.currentURL = myDocumentsDirectory.appendingPathComponent(name)
//    }
