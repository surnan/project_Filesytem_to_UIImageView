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
        return pictures.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempController = ShowImageController()
        navigationController?.pushViewController(tempController, animated: true)
    }
    
    
    
}
