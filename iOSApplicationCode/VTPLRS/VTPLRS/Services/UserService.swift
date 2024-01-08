//
//  UserService.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 05/05/21.
//  Copyright © 2021 Abhishek Dantale. All rights reserved.
//

import Foundation

class UserDataService {
    
    let hostName = "http://localhost:4000/user"
    let getUserDataURL = "/getUser"
    let loginUserURL = "/loginUser"
    let createUser = "/createUser"

    
    static let instance = UserDataService()
    
    //Function to login user
    func loginUser(userDict : [String : Any], handler: @escaping(_ done : Bool,_ user : User?)->()) {
        
        let loginUserURL = URL(string: self.hostName+self.loginUserURL)!
        var loginUserRequest = URLRequest(url: loginUserURL)
        loginUserRequest.httpMethod = "POST"
        loginUserRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let jsonForRequest = try? JSONSerialization.data(withJSONObject: userDict, options: []) else {
            handler(false,nil)
            return
        }
        
        loginUserRequest.httpBody = jsonForRequest
        
        let loginUserSession = URLSession.shared.dataTask(with: loginUserRequest, completionHandler: {(data,response,error) in
            if let error = error {
                print(error.localizedDescription)
                handler(false,nil)
            } else {
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let jsonDict = json as? [String:Any] {
                            guard let name = jsonDict["name"] as? String else { print("1");return }
                            guard let email = jsonDict["email"] as? String else { print("2");return }
                            guard let phoneNo = "\(jsonDict["phoneNo"])" as? String else { return }
                            guard let age = jsonDict["age"] as? Int else { print("4");return }
                            
                            let anUser = User(name: name, phoneNo: phoneNo, email: email, age: age)
                            print(jsonDict)
                            handler(true,anUser)
                            
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
        
        loginUserSession.resume()
        
    }
    
    
    //Function to get user data
    func getUserData(email : String, handler : @escaping(_ done : Bool,_ user : User?)->()) {
        
        let getUserDataURL = URL(string: self.hostName+self.getUserDataURL)!
        var getUserDataRequest = URLRequest(url: getUserDataURL)
        getUserDataRequest.httpMethod = "POST"
        getUserDataRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestDict : [String : String] = [ "email" : email ]
        guard let jsonForRequest = try? JSONSerialization.data(withJSONObject: requestDict, options: []) else {
            print("not done")
            handler(false,nil)
            return
        }
        getUserDataRequest.httpBody = jsonForRequest
        
        let getUserDataSession = URLSession.shared.dataTask(with: getUserDataRequest, completionHandler: { (data,response,error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let data = data {
                    if let jsonFromData = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let jsonDict = jsonFromData as? [String:Any] {
                            guard let name = jsonDict["name"] as? String else { return }
                            guard let email = jsonDict["email"] as? String else { return }
                            guard let age = jsonDict["age"] as? Int else { return }
                            guard let phoneNo = jsonDict["phoneNo"] as? String else { return }
                            let theUser = User(name: name, phoneNo: phoneNo, email: email, age: age)
                            handler(true,theUser)
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
        
        getUserDataSession.resume()
    }
    
    //Function to create user
    func createUser(userDict : [String : Any], handler : @escaping(_ done : Bool)->()) {
        
        let createUserURL = URL(string: self.hostName + self.createUser)!
        var createUserURLRequest = URLRequest(url: createUserURL)
        createUserURLRequest.httpMethod = "POST"
        createUserURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let requestData = try? JSONSerialization.data(withJSONObject: userDict, options: []) else {
            handler(false)
            return
        }
        
        createUserURLRequest.httpBody = requestData
        let createUserURLSession = URLSession.shared.dataTask(with: createUserURLRequest, completionHandler: {(data,response,error) in
            if let error = error {
                print(error.localizedDescription)
                handler(false)
            } else {
                if let data = data {
                    if let dataString = String(data: data, encoding: .utf8) {
                        if dataString == "User created successfully" {
                            print("CREATED USER SUCCESSFULLY")
                            handler(true)
                        } else  {
                            handler(false)
                        }
                    } else {
                        handler(false)
                    }
                } else {
                    handler(false)
                }
            }
        })
        
        createUserURLSession.resume()
    }
}
