//
//  PayloadService.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 05/05/21.
//  Copyright © 2021 Abhishek Dantale. All rights reserved.
//

import Foundation

class PayloadService {
    
    //URLs
    let hostname = "http://localhost:4000"
    let payloadSubURL = "/payload"
    let getComplaintFormatURL = "/getComplaintFormat"
    
    //Singleton instance
    static let instance = PayloadService()
    
    //Function to download the pdf file
    func downloadPDFFile(handler : @escaping (_ done : Bool, _ url : URL?)->()) {
        
        let getComplaintFormatURL = URL(string: self.hostname + self.payloadSubURL + self.getComplaintFormatURL)!
        var getComplaintFormatURLRequest = URLRequest(url: getComplaintFormatURL)
        getComplaintFormatURLRequest.httpMethod = "GET"
        
        let downloadTask = URLSession.shared.downloadTask(with: getComplaintFormatURLRequest, completionHandler: {(url,urlResponse,error) in
            
            do {
                
                let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let savedURL = documentsURL.appendingPathComponent("complaintformat"+".pdf")
                print(savedURL.path)
                if FileManager.default.fileExists(atPath: savedURL.path) {
                    print("FILE EXISTS")
                    handler(true,savedURL)
                } else {
                    if let error = error {
                        print(error.localizedDescription)
                        handler(false,nil)
                    } else {
                        if let url = url {
                            do {
                                let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                                print("URL LAST PATH")
                                print(url.lastPathComponent)
                                let savedURL = documentsURL.appendingPathComponent("complaintformat" + ".pdf")
                                try FileManager.default.moveItem(at: url, to: savedURL)
                                handler(true,savedURL)
                            } catch {
                                print("file error : \(error)")
                            }
                        }
                    }
                }
                
            } catch {
                print(error)
            }
            
            

        })
        
        downloadTask.resume()
        
    }
    
}
