//
//  Objects.swift
//  project 1
//
//  Created by admin on 8/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation


struct FileDirObjectStruct: Comparable {
    var name: String
    let isFolder: Bool
    var fileURL : URL
    
    init(name: String, isFolder: Bool, url: URL){
        self.name = name
        self.isFolder = isFolder
        self.fileURL = url
    }
    
    public static func < (lhs: FileDirObjectStruct, rhs: FileDirObjectStruct) -> Bool {
        
        if lhs.isFolder == rhs.isFolder
        {
            return lhs.name < rhs.name
        } else {
            return lhs.isFolder
        }
    }
}
