//
//  InterviewsViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 6/29/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

class InterviewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var navigationButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    
    lazy var searchBar =  UISearchBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.placeholder = "Search"
        
        navigationItem.titleView = searchBar
        
        navigationButton.target = revealViewController()
        navigationButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.segmentedControl.tintColor = UIColor(red: CGFloat(0x5A)/255, green: CGFloat(0xC3)/255, blue: CGFloat(0xCA)/255, alpha: 1.0)
        profilePic.layer.cornerRadius = profilePic.frame.width/2
        profilePic.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let idetifier = "collectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idetifier, for: indexPath) as! InterviewCollectionViewCell
        cell.date.text = "26"
        
        return cell
    }

        /*   Select Item to display next Page */
/*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddInterview") as! AddInterviewViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
*/
    
}
