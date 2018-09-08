//
//  BrowseController+TableView.swift
//  project 1
//
//  Created by admin on 9/8/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

extension BrowseController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileDirArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = fileDirArray[indexPath.row].name
        cell.backgroundColor = fileDirArray[indexPath.row].isFolder ? UIColor.lightBlue : UIColor.lightBrown
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Clicked on --> \(fileDirArray[indexPath.row].name)")
        print("Current URL --> \(fileDirArray[indexPath.row].currentURL)\n")
        if fileDirArray[indexPath.row].isFolder {
            let newBrowseController = BrowseController()
            newBrowseController.parentFolder = updateParentFolder(subFolderName: fileDirArray[indexPath.row].name)
            navigationController?.pushViewController(newBrowseController, animated: true)
        } else {
            let newShowImageController = ShowImageController()
            newShowImageController.fileImageView.image = UIImage(named: Constants.background2.rawValue)
            present(newShowImageController, animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let labelText: NSString = "- Empty Folder -\n\nClick plus icon to create file or subfolder" as NSString
        let mutableAttributedText = NSMutableAttributedString.init(string: labelText as String)
        let textRangeEmptyFolder = (labelText).range(of: "- Empty Folder -")
        mutableAttributedText.addAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20),
                                             NSAttributedStringKey.foregroundColor: UIColor.red], range: textRangeEmptyFolder)
        let textRangeClickPlus = (labelText).range(of: "Click plus icon to create file or subfolder")
        mutableAttributedText.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12),
                                             NSAttributedStringKey.foregroundColor: UIColor.lightGray], range: textRangeClickPlus)
        let footerLabel: UILabel = {
            let tempLabel = UILabel()
            tempLabel.numberOfLines = -1
            tempLabel.textAlignment = .center
            tempLabel.attributedText = mutableAttributedText
            return tempLabel
        }()
        return footerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        return fileDirArray.count != 0 ? 0 : view.bounds.height - topBarHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
