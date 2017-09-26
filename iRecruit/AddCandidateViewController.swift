//
//  AddCandidateViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/7/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddCandidateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, candidateDelegates, CandidateExperienceDelegate {

    let candidateDetails = ["Candidate Name", "Position", "Phone Number", "Email ID", "Skills"]
    var candidateText = ["","","","",""]

    var experienceMonth = 0
    var experienceYear = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let interviewId = ContainerViewController.id.receivedInterviewID

        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return candidateDetails.count
        } else {
        return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "candidate", for: indexPath) as! AddCanditateCell

        cell.candidateDelegate = self
        cell.headLabel.text = candidateDetails[indexPath.row]
        cell.textEnter.text = candidateText[indexPath.row]
        cell.showCandidates(labelFields: candidateDetails[indexPath.row], candidateText: candidateText[indexPath.row], tag: indexPath.row)
        print(candidateText[indexPath.row])
        return cell
        } else  {
         let experienceCell = tableView.dequeueReusableCell(withIdentifier: "experience", for: indexPath) as! CandidateExperienceTableViewCell
            return experienceCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 140
        } else {
            return 80
        }
    }
    func candidate(text: String, tagValue: Int) {
        candidateText[tagValue] = text
    }
    
    func sendYear(year: Int) {
        experienceYear = year
    }
    
    func sendMonth(month: Int) {
        experienceMonth = month
    }
    @IBAction func saveCandidateBtn(_ sender: Any) {
        print(candidateText)
        
        addCandidateApi()
    }
    
    func addCandidateApi() {
        
        let receivedToken = TokenStorage.shared.token
        let headers: HTTPHeaders = ["Authorization": receivedToken]
        let candidatesFields = [""]
    }
   
}
