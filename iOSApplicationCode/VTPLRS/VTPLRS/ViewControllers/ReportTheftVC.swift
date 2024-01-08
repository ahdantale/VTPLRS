//
//  ReportTheftVC.swift
//  VTPLRS
//
//  Created by Abhishek Dantale on 20/11/20.
//  Copyright © 2020 Abhishek Dantale. All rights reserved.
//

import UIKit
import QuickLook

class ReportTheftVC: UIViewController, UITableViewDelegate, UITableViewDataSource, QLPreviewControllerDataSource {

    //Variables
    var reportTheftFields = ["F.I.R Format", "Complaint Format", "Police Phone No."]
    var headingView : UIView!
    var headingLabel : UILabel!
    var helpDetailsTableView : UITableView!
    var qlPreviewController = QLPreviewController()
    var fileURL : URL?
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemBackground
        self.addHeading()
        self.addTableView()
        self.qlPreviewController.dataSource = self
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
        self.headingLabel.text = "REPORT THEFT"
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
    func addTableView() {
        self.helpDetailsTableView = UITableView(frame: .zero, style: .plain)
        self.helpDetailsTableView.delegate = self
        self.helpDetailsTableView.dataSource = self
        self.helpDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.helpDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.helpDetailsTableView)
        NSLayoutConstraint.activate([
            self.helpDetailsTableView.topAnchor.constraint(equalTo: self.headingView.bottomAnchor, constant: +10),
            self.helpDetailsTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: +10),
            self.helpDetailsTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.helpDetailsTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    //TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportTheftFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.reportTheftFields[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 || indexPath.row == 0 {
            PayloadService.instance.downloadPDFFile(handler: {(done,url) in
                if done{
                    if let url = url {
                        DispatchQueue.main.async {
                            
                            self.fileURL = url
                            self.present(self.qlPreviewController, animated: true, completion: nil)
//                            let fileVC = UIActivityViewController(activityItems: [url], applicationActivities: [])
//                            self.present(fileVC, animated: true, completion: nil)
                        }
                    }
                }
            })
        }
        
        if indexPath.row == 2 {
            self.displayPolicePhoneNumber()
        }
    }
    
    //Function to display police phone number as an alert view controller
    func displayPolicePhoneNumber() {
        let alertController = UIAlertController(title: "Police Phone Number", message: "100", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //DataSource methods for ql preview delegate
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.fileURL as! QLPreviewItem
    }
    
    
}
