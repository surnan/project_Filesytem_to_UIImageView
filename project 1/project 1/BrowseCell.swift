//
//  FileListCell.swift
//  project 1
//
//  Created by admin on 8/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class BrowseCell: UITableViewCell {
    
    var currentFileDirObject: FileDirStruct!  {
        didSet {
            nameLabel.text = currentFileDirObject.name
            isFolderIconLeadingImageView.image = currentFileDirObject.isFolder ? #imageLiteral(resourceName: "folder") : #imageLiteral(resourceName: "file2")
            isFolderIconTrailingImageView.image = currentFileDirObject.isFolder ? #imageLiteral(resourceName: "right2") : UIImage()
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let isFolderIconLeadingImageView: UIImageView = {
       let tempImageView = UIImageView()
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        tempImageView.contentMode = .scaleAspectFit
        tempImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tempImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tempImageView
    }()
    
    private let isFolderIconTrailingImageView: UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.contentMode = .scaleToFill
        tempImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tempImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        return tempImageView
    }()

    private var myStackView2: UIStackView = {
        var temp = UIStackView()
        temp.axis = .horizontal
        temp.distribution = .fill
        temp.alignment = .center
        temp.spacing = 20
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [isFolderIconLeadingImageView, nameLabel, isFolderIconTrailingImageView].forEach{myStackView2.addArrangedSubview($0)}
        addSubview(myStackView2)
        
        NSLayoutConstraint.activate([
            myStackView2.centerYAnchor.constraint(equalTo: centerYAnchor),
            myStackView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            myStackView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

