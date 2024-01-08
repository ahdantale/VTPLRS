//
//  MainHomeVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class MainHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Variables
    var headingView : UIView!
    var headingLabel : UILabel!
    var menuTableView : UITableView!
    var menuOptions = ["Sign-In","Register"]
    var menuViewControllers = [SignInVC(),RegisterVC()]
    var recoverPasswordButton : UIButton!
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.addHeading()
        self.addTableView()
        self.addRecoverPassword()
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
        self.headingLabel.text = "_V_T_P_L_R_S_"
        
        self.headingView.addSubview(self.headingLabel)
        self.headingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.headingLabel.textAlignment = .center
        self.headingLabel.adjustsFontSizeToFitWidth = true
        self.headingLabel.minimumScaleFactor = 0.5
        
        NSLayoutConstraint.activate([
            self.headingLabel.heightAnchor.constraint(equalToConstant: 50),
            self.headingLabel.widthAnchor.constraint(equalToConstant: 100),
            self.headingLabel.centerXAnchor.constraint(equalTo: self.headingView.centerXAnchor, constant: +0),
            self.headingLabel.topAnchor.constraint(equalTo: self.headingView.topAnchor, constant: +15)
        ])
        
    }
    
    //AddingTableView
    func addTableView() {
        self.menuTableView = UITableView(frame: .zero, style: .plain)
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.menuTableView)
        self.menuTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.menuTableView.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +30),
            self.menuTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +30),
            self.menuTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            self.menuTableView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    //AddingRecoverPasswordButton
    func addRecoverPassword() {
        self.recoverPasswordButton = UIButton(frame: .zero)
        self.recoverPasswordButton.setTitle("Recover Password", for: .normal)
        self.recoverPasswordButton.setTitleColor(UIColor.systemBlue, for: .normal)
        self.recoverPasswordButton.backgroundColor = UIColor.clear
        self.recoverPasswordButton.addTarget(self, action: #selector(self.recoverButtonPressed(_:)), for: .touchUpInside)
        self.recoverPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.recoverPasswordButton)
        NSLayoutConstraint.activate([
            self.recoverPasswordButton.topAnchor.constraint(equalTo: self.menuTableView.bottomAnchor, constant: +40),
            self.recoverPasswordButton.leadingAnchor.constraint(equalTo: self.menuTableView.leadingAnchor, constant: +0),
            self.recoverPasswordButton.trailingAnchor.constraint(equalTo: self.menuTableView.trailingAnchor, constant: +0),
            self.recoverPasswordButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    //TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = self.menuOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(self.menuViewControllers[indexPath.row], animated: true, completion: nil)
    }
    
    @objc func recoverButtonPressed(_ sender : Any) {
        self.present(RecoverPasswordVC(), animated: true, completion: nil)
    }
}
