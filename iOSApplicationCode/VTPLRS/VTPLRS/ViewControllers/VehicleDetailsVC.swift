//
//  VehicleDetailsVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit

class VehicleDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //VehicleDetailFields
    var vehicleDetailsField = ["Make : ","Model : ","Colour : ","Registration : "]
    
    //Variables
    var headingView : UIView!
    var headingLabel : UILabel!
    var vehicleDetailsTableView : UITableView!
    var photoCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.addHeading()
        self.addVehicleDetailsTableView()
        self.addCollectionView()
        if let user = theUser {
            let emailDict : [String : Any] = ["email":user.email]
            VehicleService.instance.getVehicleDetails(emailDict: emailDict, handler: { (done,vehicle) in
                if done {
                    if let vehicle = vehicle {
                        theVehicle = vehicle
                        self.vehicleDetailsField[0] = "Make : \(vehicle.make)"
                        self.vehicleDetailsField[1] = "Model : \(vehicle.model)"
                        self.vehicleDetailsField[2] = "Colour : \(vehicle.colour)"
                        self.vehicleDetailsField[3] = "Registration : \(vehicle.registration)"
                        DispatchQueue.main.async {
                            self.vehicleDetailsTableView.reloadData()
                        }
                    }
                }
            })
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let user = theUser {
            let emailDict : [String : Any] = ["email":user.email]
            VehicleService.instance.getVehicleDetails(emailDict: emailDict, handler: { (done,vehicle) in
                if done {
                    if let vehicle = vehicle {
                        theVehicle = vehicle
                        self.vehicleDetailsField[0] = "Make : \(vehicle.make)"
                        self.vehicleDetailsField[1] = "Model : \(vehicle.model)"
                        self.vehicleDetailsField[2] = "Colour : \(vehicle.colour)"
                        self.vehicleDetailsField[3] = "Registration : \(vehicle.registration)"
                        DispatchQueue.main.async {
                            self.vehicleDetailsTableView.reloadData()
                        }
                    }
                }
            })
        }
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
         self.headingLabel.text = "VEHICLE DETAILS"
         self.headingLabel.adjustsFontSizeToFitWidth = true
         self.headingLabel.minimumScaleFactor = 0.5
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
    func addVehicleDetailsTableView() {
        self.vehicleDetailsTableView = UITableView(frame: .zero)
        self.vehicleDetailsTableView.delegate = self
        self.vehicleDetailsTableView.dataSource = self
        self.vehicleDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.vehicleDetailsTableView)
        self.vehicleDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            self.vehicleDetailsTableView.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +10),
            self.vehicleDetailsTableView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10),
            self.vehicleDetailsTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +10),
            self.vehicleDetailsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    //Function to add collection view
    func addCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 120, height: 150)
        self.photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.isScrollEnabled = true
        self.view.addSubview(self.photoCollectionView)
        self.photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.photoCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collcell")
        
        NSLayoutConstraint.activate([
            self.photoCollectionView.topAnchor.constraint(equalTo: self.vehicleDetailsTableView.bottomAnchor, constant: +30),
            self.photoCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +10),
            self.photoCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.photoCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    //Table View Delegate functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vehicleDetailsField.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.vehicleDetailsField[indexPath.row]
        return cell
    }
    
    //Collection view delegate functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collcell", for: indexPath)
        let imageView = UIImageView(image: UIImage(named: "contgt"))
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        return cell
    }

}
