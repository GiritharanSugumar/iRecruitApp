//
//  MenuViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 6/29/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
//    let menuItems = ["INTERVIEWS" , "INTERVIEWERS" , "STATUS", "PROFILE"]
    var menuItems = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Crop Image
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.clipsToBounds = true

  //      profileImage.layer.borderWidth = 3.0
  //      profileImage.layer.borderColor = UIColor.white as? CGColor
        
        
        profileNameLabel.font = Style.sectionHeaderTitleFont
        profileNameLabel.text = TokenStorage.shared.user["name"]
        
        
        //Adjust the width of the slide menu
        //       self.revealViewController().rearViewRevealWidth = 62
       menuItemList()
    }

    func menuItemList() {
        
        guard let user = TokenStorage.shared.user["role"] else {
            return
        }
        if user == "admin" {
          menuItems = ["INTERVIEWS" , "INTERVIEWERS" , "STATUS", "PROFILE"]
            
        } else if user == "interviewer" {
         menuItems = ["INTERVIEWS", "PROFILE"]
        }
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        
        let userDefault = UserDefaults.standard
        userDefault.set(false, forKey: "IsLogin")

        self.present(destinationViewController, animated: true, completion:nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "menuCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MenuTableViewCell
                cell.menuLabelFields.text = menuItems[indexPath.row]
            return cell
    }
   
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let revealViewController:SWRevealViewController = self.revealViewController()
    let cell:MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
    
    if cell.menuLabelFields.text == "PROFILE" {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController = mainStoryBoard.instantiateViewController(withIdentifier: "Profile") as! ProfilePage
        let newFrontViewController = UINavigationController.init(rootViewController: destinationViewController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
    
    }
      else if cell.menuLabelFields.text == "INTERVIEWS" {
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController = mainStoryboard.instantiateViewController(withIdentifier: "Interviews") as! InterviewsViewController
        let newFrontViewController = UINavigationController.init(rootViewController:destinationViewController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        newFrontViewController.topViewController?.title = "Interviews"
        
    } else if cell.menuLabelFields.text == "INTERVIEWERS" {
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController = mainStoryBoard.instantiateViewController(withIdentifier: "InterViewer") as! InterViewerViewController
        let newFrontViewController  = UINavigationController.init(rootViewController:destinationViewController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        newFrontViewController.topViewController?.title = "Interviewers"
    } else if cell.menuLabelFields.text == "STATUS" {
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationViewController = mainStoryBoard.instantiateViewController(withIdentifier: "Status") as! StatusTableViewController
        let newFrontViewController  = UINavigationController.init(rootViewController:destinationViewController)
        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        newFrontViewController.topViewController?.title = "Status"
    
    }
}
    

}
