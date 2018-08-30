//
//  FileListControllerCell.swift
//  project 1
//
//  Created by admin on 8/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class FileListControllerCell: UITableViewCell {
    
    var currentFileDirObject: FileDirObject!  {
        didSet {
            nameLabel.text = currentFileDirObject.name
            isFolderLabel.text = (currentFileDirObject.isFolder ? "---->" : "")
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let isFolderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var myStackView: UIStackView = {
        var temp = UIStackView()
        temp.axis = .horizontal
        temp.distribution = .equalCentering
        temp.alignment = .center
        temp.spacing = 20
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [nameLabel, isFolderLabel].forEach{addSubview($0)}
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            isFolderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            isFolderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            ])

        /* //The below breaks formatting and can't figure out why
         [nameLabel, isFolderLabel].forEach{myStackView.addSubview($0)}
         addSubview(myStackView)         
         NSLayoutConstraint.activate([
         myStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
         myStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
         myStackView.topAnchor.constraint(equalTo: topAnchor),
         myStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
         ]) */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
