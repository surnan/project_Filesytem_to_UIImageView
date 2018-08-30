//
//  Objects.swift
//  project 1
//
//  Created by admin on 8/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation


struct FileDirObject: Comparable {
    var name: String
    var isFolder: Bool
    
    init(name: String, isFolder: Bool){
        self.name = name
        self.isFolder = isFolder
    }
    
    public static func < (lhs: FileDirObject, rhs: FileDirObject) -> Bool {
        
        if lhs.isFolder == rhs.isFolder
        {
            return lhs.name < rhs.name
        } else {
            return lhs.isFolder
        }
    }
}
