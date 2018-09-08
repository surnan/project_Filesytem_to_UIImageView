////
////  CreationController.swift
////  project 1
////
////  Created by admin on 9/2/18.
////  Copyright © 2018 admin. All rights reserved.
////
//
//import UIKit
//
//class CreationController: UIViewController {
//    
//    var currentUNC: URL!
//    private let FMd = FileManager.default
//    var delegate : FileListControllerDelegate?
//    
//    private var nameLabel: UILabel = {
//        let tempLabel = UILabel()
//        tempLabel.text = "Please Enter Name"
//        tempLabel.textColor = UIColor.black
//        tempLabel.font = UIFont.boldSystemFont(ofSize: 16)
//        return tempLabel
//    }()
//    
//    private lazy var nameTextField: UITextField = {
//        var tempTextField = UITextField()
//        tempTextField.backgroundColor = UIColor.white
//        tempTextField.textAlignment = .center
//        tempTextField.clearButtonMode = .whileEditing
//        tempTextField.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        return tempTextField
//    }()
//    
//    private var isFolderLabel: UILabel = {
//        var tempLabel = UILabel()
//        tempLabel.text = "FOLDER <--------> FILE"
//        tempLabel.font = UIFont.boldSystemFont(ofSize: 16)
//        tempLabel.textColor = UIColor.black
//        return tempLabel
//    }()
//    
//    private lazy var isFolderCheckBox: UISwitch = {
//        var tempSwitch = UISwitch()
//        tempSwitch.isOn = false
//        return tempSwitch
//    }()
//    
//    private lazy var doneButton: UIButton = {
//        let tempButton = UIButton()
//        tempButton.setTitle("DONE", for: .normal)
//        tempButton.setTitleColor(UIColor.white, for: .normal)
//        tempButton.backgroundColor = UIColor.darkBlue
//        tempButton.addTarget(self, action: #selector(handleDoneButton), for: .touchDown)
//        tempButton.translatesAutoresizingMaskIntoConstraints  = false
//        tempButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
//        return tempButton
//    }()
//    
//    private var myStack: UIStackView = {
//        var tempStack = UIStackView()
//        tempStack.axis = .vertical
//        tempStack.spacing = 10
//        tempStack.alignment = .center
//        tempStack.translatesAutoresizingMaskIntoConstraints = false
//        return tempStack
//    }()
//    
//    private func setupNavigationBar(){
//        navigationController?.title = "Create File or Folder"
//        let backButton = getCustomizedBarButton(name: Constants.left_arrow.rawValue , target: self, action: #selector(handleBackButton))
//        navigationItem.leftBarButtonItem = backButton
//    }
//    
//    @objc private func handleBackButton(){
//        navigationController?.popViewController(animated: true)
//    }
//    
//    @objc private func handleDoneButton(){
//        if isFolderCheckBox.isOn {
//            let tempImage = #imageLiteral(resourceName: "info")
//            let newPath = currentUNC.path + "/" + nameTextField.text!
//            FMd.createFile(atPath: newPath, contents:   tempImage.png  , attributes: nil)
//            delegate?.addFileDirObject(name: nameTextField.text!, isFolder: false, fileURL: URL(string: newPath)!)
//        } else {
//            do {
//                try FMd.createDirectory(at: currentUNC.appendingPathComponent(nameTextField.text!), withIntermediateDirectories: false, attributes: nil)
//                delegate?.addFileDirObject(name: nameTextField.text!, isFolder: true, fileURL: currentUNC)
//            } catch let createDirectoryErr {
//                print("Error Creating directory at \(currentUNC) for input = \(createDirectoryErr)")
//            }
//        }
//        navigationController?.popViewController(animated: true)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        guard let myCurrentUNC = currentUNC else {return}
//        print("currentUNC --> ", myCurrentUNC)
//        setupNavigationBar()
//        view.backgroundColor = UIColor.lightBrown
//        [nameLabel, nameTextField, isFolderLabel, isFolderCheckBox, doneButton].forEach{myStack.addArrangedSubview($0)}
//        view.addSubview(myStack)
//        NSLayoutConstraint.activate([
//            myStack.widthAnchor.constraint(equalToConstant: 300),
//            myStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            myStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            ])
//    }
//}
