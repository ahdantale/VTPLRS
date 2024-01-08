//
//  RegisterVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    //Variables
    var headingView : UIView!
    var headingLabel : UILabel!
    var deviceidTF : UITextField!
    var ageTF : UITextField!
    var addressTF : UITextField!
    var phoneNumberTF : UITextField!
    var emailIDTF : UITextField!
    var nameTF : UITextField!
    var passwordTF : UITextField!
    var doneButton : UIButton!
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.addHeading()
        self.addFirstTextField()
        self.addButton()
    }
    
    //Function to add heading
    func addHeading() {
        //
        //HeadingView
        self.headingView = UIView(frame: .zero)
        self.headingView.backgroundColor = UIColor.systemBackground
        
        self.view.addSubview(self.headingView)
        self.headingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headingView.heightAnchor.constraint(equalToConstant: 80),
            self.headingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: +0),
            self.headingView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +0),
            self.headingView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: +0)
        ])
        
        //
        //HeadingLabel
        self.headingLabel = UILabel(frame: .zero)
        self.headingLabel.text = "REGISTER"
        
        self.headingView.addSubview(self.headingLabel)
        self.headingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headingLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            self.headingLabel.heightAnchor.constraint(equalToConstant: 50),
            self.headingLabel.widthAnchor.constraint(equalToConstant: 100),
            self.headingLabel.centerXAnchor.constraint(equalTo: self.headingView.centerXAnchor, constant: +0),
            self.headingLabel.topAnchor.constraint(equalTo: self.headingView.topAnchor, constant: +15)
        ])
        
    }
    
    //Function to add the first text field
    func addFirstTextField() {
        self.deviceidTF = UITextField(frame: .zero)
        self.deviceidTF.delegate = self
        self.deviceidTF.placeholder = "Device-ID : "
        self.deviceidTF.translatesAutoresizingMaskIntoConstraints = false
        self.deviceidTF.borderStyle = .roundedRect
        self.view.addSubview(self.deviceidTF)
        NSLayoutConstraint.activate([
            self.deviceidTF.heightAnchor.constraint(equalToConstant: 40),
            self.deviceidTF.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +20),
            self.deviceidTF.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +30),
            self.deviceidTF.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
        self.ageTF = UITextField(frame: .zero)
        self.addressTF = UITextField(frame: .zero)
        self.phoneNumberTF = UITextField(frame: .zero)
        self.emailIDTF = UITextField(frame: .zero)
        self.nameTF = UITextField(frame: .zero)
        self.passwordTF = UITextField(frame: .zero)
        
        self.ageTF.placeholder = "Age"
        self.addressTF.placeholder = "Address"
        self.phoneNumberTF.placeholder = "Phone Number"
        self.emailIDTF.placeholder = "Email ID"
        self.nameTF.placeholder = "Name"
        self.passwordTF.placeholder = "Password"
        
        self.passwordTF.isSecureTextEntry = true
        
        self.addTextFieldToView(self.deviceidTF, self.ageTF)
        self.addTextFieldToView(self.ageTF, self.phoneNumberTF)
        self.addTextFieldToView(self.phoneNumberTF, self.emailIDTF)
        self.addTextFieldToView(self.emailIDTF, self.nameTF)
        self.addTextFieldToView(self.nameTF, self.passwordTF)
    }
    
    func addTextFieldToView(_ firstTF : UITextField, _ secondTF : UITextField){
        secondTF.borderStyle = .roundedRect
        secondTF.delegate = self
        secondTF.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(secondTF)
        NSLayoutConstraint.activate([
            secondTF.heightAnchor.constraint(equalToConstant: 40),
            secondTF.topAnchor.constraint(equalTo: firstTF.bottomAnchor, constant: +15),
            secondTF.leadingAnchor.constraint(equalTo: firstTF.leadingAnchor, constant: +0),
            secondTF.trailingAnchor.constraint(equalTo: firstTF.trailingAnchor, constant: +0)
        ])
        
    }
    
    //Function to add button
    func addButton() {
        self.doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        self.doneButton.backgroundColor = UIColor.systemGreen
        self.doneButton.clipsToBounds = true
        self.doneButton.layer.cornerRadius = 60 * 0.5
        //self.doneButton.addTarget(self, action: #selector(self.doneButtonPressed(_:)), for: .touchUpInside)
        self.doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.doneButton)
        self.doneButton.addTarget(self, action: #selector(self.doneButtonPressed(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.doneButton.heightAnchor.constraint(equalToConstant: 60),
            self.doneButton.widthAnchor.constraint(equalToConstant: 60),
            self.doneButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            self.doneButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
    }
    
    //Function to create user
    func createUser() {
        guard let deviceId = self.deviceidTF.text else { return }
        guard let age = self.ageTF.text else { return }
        guard let phoneNo = self.phoneNumberTF.text else { return }
        guard let email = self.emailIDTF.text else { return }
        guard let name = self.nameTF.text else { return }
        guard let password = self.passwordTF.text else { return }
        
        let ageNo = Int(age)
        
        let deviceDict : [String : String] = ["deviceId":deviceId,"email":email]
        let userDict : [String : Any] = ["name" : name, "phoneNo":phoneNo, "email":email,"age":ageNo, "password":password]
        
        UserDataService.instance.createUser(userDict: userDict, handler: { done in
            if done {
                print("USER CREATED SUCCESSFULLY")
                DeviceService.instance.registerDevice(deviceDict: deviceDict, handler: { done in
                    if done {
                        print("DEVICE REGISTERED SUCCESSFULLY")
                        DispatchQueue.main.async {
                            self.displayAlert(title: "USER REGISTRATION", message: "User registered successfully")
                        }
                        
                    } else {
                        print("DEVICE NOT REGISTERED SUCCESSFULLY")
                        DispatchQueue.main.async {
                            self.displayAlert(title: "USER REGISTRATION", message: "User not registered")
                        }
                    }
                })
            } else {
                print("USER NOT CREATED")
                DispatchQueue.main.async {
                    self.displayAlert(title: "USER REGISTRATION", message: "User not registered")
                }
            }
        })
    }
    
    //Function to show alert message
    func displayAlert(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Function for done button pressed action
    @objc func doneButtonPressed(_ sender : Any) {
        print("Done button pressed")
        self.createUser()
    }
}
