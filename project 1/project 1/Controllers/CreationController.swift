//
//  CreationController.swift
//  project 1
//
//  Created by admin on 9/2/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit



class CreationController: UIViewController {
    
    
    var currentUNC: URL!
    
    
    
    fileprivate var nameLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "Please Enter Name"
        tempLabel.textColor = UIColor.black
        tempLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return tempLabel
    }()
    
    
    fileprivate lazy var nameTextField: UITextField = {
        var tempTextField = UITextField()
        tempTextField.backgroundColor = UIColor.white
        tempTextField.textAlignment = .center
        tempTextField.clearButtonMode = .whileEditing
        tempTextField.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return tempTextField
    }()
    
    
    fileprivate var isFolderLabel: UILabel = {
        var tempLabel = UILabel()
        tempLabel.text = "FOLDER <--------> FILE"
        tempLabel.font = UIFont.boldSystemFont(ofSize: 16)
        tempLabel.textColor = UIColor.black
        return tempLabel
    }()
    
    fileprivate lazy var isFolderCheckBox: UISwitch = {
        var tempSwitch = UISwitch()
        tempSwitch.isOn = false
        return tempSwitch
    }()
    
    fileprivate lazy var doneButton: UIButton = {
        let tempButton = UIButton()
        tempButton.setTitle("DONE", for: .normal)
        tempButton.setTitleColor(UIColor.white, for: .normal)
        tempButton.backgroundColor = UIColor.darkBlue
        tempButton.addTarget(self, action: #selector(handleDoneButton), for: .touchDown)
        tempButton.translatesAutoresizingMaskIntoConstraints  = false
        tempButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        return tempButton
    }()
    
    fileprivate var myStack: UIStackView = {
        var tempStack = UIStackView()
        tempStack.axis = .vertical
        tempStack.spacing = 10
        tempStack.alignment = .center
        return tempStack
    }()
    
    fileprivate func getCustomizedBarButton(name: String, action: Selector) -> UIBarButtonItem {
        let infoButton = UIButton(type: .custom)
        infoButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        infoButton.setImage(UIImage(named: name), for: .normal)
        infoButton.addTarget(self, action: action, for: .touchUpInside)
        let menuBarButtonItem = UIBarButtonItem(customView: infoButton)
        menuBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return menuBarButtonItem
    }
    
    fileprivate func setupNavigationBar(){
        navigationController?.title = "Create File or Folder"
        
        let backBtn = getCustomizedBarButton(name: "backButton", action: #selector(handleBackButton))
        navigationItem.leftBarButtonItem = backBtn
        
    }
    
    @objc fileprivate func handleBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func handleDoneButton(){
        print("Done Button Pressed")
        
        let fm = FileManager.default
        if isFolderCheckBox.isOn {
            print("creating file")
            let tempImage = #imageLiteral(resourceName: "info_icon")
            let newPath = currentUNC.path + "/" + nameTextField.text!
            fm.createFile(atPath: newPath, contents:   tempImage.png  , attributes: nil)
            print("succesfully created file  at ---> \(newPath)")
            
        } else {
            print("creating folder")
            do {
                try fm.createDirectory(at: currentUNC.appendingPathComponent(nameTextField.text!), withIntermediateDirectories: false, attributes: nil)
                print("succesfully created directory at ----> \(currentUNC.appendingPathComponent(nameTextField.text ?? "<empty>"))")
            } catch let createDirectoryErr {
                print("Error Creating directory at \(currentUNC) for input = \(createDirectoryErr)")
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let myCurrentUNC = currentUNC else {return}
        
        print("currentUNC --> ", myCurrentUNC)
        
        setupNavigationBar()
        myStack.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightBrown
        [nameLabel, nameTextField, isFolderLabel, isFolderCheckBox, doneButton].forEach{myStack.addArrangedSubview($0)}
        view.addSubview(myStack)
        NSLayoutConstraint.activate([
            myStack.widthAnchor.constraint(equalToConstant: 300),
            myStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
}
