//
//  RegisterVehicleVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 05/05/21.
//  Copyright © 2021 Abhishek Dantale. All rights reserved.
//

import UIKit

class RegisterVehicleVC: UIViewController, UITextFieldDelegate {

    //Variables for UI elements
    var headingView : UIView!
    var headingLabel : UILabel!
    var makeTF : UITextField!
    var modelTF : UITextField!
    var colourTF : UITextField!
    var registrationTF : UITextField!
    var doneButton : UIButton!
    
    //Function called when view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        //Calling Functions to add elements
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
        self.headingLabel.text = "REGISTER VEHICLE"
        self.headingLabel.adjustsFontSizeToFitWidth = true
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
    
    //Function to add first textfield to the view controller
    //Function to add the first text field
    func addFirstTextField() {
        self.makeTF = UITextField(frame: .zero)
        self.makeTF.delegate = self
        self.makeTF.placeholder = "Make : "
        self.makeTF.translatesAutoresizingMaskIntoConstraints = false
        self.makeTF.borderStyle = .roundedRect
        self.view.addSubview(self.makeTF)
        NSLayoutConstraint.activate([
            self.makeTF.heightAnchor.constraint(equalToConstant: 40),
            self.makeTF.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +20),
            self.makeTF.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +30),
            self.makeTF.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
        self.modelTF = UITextField()
        self.colourTF = UITextField()
        self.registrationTF = UITextField()
        
        self.modelTF.placeholder = "Model : "
        self.colourTF.placeholder = "Colour : "
        self.registrationTF.placeholder = "Registration : "
        
        self.addTextFieldToView(self.makeTF, self.modelTF)
        self.addTextFieldToView(self.modelTF, self.colourTF)
        self.addTextFieldToView(self.colourTF, self.registrationTF)
        

    }
    
    //Function to add textfields to view
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
    
    //Function to register the vehicle
    func registerVehicle() {
        if let user = theUser {
            print("USER SET")
            guard let make = self.makeTF.text else { return }
            guard let model = self.modelTF.text else { return }
            guard let colour = self.colourTF.text else  { return }
            guard let registration = self.registrationTF.text else { return }
            
            let vehicleDict : [String:Any] = ["email":user.email,"make":make,"model":model,"colour":colour,"registration":registration]
            VehicleService.instance.registerVehicle(vehicleDict: vehicleDict, handler: {(done) in
                if done {
                    
                    DispatchQueue.main.async {
                        self.displayAlert(title: "Vehicle Registration", message: "Vehicle registered successfully.")
                    }
                } else {

                    DispatchQueue.main.async {
                        self.displayAlert(title: "Vehicle Registration", message: "Vehicle registration failed, try again.")
                    }
                }
            })
            
        } else {
            print("USER NOT SET")
        }
    }
    
    
    //Function to show alert message
    func displayAlert(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Function to be called when done button is pressed
    @objc func doneButtonPressed(_ sender : Any) {
        print("***DONE BUTTON PRESSED")
        self.registerVehicle()
    }
    


}
