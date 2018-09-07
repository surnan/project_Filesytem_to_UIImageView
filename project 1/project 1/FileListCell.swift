//
//  FileListCell.swift
//  project 1
//
//  Created by admin on 8/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class FileListCell: UITableViewCell {
    
    var currentFileDirObject: FileDirObjectStruct!  {
        didSet {
            nameLabel.text = currentFileDirObject.name
//            isFolderLabel.text = (currentFileDirObject.isFolder ? "---->" : "")
            isFolderIconLeadingImageView.image = currentFileDirObject.isFolder ? #imageLiteral(resourceName: "folder") : #imageLiteral(resourceName: "file2")
            isFolderIconTrailingImageView.image = currentFileDirObject.isFolder ? #imageLiteral(resourceName: "right2") : UIImage()
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let isFolderIconLeadingImageView: UIImageView = {
       let tempImageView = UIImageView()
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        tempImageView.contentMode = .scaleAspectFit
        tempImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tempImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tempImageView
    }()
    
    let isFolderIconTrailingImageView: UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.contentMode = .scaleToFill
        tempImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tempImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tempImageView.translatesAutoresizingMaskIntoConstraints = false
        return tempImageView
    }()

    var myStackView2: UIStackView = {
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

//MARK:- extras

//  override init(...)
//        [nameLabel, isFolderLabel].forEach{addSubview($0)}
//        NSLayoutConstraint.activate([
//            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
//            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            isFolderLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            isFolderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
//            ])

/* //The below breaks formatting and can't figure out why
 [nameLabel, isFolderLabel].forEach{myStackView.addSubview($0)}
 addSubview(myStackView)
 NSLayoutConstraint.activate([
 myStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
 myStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
 myStackView.topAnchor.constraint(equalTo: topAnchor),
 myStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
 ]) */






//let isFolderLabel: UILabel = {
//    let label = UILabel()
//    label.font = UIFont.boldSystemFont(ofSize: 14)
//    label.translatesAutoresizingMaskIntoConstraints = false
//    return label
//}()
//
//var myStackView: UIStackView = {
//    var temp = UIStackView()
//    temp.axis = .horizontal
//    temp.distribution = .equalCentering
//    temp.alignment = .center
//    temp.spacing = 20
//    temp.translatesAutoresizingMaskIntoConstraints = false
//    return temp
//}()

