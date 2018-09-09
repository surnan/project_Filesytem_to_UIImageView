//
//  Global_Constants.swift
//  project 1
//
//  Created by admin on 9/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


public enum Constants:String {
    case TableID        //database Identifier for FileListController
    case info           //Asset
    case plus           //Asset
    case escape_arrow   //Asset
    case left_arrow     //Asset
    case background2    //Asset
    case background3    //Asset
    case backgroundPattern  //Asset
    case file           //Asset
    case file2          //Asset
    case folder         //Asset
    case largerBackgroundPattern    //Asset
    case largestBackgroundPattern   //Asset
    case plus2          //Asset
    case right_arrow    //Asset
    case right_arrow2   //Asset
    case right          //Asset
    case right2         //Asset
}

public func getCustomizedBarButton(name: String, target: Any?,action: Selector) -> UIBarButtonItem {
    let infoButton = UIButton(type: .custom)
    infoButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
    infoButton.setImage(UIImage(named: name), for: .normal)
    infoButton.addTarget(target, action: action, for: .touchUpInside)
    let menuBarButtonItem = UIBarButtonItem(customView: infoButton)
    menuBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
    menuBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
    return menuBarButtonItem
}

public func printCurrentPath(){
    print("Current Path = \(Bundle.main.resourcePath ?? "")")
}



