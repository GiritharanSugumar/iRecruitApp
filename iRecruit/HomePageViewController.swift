//
//  HomePageViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 6/28/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    
     //   profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.layer.cornerRadius = profileImage.frame.height/2
       // profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
