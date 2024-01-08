//
//  SignInVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class SignInVC: UIViewController, UITextFieldDelegate {
    
    //Variables
    var headingView : UIView!
    var headingLabel : UILabel!
    var emailTF : UITextField!
    var passwordTF : UITextField!
    var doneButton : UIButton!
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.addHeading()
        self.addTextFields()
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
        self.headingLabel.text = "SIGN-IN"
        
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


    //Function to add the two text fields
    func addTextFields() {
        self.emailTF = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.passwordTF = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.emailTF.delegate = self
        self.passwordTF.delegate = self
        
        self.view.addSubview(self.emailTF)
        self.view.addSubview(self.passwordTF)
        
        self.emailTF.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTF.translatesAutoresizingMaskIntoConstraints = false
        
        self.emailTF.borderStyle = .roundedRect
        self.passwordTF.borderStyle = .roundedRect
        
        NSLayoutConstraint.activate([
            self.emailTF.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +40),
            self.emailTF.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +100),
            self.emailTF.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            self.emailTF.heightAnchor.constraint(equalToConstant: 60),
            self.passwordTF.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +40),
            self.passwordTF.topAnchor.constraint(equalTo: self.emailTF.bottomAnchor, constant: +30),
            self.passwordTF.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            self.passwordTF.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        self.emailTF.placeholder = "EmailID"
        self.passwordTF.placeholder = "Password"
        
        self.passwordTF.isSecureTextEntry = true
    }
    
    //Function to add button
    func addButton() {
        self.doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        self.doneButton.backgroundColor = UIColor.systemGreen
        self.doneButton.clipsToBounds = true
        self.doneButton.layer.cornerRadius = 60 * 0.5
        self.doneButton.addTarget(self, action: #selector(self.doneButtonPressed(_:)), for: .touchUpInside)
        self.doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.doneButton)
        
        NSLayoutConstraint.activate([
            self.doneButton.heightAnchor.constraint(equalToConstant: 60),
            self.doneButton.widthAnchor.constraint(equalToConstant: 60),
            self.doneButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            self.doneButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
    }
    
    //Function to sign in the user
    func signInUser() {
        guard let email = self.emailTF.text else { return }
        guard let password = self.passwordTF.text else { return }
        
        let userDict : [String : Any] = ["email":email,"password":password]
        
        UserDataService.instance.loginUser(userDict: userDict, handler: { (done,user) in
            if done {
                theUser = user
                print("LOGGED IN")
                let emailDict = ["email":user!.email]
                DeviceService.instance.getDeviceDetailsForUser(emailDict: emailDict, handler: { done,aDevice in
                    if(done) {
                        theDevice = aDevice
                        DispatchQueue.main.async {
                            let viewController = ViewController()
                            viewController.modalPresentationStyle = .fullScreen
                            self.present(viewController, animated: true, completion: nil)
                        }
                    } else {
                        theUser = nil
                        DispatchQueue.main.async {
                            self.displayAlert(title: "Sign-In", message: "Sign-In failed, check your credentials.")
                        }
                    }
                })

            } else {
                theUser = nil
                DispatchQueue.main.async {
                    self.displayAlert(title: "Sign-In", message: "Sign-In failed, check your credentials.")
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
    
    //Function for the button
    @objc func doneButtonPressed(_ sender : Any) {
        self.signInUser()
    }
    
    
}
