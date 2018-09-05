//
//  Global_Constants.swift
//  project 1
//
//  Created by admin on 9/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


public enum Constants:String {
    case TableID  //database Identifier for FileListController
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



