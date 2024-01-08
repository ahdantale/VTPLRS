//
//  DeviceService.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 05/05/21.
//  Copyright © 2021 Abhishek Dantale. All rights reserved.
//

import Foundation

class DeviceService {
    
    let hostName = "http://localhost:4000/device"
    let registerDeviceURL = "/registerDevice"
    let getDeviceURL = "/getDeviceInfo"
    
    static let instance = DeviceService()
    
    //Function to register the device
    func registerDevice(deviceDict : [String : String], handler : @escaping(_ done : Bool)->()) {
        
        
        let registerDeviceURL = URL(string: hostName + self.registerDeviceURL)!
        var registerDeviceURLRequest = URLRequest(url: registerDeviceURL)
        registerDeviceURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        registerDeviceURLRequest.httpMethod = "POST"
        
        guard let dataForRequest = try? JSONSerialization.data(withJSONObject: deviceDict, options: []) else {
            print("Converting to json failed")
            handler(false)
            return
        }
        
        registerDeviceURLRequest.httpBody = dataForRequest
        
        let registerDeviceSession = URLSession.shared.dataTask(with: registerDeviceURLRequest, completionHandler: {(data,response,error) in
            if let error = error {
                print(error.localizedDescription)
                handler(false)
            } else {
                if let data = data {
                    if let dataString = String(data: data, encoding: .utf8) {
                        if dataString == "Device registered successfully" {
                            print("Done")
                            handler(true)
                        } else {
                            print(dataString)
                            handler(false)
                        }
                        
                    } else{
                        handler(false)
                    }
                } else {
                    handler(false)
                }
            }
        })
        
        registerDeviceSession.resume()
        
        
    }
    
    //Function to fetch the device details
    func getDeviceDetailsForUser(emailDict : [String:Any],handler : @escaping(_ done : Bool, _ theDevice : Device?)->()) {
    
        let getDeviceDetailsURL = URL(string: "http://localhost:4000/device/getDeviceInfo")!
        var getDeviceDetailsRequest = URLRequest(url: getDeviceDetailsURL)
        getDeviceDetailsRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let jsonRequest = try? JSONSerialization.data(withJSONObject: emailDict, options: []) else {
            handler(false,nil)
            return
        }
            
        getDeviceDetailsRequest.httpMethod = "POST"
        getDeviceDetailsRequest.httpBody = jsonRequest
        
        var getDeviceDetailsSession = URLSession.shared.dataTask(with: getDeviceDetailsRequest, completionHandler: { (data,res,error) in
            
            if let error = error {
                print(error.localizedDescription)
                handler(false,nil)
            } else {
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let jsonDict = json as? [String:Any] {
                            guard let deviceId = jsonDict["deviceId"] as? String else { return }
                            guard let email = jsonDict["email"] as? String else { return }
                            
                            let aDevice = Device(deviceId: deviceId, email: email)
                            print(aDevice)
                            handler(true,aDevice)
                        } else {
                            handler(false,nil)
                        }
                    } else {
                        handler(false, nil)
                    }
                } else {
                    handler(false,nil)
                }
            }
            
        })
        
        getDeviceDetailsSession.resume()
        
    }
    
    
    
}
