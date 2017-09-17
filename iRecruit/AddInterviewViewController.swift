//
//  AddInterviewViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/20/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddInterviewViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , RequiredTblCellDelegate, InterviewerDelegate, ExperienceDelegate {
    
    @IBOutlet var deleteButton: UIButton!
            
    var hidePicker:Bool = false
    @IBOutlet weak var tblView: UITableView!
    var datePickerHidden = false
    var pickerHeight = 0
    var rounds = ["Enter Round1", "Enter Round2", "Enter Round3", "Enter Round4", "Enter Round5", "Enter Round6", "Enter Round7", "Enter Round8", "Enter Round9", "Enter Round10"]
    var selectedDate:String = "Select the Date"
    var dateForAPI:String = ""
    var newDate:String = ""
    var addInterviewSections = ["Role","Candidates Required", "Number of Rounds", "Add Rounds", "Experience Required", "Picker", "Interview Date", "Date Picker"]
    var tableData = [1,2,0,1,1,1,1]
    var interviewerName:String?
    var interviewerID = ["","","","","","","","","",""]
    var ID:String?
    var btnTag:Int?
    var requiredFields = ["Candidates Required", "Number of Rounds"]
    var interviewersList = ["Add Interviewer","Add Interviewer","Add Interviewer","Add Interviewer","Add Interviewer","Add Interviewer","Add Interviewer","Add Interviewer","Add Interviewer","Add Interviewer"]
//    var interviewersList:[String] = []
    var experienceYear = 0
    var experienceMonth = 0
    var role = ""
    var numberOfCandidates = 0
    /* Check Empty Values */
    var datePickerchanged:Bool = false
    var roleEntry:Bool = false
    var candidatesEntry:Bool = false
    var roundsEntry:Bool = false
    var interviewersEntry:Bool = false
    var experienceEntry:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.isHidden = true
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)

      self.tblView.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return addInterviewSections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else if section == 2 {
            print("Table Data is \(tableData[2])")
            return self.tableData[2]
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        } else if section == 5 {
            return 1
        } else if section == 6 {
            return 1
        }
            
        else {
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 6 {
            
            if hidePicker == false {
                return CGFloat(pickerHeight)
            } else {
        
                return 0
            }
            
        } else {
            return 64
        }
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Role") as! RoleTableViewCell
            role = cell.roleText.text!
            if !(role.isEmpty) {
            roleEntry = true
            }
            return cell
            
        }
    
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Required") as! RequiredTableViewCell
            cell.delegate = self
            

            if indexPath.row == 0 {
                cell.plusBtn.tag = indexPath.row
                cell.minusBtn.tag = indexPath.row
                cell.requiredField.text = requiredFields[indexPath.row]
                
                
            } else if indexPath.row == 1 {
                cell.plusBtn.tag = indexPath.row
                cell.minusBtn.tag = indexPath.row
            
                cell.requiredField.text = requiredFields[indexPath.row]
                          }
            return cell
            
        }
            
        else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddRounds") as! AddRoundsTableViewCell
            cell.roundText.placeholder = rounds[indexPath.row]
            cell.interviewerButton.tag = indexPath.row
            guard let name = interviewerName, let tag = btnTag, let intId = ID else{
                cell.interviewerButton.setTitle(interviewersList[indexPath.row], for: .normal)
                return cell
            }
            if indexPath.row == tag{
                interviewersEntry = true
                cell.interviewerButton.setTitle(name, for: .normal)
                if tableData[2] < 10 {
                    interviewersList[indexPath.row] = name
                    interviewerID[indexPath.row] = intId
                    interviewerName = nil
                    ID = nil
                    btnTag = nil

                }
            }
            
            return cell
            
        }
        else if indexPath.section == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Experience") as! ExperienceTableViewCell
            
            return cell
            
        }
        else if indexPath.section == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Picker") as! PickerTableViewCell
            cell.experience = self
            return cell
            
        }

        
        else if indexPath.section == 5 {
            let interviewDateCell = tableView.dequeueReusableCell(withIdentifier: "InterviewDate") as! InterviewDateTableViewCell
            let tap = UITapGestureRecognizer(target: self, action: #selector(AddInterviewViewController.tapFunction))

            interviewDateCell.selectDate.isUserInteractionEnabled = true
              interviewDateCell.selectDate.addGestureRecognizer(tap)
            
            interviewDateCell.selectDate.text = selectedDate
            
            return interviewDateCell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePicker") as! DatePickerTableViewCell
            cell.datePicker.addTarget(self, action: #selector(changeDate), for: UIControlEvents.valueChanged)
            
            return cell
        }
        
    }
    
    @IBAction func handleAddInterviewerBtn(_ sender: UIButton) {
        let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InterViewer") as! InterViewerViewController
        let selectedBtnTag = ((sender.superview?.superview) as! AddRoundsTableViewCell).interviewerButton.tag
        destVC.tag = selectedBtnTag
        destVC.interviewerDelegate = self
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
    var tableInterviewer = InterViewerViewController()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "interviewerCell" {
        let destinationVC = segue.destination as? InterViewerViewController
        let interviewerIndex = tableInterviewer.interviewerTable.indexPathForSelectedRow?.row
        }
    }
   
    
    func tapFunction(sender:UITapGestureRecognizer) {
        pickerHeight = 120
        hidePicker = false
        tblView.reloadData()
        self.scrollToBottom()
          }
    
    func scrollToBottom(){
        DispatchQueue.global(qos: .background).async {
            let indexPath = IndexPath(row: 0, section: self.addInterviewSections.count-2)
            self.tblView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }
    
    func changeDate(_ sender: UIDatePicker) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        //formatter.timeZone = TimeZone(secondsFromGMT: 0)
    
        formatter.locale = Locale(identifier: "en_US_POSIX")
        dateForAPI = formatter.string(from: sender.date)
        print(formatter.string(from: sender.date))
        selectedDate = DateFormatter.localizedString(from: sender.date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
        selectedDate = "\(selectedDate)"
        datePickerchanged = true
        tblView.reloadData()
//        hidePicker = true
        
    }
    
    func sendNumberOfRound(noOFRounds: Int) {
        if self.tableData[2] > noOFRounds{
//            if interviewersList.indices.contains(noOFRounds){
//                interviewersList.remove(at: noOFRounds)
//            }
            interviewersList[noOFRounds] = "Add Interviewer"
            interviewerID[noOFRounds] = ""
        }
        self.tableData[2] = noOFRounds
        if tableData[2] >= 1 {
            roundsEntry = true
        } else {
           roundsEntry = false
        }
        
        self.tblView.reloadData()
    }
    
    func sendNumberOfCandidate(noOfCandidate: Int) {
        numberOfCandidates = noOfCandidate
        
        if numberOfCandidates >= 1 {
            candidatesEntry = true
        } else {
            candidatesEntry = false
        }
        print(numberOfCandidates)
    }
    
    func sendInterviewer(Interviewer: String, tag: Int, interviewerID: String) {
        interviewerName = Interviewer
        ID = interviewerID
  //      self.interviewerID = interviewerID
        btnTag = tag
        tblView.reloadData()
    }
    
    func sendMonth(month: Int) {
        experienceMonth = month
        if experienceMonth >= 1 {
           experienceEntry = true
        } else {
            experienceEntry = false
        }
    }
    
    func sendYear(year: Int) {
        experienceYear = year
    }
    
    @IBAction func saveInterview(_ sender: Any) {
        
        var isApiCall:Bool = false
        if roleEntry &&  candidatesEntry && roundsEntry && experienceEntry && datePickerchanged && interviewersEntry {
            isApiCall = true
            alertMessage(message: "success")

        } else {
            isApiCall = false
            alertMessage(message: "Please Enter All The Fields")

        }
        
        if isApiCall == true {
            callAPI()
        }
    }

    func callAPI () {
        var JSONResponse = ["sample1", "sample2"]
        print(interviewersList)
        let role = self.role
        let interviewers = ["a","b"]
        let requiredExperience:String = "\(self.experienceYear).\(self.experienceMonth)"
        let peopleRequired = self.numberOfCandidates
        let totalRounds = self.tableData[2]
        let date = self.dateForAPI
        guard let companyId = TokenStorage.shared.user["id"] else { return }
        let apiParameters = ["role":role,"interviewers":interviewerID,"requiredExperience":requiredExperience,"peopleRequired":peopleRequired,"totalRounds":totalRounds,"date":date,"companyId":companyId] as [String : Any]
        let header = ["Authorization": TokenStorage.shared.token]
        print("APITEST is \(apiParameters)")
        Alamofire.request("http://13.90.149.245:3000/api/interviewes", method: .post, parameters: apiParameters, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result {
            case .success:
                let swiftyJsonVar = JSON(response.data!)
                print("SW is  \(swiftyJsonVar)")
                var isSuccess:Bool = false
                JSONResponse[0] = String(describing: swiftyJsonVar["isSuccess"])
                JSONResponse[1] = String(describing: swiftyJsonVar["token"])
                print("Lol \(JSONResponse[0]), \(JSONResponse[1])")
                if JSONResponse[0] == "true" {
                    isSuccess = true
                } else if JSONResponse[1] == "false" {
                    isSuccess = false
                }
            case .failure(let error):
                print(error)
            }
            
        }

    }
    
    func alertMessage(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
    }
}
