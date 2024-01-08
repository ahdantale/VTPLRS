//
//  MailerService.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 14/05/21.
//  Copyright © 2021 Abhishek Dantale. All rights reserved.
//

import Foundation


class MailerService {
    
    //Singleton instance
    static let instance = MailerService()
    
    //Variables for the URL
    let hostName = "http://localhost:4000"
    let subURL = "/mailer"
    let recoverPassword = "/recoverPassword"
    
    
    //Function to recover the password
    func recoverPassword(email : String, handler : @escaping (_ done : Bool)->()) {
        
        let queryString = "/?emailid=\(email)"
        let recoverPasswordURL = URL(string: self.hostName+self.subURL+self.recoverPassword+queryString)!
        var recoverPasswordRequest = URLRequest(url: recoverPasswordURL)
        recoverPasswordRequest.httpMethod = "GET"
        
        let recoverPasswordSession = URLSession.shared.dataTask(with: recoverPasswordRequest, completionHandler: { data,res,error in
            if let error = error {
                print(error.localizedDescription)
                handler(false)
            } else {
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let jsonDict = json as? [String:Any] {
                            if let emails = jsonDict["accepted"] as? [String] {
                                print(emails)
                                handler(true)
                            } else {
                                handler(false)
                            }
                        } else{
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
        
        recoverPasswordSession.resume()
        
    }
    
}
