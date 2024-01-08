//
//  VehicleService.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 05/05/21.
//  Copyright © 2021 Abhishek Dantale. All rights reserved.
//

import Foundation

class VehicleService {
    
    //URLs vehicle endpoints
    let hostName = "http://localhost:4000"
    let vehicleSubURL = "/vehicle"
    let getVehicleURL = "/getVehicle"
    let addVehicleURL = "/addVehicle"
    
    //Singleton instance
    static let instance = VehicleService()
    
    //Function to register vehicle
    func registerVehicle(vehicleDict : [String : Any], handler : @escaping (_ done : Bool)->()) {
        
        let registerVehicle = URL(string: self.hostName+self.vehicleSubURL+self.addVehicleURL)!
        var registerVehicleRequest = URLRequest(url: registerVehicle)
        registerVehicleRequest.httpMethod = "POST"
        registerVehicleRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let requestData = try? JSONSerialization.data(withJSONObject: vehicleDict, options: []) else {
            handler(false)
            return
        }
        
        registerVehicleRequest.httpBody = requestData
        
        let registerVehicleSession = URLSession.shared.dataTask(with: registerVehicleRequest, completionHandler: {(data,response,error) in
            if let error = error {
                print(error.localizedDescription)
                handler(false)
            } else {
                if let data = data {
                    if let dataString = String(data : data, encoding: .utf8) {
                        if dataString == "Vehicle added successfully" {
                            handler(true)
                        } else {
                            handler(false)
                        }
                    }
                } else {
                    print("@")
                    handler(false)
                }
            }
        })
        
        registerVehicleSession.resume()
        
    }
    
    //Function to get vehicle details
    func getVehicleDetails(emailDict : [String:Any], handler : @escaping(_ done : Bool, _ vehicle : Vehicle?)->()) {
        
        let getVehicleDetailsURL = URL(string: self.hostName + self.vehicleSubURL + self.getVehicleURL)!
        var getVehicleDetailsRequest = URLRequest(url: getVehicleDetailsURL)
        getVehicleDetailsRequest.httpMethod = "POST"
        getVehicleDetailsRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let requestData = try? JSONSerialization.data(withJSONObject: emailDict, options: []) else {
            handler(false,nil)
            return
        }
        
        getVehicleDetailsRequest.httpBody = requestData
        let getVehicleDetailsSession = URLSession.shared.dataTask(with: getVehicleDetailsRequest, completionHandler: {(data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                handler(false,nil)
            } else {
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let jsonDict = json as? [String:Any] {
                            guard let make = jsonDict["make"] as? String else { return }
                            guard let model = jsonDict["model"] as? String else { return }
                            guard let colour = jsonDict["colour"] as? String else { return }
                            guard let registration = jsonDict["registration"] as? String else { return }
                            guard let email = jsonDict["email"] as? String else { return }
                            
                            let vehicle = Vehicle(make: make, model: model, colour: colour, registration: registration, email: email)
                            handler(true,vehicle)
                            
                        } else {
                            handler(false,nil)
                        }
                    } else {
                        handler(false,nil)
                    }
                } else {
                    handler(false,nil)
                }
            }
        })
        
        getVehicleDetailsSession.resume()
        
    }
    
}
