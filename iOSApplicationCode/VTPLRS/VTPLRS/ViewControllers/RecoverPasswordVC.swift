//
//  RecoverPasswordVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class RecoverPasswordVC: UIViewController, UITextFieldDelegate {
    
    //Variables
    var emailIDTextField : UITextField!
    var headingView : UIView!
    var headingLabel : UILabel!
    var recoverPasswordButton : UIButton!
    var activityIndicator : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.addHeading()
        self.addTextField()
        self.addRecoverPasswordButton()
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
            self.headingView.heightAnchor.constraint(equalToConstant: 150),
            self.headingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: +0),
            self.headingView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +0),
            self.headingView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: +0)
        ])
        
        //
        //HeadingLabel
        self.headingLabel = UILabel(frame: .zero)
        self.headingLabel.text = "RECOVER PASSWORD"
        
        self.headingView.addSubview(self.headingLabel)
        self.headingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headingLabel.textAlignment = .center
        self.headingLabel.adjustsFontSizeToFitWidth = true
        self.headingLabel.minimumScaleFactor = 0.5
        
        NSLayoutConstraint.activate([
            self.headingLabel.topAnchor.constraint(equalTo: self.headingView.topAnchor, constant: +10),
            self.headingLabel.widthAnchor.constraint(equalToConstant: 200),
            self.headingLabel.centerXAnchor.constraint(equalTo: self.headingView.centerXAnchor, constant: +0),
            self.headingLabel.bottomAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: -10)
        ])
        
    }
    
    //Function to add textfield
    func addTextField() {
        self.emailIDTextField = UITextField(frame: .zero)
        self.emailIDTextField.borderStyle = .roundedRect
        self.emailIDTextField.delegate = self
        self.emailIDTextField.translatesAutoresizingMaskIntoConstraints = false
        self.emailIDTextField.placeholder = "Email ID : "
        self.view.addSubview(self.emailIDTextField)
        NSLayoutConstraint.activate([
            self.emailIDTextField.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +15),
            self.emailIDTextField.leadingAnchor.constraint(equalTo: self.headingView.leadingAnchor, constant: +40),
            self.emailIDTextField.trailingAnchor.constraint(equalTo: self.headingView.trailingAnchor, constant: -40),
            self.emailIDTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //Function for the recover password button
    func addRecoverPasswordButton() {
        self.recoverPasswordButton = UIButton(frame: .zero)
        self.recoverPasswordButton.setTitle("Get password back =>", for: .normal)
        self.recoverPasswordButton.setTitleColor(.systemBlue, for: .normal)
        self.recoverPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        self.recoverPasswordButton.addTarget(self, action: #selector(self.recoverButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(self.recoverPasswordButton)
        NSLayoutConstraint.activate([
            self.recoverPasswordButton.widthAnchor.constraint(equalToConstant: 200),
            self.recoverPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            self.recoverPasswordButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.recoverPasswordButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        
        
    }
    
    //Function to be called when the button is pressed
    @objc func recoverButtonPressed(_ sender : Any) {
        self.activityIndicator = UIActivityIndicatorView(style: .large)
        self.activityIndicator.startAnimating()
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.activityIndicator)
        NSLayoutConstraint.activate([
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 150),
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 150),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: +0),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: +0)
        ])
        
        if let email = self.emailIDTextField.text {
            MailerService.instance.recoverPassword(email: email, handler: { done in
                if done {
                    print("MAIL SENT")
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.removeFromSuperview()
                        var alert = UIAlertController(title: "Password Recovery", message: "Password recovery mail sent", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    print("SENDING MAIL FAILED")
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.removeFromSuperview()
                        var alert = UIAlertController(title: "Password Recovery", message: "Password recovery mail not sent", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
}
