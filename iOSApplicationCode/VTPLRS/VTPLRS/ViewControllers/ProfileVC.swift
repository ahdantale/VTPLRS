//
//  ProfileVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Variables
    var headingView : UIView!
    var headingLabel : UILabel!
    var profilePicture : UIImageView!
    var profileDetailsTableView : UITableView!
    var profileFields = ["Name :","Email ID :","Phone No. :","Age(OP) :","Sign Out"]
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.addHeading()
        self.addTableView()
        self.setUpProfileVC()
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
        self.headingLabel.text = "PROFILE"
        
        self.headingView.addSubview(self.headingLabel)
        self.headingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headingLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            self.headingLabel.heightAnchor.constraint(equalToConstant: 50),
            self.headingLabel.widthAnchor.constraint(equalToConstant: 100),
            self.headingLabel.centerXAnchor.constraint(equalTo: self.headingView.centerXAnchor, constant: +0),
            self.headingLabel.topAnchor.constraint(equalTo: self.headingView.topAnchor, constant: +15)
        ])
        
        //
        //DrawerButton
        self.profilePicture = UIImageView(frame: .zero)
        self.profilePicture.image = UIImage(named: "contgt")
        self.headingView.addSubview(self.profilePicture)
        self.profilePicture.contentMode = .scaleAspectFit
        self.profilePicture.translatesAutoresizingMaskIntoConstraints = false
        self.profilePicture.clipsToBounds = true
        self.profilePicture.layer.cornerRadius = 25
        
        NSLayoutConstraint.activate([
            self.profilePicture.heightAnchor.constraint(equalToConstant: 50),
            self.profilePicture.topAnchor.constraint(equalTo: self.headingView.topAnchor, constant: +15),
            self.profilePicture.widthAnchor.constraint(equalToConstant: 50),
            self.profilePicture.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        
    }
    
    //Function to add table view
    func addTableView() {
        self.profileDetailsTableView = UITableView(frame: .zero, style: .plain)
        self.profileDetailsTableView.delegate = self
        self.profileDetailsTableView.dataSource = self
        self.profileDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.profileDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.profileDetailsTableView)
        NSLayoutConstraint.activate([
            self.profileDetailsTableView.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +10),
            self.profileDetailsTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +10),
            self.profileDetailsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.profileDetailsTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    //TableViewDelegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.profileFields[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            let mainHomeVC = MainHomeVC()
            theUser = nil
            theDevice = nil
            theVehicle = nil
            mainHomeVC.modalPresentationStyle = .fullScreen
            self.present(mainHomeVC, animated: true, completion: nil)
        }
    }
    
    //Function to set up the view if the user is signed in
    func setUpProfileVC() {
        if let user = theUser {
            self.profileFields[0] = "Name : \(user.name)"
            self.profileFields[1] = "Email ID : \(user.email)"
            self.profileFields[2] = "Phone No : \(user.phoneNo)"
            self.profileFields[3] = "Age : \(user.age)"
            self.profileDetailsTableView.reloadData()
        }
    }
    

}
