//
//  InterviewsViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 6/29/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InterviewsList {
    static let interviews = InterviewsList()
    public var interviewsJSONField = [JSON]()
   
}

class InterviewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var addBtn: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var navigationButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var profilePic: UIImageView!
    var interviewsJson:JSON = []
    var isSuccessAPI:Bool = false
    lazy var searchBar =  UISearchBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var responseResult = ["sample1", "sample2"]
    var totalInterviews = 0
    var positionForInterviewer = [String]()
    var dateForInterviewer = [String]()
    var interviewersInterviewsCount = 0
    
    enum newPosition {
        case FrontViewPositionLeft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.placeholder = "Search"
        
        navigationItem.titleView = searchBar
        
        navigationButton.target = revealViewController()
        navigationButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.segmentedControl.tintColor = UIColor(red: CGFloat(0x5A)/255, green: CGFloat(0xC3)/255, blue: CGFloat(0xCA)/255, alpha: 1.0)
        profilePic.layer.cornerRadius = profilePic.frame.width/2
        profilePic.clipsToBounds = true
        
        let lpgr = UITapGestureRecognizer(target: self, action: #selector(tap(gestureReconizer:)))
        lpgr.delegate = self as? UIGestureRecognizerDelegate
        collectionView?.addGestureRecognizer(lpgr)
    }

    func tap(gestureReconizer: UITapGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        let selectMe = SWRevealViewController()
        selectMe._setFrontViewPosition(FrontViewPosition.left, withDuration: 0.3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interviewsListAPI()

    }
    
    
    func interviewsListAPI()  {
        
        let receivedToken = TokenStorage.shared.token
        guard let companyID = TokenStorage.shared.user["companyId"] else {
            return
        }
        let headers: HTTPHeaders = ["Authorization": receivedToken]
        let param = ["companyId": companyID]
        Alamofire.request("http://13.90.149.245:3000/api/interviews", method: .get, parameters: param,  headers: headers).responseJSON {
            response in
            
            switch response.result {
            case .success:
                let swiftyJsonVar = JSON(response.data!)
                self.interviewsJson = swiftyJsonVar["interviews"]
                InterviewsList.interviews.interviewsJSONField = [self.interviewsJson]
                self.totalInterviews = self.interviewsJson.count

                self.responseResult[0] = String(describing: swiftyJsonVar["isSuccess"])
                if self.responseResult[0] == "true" {
                self.isSuccessAPI = true
                    self.interviewersFields()
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if TokenStorage.shared.user["role"] == "admin" {
            return totalInterviews
        }
        else  {
            return interviewersInterviewsCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let idetifier = "collectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idetifier, for: indexPath) as! InterviewCollectionViewCell
        if isSuccessAPI == true {
            if TokenStorage.shared.user["role"] == "admin" {
               
            let  interviewFields = interviewsJson
            let roleField = String(describing: interviewFields[indexPath.row]["role"])
                
            let totalRounds = interviewFields[indexPath.row]["totalRounds"]
            let finishedRounds = interviewFields[indexPath.row]["finishedRounds"]
            let date = String(describing: interviewFields[indexPath.row]["date"])
            
            let dateParsed = dateParsing(dateFromAPI: date)
            
            cell.date.text = dateParsed.Day
            cell.month.text = dateParsed.Month
            cell.year.text = dateParsed.Year
            
            cell.role.text = roleField
            cell.category.text = "Rounds"
            cell.categoryResult.text = String(describing: totalRounds)
            cell.finishedRoundsLbl.text = String(describing: finishedRounds)
            if finishedRounds == 0 {
                cell.status.text = "Yet to Start"
            } else if finishedRounds > totalRounds {
                    cell.status.text = "Ongoing"
                
            } else if finishedRounds == totalRounds {
                cell.status.text = "Finished"
                
            }
            } else if TokenStorage.shared.user["role"] == "interviewer" {
                addBtn.isHidden = true
                cell.role.text = positionForInterviewer[indexPath.row]
                let dateForInterviewer = String(describing: self.dateForInterviewer)
                let dateParsedInterviewer = dateParsing(dateFromAPI: dateForInterviewer)
                var year = dateParsedInterviewer.Year
//                year.remove(at: year.startIndex)
//                year.remove(at: year.startIndex)
//                year.remove(at: year.startIndex)
                let yearInterviewer = year.chopPrefix(2)
                cell.date.text = dateParsedInterviewer.Day
                cell.month.text = dateParsedInterviewer.Month
                cell.year.text = yearInterviewer
                cell.category.text = "Peoples"
            }
        }
        
        return cell
    }

   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if TokenStorage.shared.user["role"] == "admin" {
        
            let roundsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RoundsPage") as! OngoingInterviewTableViewController
    
        self.navigationController?.pushViewController(roundsVC, animated: true)
            
        } else  if TokenStorage.shared.user["role"] == "interviewer" {
            let interviewID = String(describing:interviewsJson[indexPath.row]["id"])
            
                let candidatesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "container") as! ContainerViewController
            ContainerViewController.id.receivedInterviewID = interviewID
//            candidatesVC.receivedInterviewID = interviewID
            self.navigationController?.pushViewController(candidatesVC, animated: true)
         }
    }
    
    
    func dateParsing(dateFromAPI: String ) -> (Year:String,Month:String,Day:String) {

        let dateComponents = dateFromAPI.components(separatedBy: "T")
        let splitDate = dateComponents[0]
        let splitTime = dateComponents[1]
        let splitYear = splitDate.components(separatedBy: "-")
       
        
        
        return (splitYear[0],splitYear[1],splitYear[2])
    }
    
    
    
    func interviewersFields() {
        if TokenStorage.shared.user["role"] == "interviewer" {
        
         let interviewerId = JSON(TokenStorage.shared.user["interviewerId"]!)
       
        for count in 1 ... interviewsJson.count {
            print(count)
            var id = interviewsJson[count-1]["interviewers"]
            for interviewersCount in 1 ... id.count {
                
                if interviewerId == id[interviewersCount-1] {
                    interviewersInterviewsCount += 1
                    positionForInterviewer.append(String(describing:interviewsJson[count-1]["role"]))
                    dateForInterviewer.append(String(describing:interviewsJson[count-1]["date"]))
                    
                }
                
            }
        }
        }
    }

    
}



extension String {
    func chopPrefix(_ count: Int = 1) -> String {
        return substring(from: index(startIndex, offsetBy: count))
    }
    
    func chopSuffix(_ count: Int = 1) -> String {
        return substring(to: index(endIndex, offsetBy: -count))
    }
}
