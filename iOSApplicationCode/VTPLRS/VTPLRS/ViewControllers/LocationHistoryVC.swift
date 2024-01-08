//
//  LocationHistoryVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit
import MapKit

class LocationHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    //Array for locations
    var locations = [Location]()
    var addresses = [String]()
    
    //Variable for the MKAnnotation
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 18.5204, longitude: 73.8567)
    
    //Variable for the heading view
    var viewOptions : UISegmentedControl!
    var headingView : UIView!
    var locationHistoryTableView : UITableView!
    var vehicleLocationMap : MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.addHeading()
        self.addLocationHistoryTableView()
        self.addMapView()
        
        //Calling function to get location from the server
        if let user = theUser {
            if let device = theDevice {
                let deviceDict = ["deviceId":device.deviceId]
                LocationService.instance.getLocationForDevice(forDevice: deviceDict, handler: { (done,locs) in
                    if(true) {
                        self.locations = locs
                        let lastLocation = self.locations.last
                        DispatchQueue.main.async {
                            self.locationRelatedFunctions(locations: self.locations)
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
                let deviceDict = ["deviceId":device.deviceId]
                LocationService.instance.getLocationForDevice(forDevice: deviceDict, handler: { (done,locs) in
                    if(true) {
                        self.locations = locs
                        let lastLocation = self.locations.last
                        DispatchQueue.main.async {
                            self.locationRelatedFunctions(locations: self.locations)
                        }
                        
                    }
                })
            }

        }
    }
    
    //Function to add heading view
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
        
        //SegmentedControl
        self.viewOptions = UISegmentedControl(items: ["List View", "Map View"])
        self.headingView.addSubview(self.viewOptions)
        self.viewOptions.selectedSegmentIndex = 0
        self.viewOptions.translatesAutoresizingMaskIntoConstraints = false
        self.viewOptions.addTarget(self, action: #selector(self.segmentSelected(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            self.viewOptions.heightAnchor.constraint(equalToConstant: 50),
            self.viewOptions.widthAnchor.constraint(equalToConstant: 200),
            self.viewOptions.centerXAnchor.constraint(equalTo: self.headingView.centerXAnchor, constant: +0),
            self.viewOptions.topAnchor.constraint(equalTo: self.headingView.topAnchor, constant: +15)
        ])
    
    }
   
    
    @objc func segmentSelected(_ sender : UISegmentedControl){
        switch self.viewOptions.selectedSegmentIndex {
        case 0:
            //self.view.backgroundColor = UIColor.red
            self.locationHistoryTableView.isHidden = false
            self.vehicleLocationMap.isHidden = true
        case 1:
            //self.view.backgroundColor = UIColor.blue
            self.vehicleLocationMap.isHidden = false
            self.locationHistoryTableView.isHidden = true
            self.markLocationsOnMap(locations: self.locations)
        default: print("Default")
        }
    }
    
    //Function to add locationHistoryTableView
    func addLocationHistoryTableView() {
        self.locationHistoryTableView = UITableView(frame: .zero)
        self.locationHistoryTableView.delegate = self
        self.locationHistoryTableView.dataSource = self
        self.locationHistoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.locationHistoryTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.locationHistoryTableView)
        
        
        
        NSLayoutConstraint.activate([
            self.locationHistoryTableView.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +20),
            self.locationHistoryTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +10),
            self.locationHistoryTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.locationHistoryTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    //Function to add map view to the view controller
    func addMapView() {
        self.vehicleLocationMap = MKMapView()
        self.vehicleLocationMap.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.vehicleLocationMap)
        self.vehicleLocationMap.clipsToBounds = true
        self.vehicleLocationMap.layer.masksToBounds = true
        self.vehicleLocationMap.layer.cornerRadius = 120 * 0.25
        NSLayoutConstraint.activate([
            self.vehicleLocationMap.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +40),
            self.vehicleLocationMap.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +20),
            self.vehicleLocationMap.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.vehicleLocationMap.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
        self.vehicleLocationMap.isHidden = true
        self.vehicleLocationMap.delegate = self
        self.vehicleLocationMap.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "test")
    }
    
    //Table view delegate functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = self.locations[indexPath.row].address ?? "Adress not generated"
        return cell
    }
    
    //Function to mark the location on the map
    func locationRelatedFunctions(locations : [Location]) {
        
        for locationIndex in 0..<locations.count {
            let aLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: locations[locationIndex].lat)!, longitude: CLLocationDegrees(exactly: locations[locationIndex].long)!)
            
            //Test code to get address from location
            var geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(CLLocation(latitude: aLocation.latitude, longitude: aLocation.longitude), completionHandler: { places,error in
                if let error = error {
                
                    print(error.localizedDescription)
                } else {
                    if let places = places {
                        let aPlace = places[0]
                        
                        guard let subLocality = aPlace.subLocality else { return }
                        guard let locality = aPlace.locality else { return }
                        guard let country = aPlace.country else { return }
                        guard let pinCode = aPlace.postalCode else { return }
                        
                        self.locations[locationIndex].address = "\(subLocality), \(locality), \(country), \(pinCode)"
                       
                        DispatchQueue.main.async {
                            self.locationHistoryTableView.reloadData()
                        }
                    }
                }
            })
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
    
    //Function to mark location on the map
    func markLocationsOnMap(locations : [Location]) {
        for loc in locations {
            var pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: loc.lat)!, longitude: CLLocationDegrees(exactly: loc.long)!)
            pointAnnotation.title = loc.address ?? "ANA"
            self.vehicleLocationMap.addAnnotation(pointAnnotation)
            let region = MKCoordinateRegion(center: pointAnnotation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            self.vehicleLocationMap.setRegion(region, animated: true)
        }
    }
}
