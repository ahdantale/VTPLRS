//
//  SettingsVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //Variables
    var settingsFields = ["Notification Frequency","Types of Notifications","About","Start/Stop Service"]
    var headingView : UIView!
    var headingLabel : UILabel!
    
    //Table view
    var settingsTableView : UITableView!
    
    //View function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.addHeading()
        self.addTableView()
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
        self.headingLabel.text = "SETTINGS"
        
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
    
    //Function to add table view
    func addTableView() {
        self.settingsTableView = UITableView(frame: .zero, style: .plain)
        self.settingsTableView.delegate = self
        self.settingsTableView.dataSource = self
        self.settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.settingsTableView)
        NSLayoutConstraint.activate([
            self.settingsTableView.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +10),
            self.settingsTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +10),
            self.settingsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.settingsTableView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: +0)
        ])
    }
    
    //TableViewDelegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.settingsFields[indexPath.row]
        return cell
    }
}
