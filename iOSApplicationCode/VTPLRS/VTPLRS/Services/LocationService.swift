//
//  LocationService.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 13/05/21.
//  Copyright © 2021 Abhishek Dantale. All rights reserved.
//

import Foundation

class LocationService {
    
    //Singleton instance
    static let instance = LocationService()
    
    //Routes for the location service on the server
    let homeURL = "http://localhost:4000"
    let locationSubURL = "/location"
    let getLocationsForDeviceRelativeURL = "/getLocationForDevice"
    
    //Function to get the location from the web-server
    func getLocationForDevice(forDevice : [String:Any],handler : @escaping (_ done : Bool,_ locations : [Location])->()) {
        
        let getLocationURL = URL(string: homeURL+locationSubURL+getLocationsForDeviceRelativeURL)!
        var getLocationRequest = URLRequest(url: getLocationURL)
        getLocationRequest.httpMethod = "POST"
        getLocationRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let requestJSON = try? JSONSerialization.data(withJSONObject: forDevice, options: []) else {
            return
        }
        
        getLocationRequest.httpBody = requestJSON
        
        var getLocationSession = URLSession.shared.dataTask(with: getLocationRequest, completionHandler: {(data,res,error) in
            
            if let error = error {
                print(error.localizedDescription)
                handler(false,[])
            } else {
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let jsonDict = json as? [[String:Any]] {
                            var locations = [Location]()
                            for i in jsonDict {
                                
                                guard let lat = i["lat"] as? String else { return }
                                guard let long = i["long"] as? String else { return }
                                guard let deviceId = i["deviceId"] as? String else { return }
                                guard let timestamp = i["timeStamp"] as? String else { return }
                                
                                guard let numericLat = Double(lat) else { return }
                                guard let numericLong = Double(long) else { return }
                                
                                let aLocation = Location(lat: numericLat, long: numericLong, deviceId: deviceId, timeStamp: timestamp)
                                locations.append(aLocation)
                                
                            }
                            handler(true,locations)
                        } else {
                            handler(false,[])
                        }
                    } else {
                        handler(false,[])
                    }
                } else {
                    handler(false,[])
                }
            }
            
        })
        
        getLocationSession.resume()
        
        
    }
    
}
