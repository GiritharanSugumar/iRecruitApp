//
//  ProfilePage.swift
//  iRecruit
//
//  Created by Giritharan Sugumar on 9/7/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfilePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var profilePic: ImageRadius!
    
    var swiftyJSON : JSON = []
    var fields = ["Name:", "Company Name:", "Email ID:", "Role:", "Phone Number:"]
    var contentArray = ["", "", "", "", ""]
    var logInToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        /* Profile page Navigation */
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        /* Circle Image */
        profilePic.cornerRadius = profilePic.frame.width/2
        profilePic.clipsToBounds = true
    
    }
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Fields", for: indexPath) as! ProfilePageCell
        
        cell.headingLabel.text = fields[indexPath.row]
   
        if indexPath.row == 0 {
            cell.contentLabel.text = TokenStorage.shared.user["name"]
        } else if indexPath.row == 1 {
            cell.contentLabel.text = TokenStorage.shared.user["companyName"]
        } else if indexPath.row == 2 {
            cell.contentLabel.text = TokenStorage.shared.user["email"]
        } else if indexPath.row == 3 {
            cell.contentLabel.text = TokenStorage.shared.user["role"]
        } else if indexPath.row == 4 {
            cell.contentLabel.text = TokenStorage.shared.user["phone"]
        }

        return cell
    }
    
   }

