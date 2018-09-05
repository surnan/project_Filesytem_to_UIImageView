//
//  Objects.swift
//  project 1
//
//  Created by admin on 8/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


struct FileDirObjectStruct: Comparable {
    var name: String
    let isFolder: Bool
    var fileURL : URL
    
    init(name: String, isFolder: Bool, url: URL){
        self.name = name
        self.isFolder = isFolder
        self.fileURL = url
    }
    
    func FileURLtoUIImageView()-> UIImage {
        if let image = UIImage(contentsOfFile: fileURL.path) {
            return image
        } else {
            return UIImage()
        }
    }
    
    public static func < (lhs: FileDirObjectStruct, rhs: FileDirObjectStruct) -> Bool {
        let answer = (lhs.isFolder == rhs.isFolder) ? (lhs.name.capitalized < rhs.name.capitalized) : lhs.isFolder
        return answer
    }
}


