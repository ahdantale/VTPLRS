//
//  ViewController.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, MKMapViewDelegate {
    
    //Array for locations
    var locations = [Location]()
    
    
    //Array for the drawer
    var drawerItems = ["Location History", "Vehicle Details", "Settings", "Profile", "Report Theft","Register Vehicle"]
    var drawerViewControllers = [LocationHistoryVC(),VehicleDetailsVC(),SettingsVC(),ProfileVC(),ReportTheftVC(),RegisterVehicleVC()]
    
    //Variables
    var headingView : UIView!
    var headingLabel : UILabel!
    var drawerButton : UIButton!
    var drawerTableView : UITableView!
    var vehicleLocationMap : MKMapView!
    
    //Function called when view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.addHeading()
        self.addMapView()
        self.addDrawerTableView()
        
        //Calling function to get location from the server
        if let user = theUser {
            if let device = theDevice {
                let deviceDict = ["deviceId": device.deviceId]
                LocationService.instance.getLocationForDevice(forDevice: deviceDict, handler: { (done,locs) in
                    if(true) {
                        self.locations = locs
                        let lastLocation = self.locations.last
                        DispatchQueue.main.async {
                            if let _ = lastLocation {
                                self.mapRelatedFunctions(locationToBePinned: lastLocation!)
                            }
                            
                        }
                        
                    }
                })
            }

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //Calling function to get location from the server
        if let user = theUser {
            if let device = theDevice {
                let deviceDict = ["deviceId": device.deviceId]
                LocationService.instance.getLocationForDevice(forDevice: deviceDict, handler: { (done,locs) in
                    if(true) {
                        self.locations = locs
                        let lastLocation = self.locations.last
                        DispatchQueue.main.async {
                            if let _ = lastLocation {
                                self.mapRelatedFunctions(locationToBePinned: lastLocation!)
                            }
                        }
                        
                    }
                })
            }

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
        self.headingLabel.text = "HOME"
        
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
        self.drawerButton = UIButton(type: .infoLight)
        
        self.headingView.addSubview(self.drawerButton)
        self.drawerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.drawerButton.heightAnchor.constraint(equalToConstant: 50),
            self.drawerButton.topAnchor.constraint(equalTo: self.headingView.topAnchor, constant: +15),
            self.drawerButton.widthAnchor.constraint(equalToConstant: 25),
            self.drawerButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        
        self.drawerButton.addTarget(self, action: #selector(self.drawerButtonPressed(_:)), for: .touchUpInside)
    }
    
    
    //Function to add drawer table view
    func addDrawerTableView() {
        self.drawerTableView = UITableView(frame: .zero)
        
        self.drawerTableView.delegate = self
        self.drawerTableView.dataSource = self
        
        self.drawerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(self.drawerTableView)
        self.drawerTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.drawerTableView.topAnchor.constraint(equalTo: self.headingLabel.bottomAnchor, constant: +5),
            self.drawerTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: +0),
            self.drawerTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: +0),
            self.drawerTableView.widthAnchor.constraint(equalToConstant: 200)
        ])
        self.drawerTableView.isHidden = true
    }
    
    //Function to add map view to the view controller
    func addMapView() {
        self.vehicleLocationMap = MKMapView()
        self.vehicleLocationMap.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.vehicleLocationMap)
        self.vehicleLocationMap.clipsToBounds = true
        self.vehicleLocationMap.layer.masksToBounds = true
        self.vehicleLocationMap.layer.cornerRadius = 120 * 0.25
        self.vehicleLocationMap.delegate = self
        NSLayoutConstraint.activate([
            self.vehicleLocationMap.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +40),
            self.vehicleLocationMap.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +20),
            self.vehicleLocationMap.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.vehicleLocationMap.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
        self.vehicleLocationMap.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "test")
        
        
    }
    
    
    //Table View Delegate Function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drawerItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.drawerItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(self.drawerViewControllers[indexPath.row], animated: true, completion: nil)
    }
    
    //Drawer button function
    @objc func drawerButtonPressed(_ sender : Any) {
        if self.drawerTableView.isHidden {
            self.drawerTableView.isHidden = false
        } else {
            self.drawerTableView.isHidden = true
        }
    }
    
    //Delegate function of map view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView : MKPinAnnotationView?
        annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "test") as! MKPinAnnotationView
        annotationView?.annotation = annotation
        annotationView?.canShowCallout = true
        return annotationView
    }
    
    //Function to iniate the mkpointannotation
    func mapRelatedFunctions(locationToBePinned : Location) {
        var lastPointAnnotation = MKPointAnnotation()
        lastPointAnnotation.coordinate =  CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: locationToBePinned.lat)!, longitude: CLLocationDegrees(exactly: locationToBePinned.long)!)
       
        //Test code to get address from location
        var geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: lastPointAnnotation.coordinate.latitude, longitude: lastPointAnnotation.coordinate.longitude), completionHandler: { places,error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let places = places {
                    let aPlace = places[0]
                    
                    guard let subLocality = aPlace.subLocality else { return }
                    guard let locality = aPlace.locality else { return }
                    guard let country = aPlace.country else { return }
                    guard let pinCode = aPlace.postalCode else { return }
                    
                    let address = "\(subLocality), \(locality), \(country), \(pinCode)"
                    lastPointAnnotation.title = address
                    lastPointAnnotation.subtitle = "Last Known Location"
                           
                    var region = MKCoordinateRegion(center: lastPointAnnotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
                           
                    DispatchQueue.main.async {
                        self.vehicleLocationMap.setCenter(lastPointAnnotation.coordinate, animated: true)
                        self.vehicleLocationMap.setRegion(region, animated: true)
                        self.vehicleLocationMap.addAnnotation(lastPointAnnotation)
                        self.vehicleLocationMap.selectAnnotation(lastPointAnnotation, animated: true)
                    }
                    
                           
                }
            }
        })
        
        
    }
}

