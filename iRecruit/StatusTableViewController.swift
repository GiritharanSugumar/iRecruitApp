//
//  StatusTableViewController.swift
//  iRecruit
//
//  Created by Giritharan Sugumar on 8/22/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

class StatusTableViewController: UITableViewController {

    
    var sections = ["Ongoing", "Upcoming", "Finished"]
    var roundForOngoingSection = [Int]()
    var roundForUpcomingSection = [Int]()
    var roundForFinishedSection = [Int]()
    var upComingInterviews = [String]()
    var onGingInterviews = [String]()
    var finishedInterviews = [String]()

    @IBOutlet weak var navigationButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationButton.target = revealViewController()
        navigationButton.action = #selector(SWRevealViewController.revealToggle(_:))
        apiFields()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if section == 0 {
            return roundForOngoingSection.count
        } else if section == 1 {
            return roundForUpcomingSection.count
        } else {
            return roundForFinishedSection.count
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell", for: indexPath) as! StatusTableViewCell
        if indexPath.section == 0 {
            cell.headerLbl.text = onGingInterviews[indexPath.row]
            cell.statusLbl.text = "\(String(roundForOngoingSection[indexPath.row])) Rounds Completed"
            cell.doneLabel.isHidden = true
        } else if indexPath.section == 1 {
            cell.headerLbl.text = upComingInterviews[indexPath.row]
            cell.statusLbl.text = "\(String(roundForUpcomingSection[indexPath.row])) Rounds Completed"
            cell.doneLabel.isHidden = true
        } else if indexPath.section == 2 {
            cell.headerLbl.text = finishedInterviews[indexPath.row]
            cell.statusLbl.text = "\(String(roundForFinishedSection[indexPath.row])) Rounds Completed"
            cell.doneLabel.text = "Done"
        }
        // Configure the cell...

        return cell
    }
//     let totalRounds = interviewFields[indexPath.row]["totalRounds"]
    
    func apiFields() {
        let interviews = InterviewsList.interviews.interviewsJSONField
        var role = ""
        for count in 1 ... interviews[0].count {
//            total.append(String(describing: interviews[0][count-1]["totalRounds"]))
            var totalString = String(describing: interviews[0][count-1]["totalRounds"])
            var finishedString = String(describing: interviews[0][count-1]["finishedRounds"])
            role = String(describing: interviews[0][count-1]["role"])
            guard let totalRounds = Int(totalString) else {
                return
            }
            guard let finishedRounds = Int(finishedString) else {
                return
            }
            if  finishedRounds > 0 && finishedRounds > totalRounds {
                    onGingInterviews.append(role)
                roundForOngoingSection.append(finishedRounds)
            } else if finishedRounds == 0 {
                roundForUpcomingSection.append(finishedRounds)
                upComingInterviews.append(role)
            
            } else if totalRounds == finishedRounds {
                roundForFinishedSection.append(finishedRounds)
                finishedInterviews.append(role)
            
            }
            //            print("Total rounds are \(interviews[0][count-1]["totalRounds"])")
//            print("Finished rounds are \(interviews[0][count-1]["finishedRounds"])")

        }
        print("Roles is \(role)")
//        print("TotalRounds is \(totalRounds)")
//        print("FinishedRounds is \(finishedRounds)")
        print("roundForOngoingSection  is \(roundForOngoingSection)")
        print("roundForUpcomingSection  is \(roundForUpcomingSection)")
        print("roundForFinishedSection  is \(roundForFinishedSection)")

        print("Ongoing  interviews \(onGingInterviews)")
        print("Up coming interviews \(upComingInterviews)")
    }
 
}
