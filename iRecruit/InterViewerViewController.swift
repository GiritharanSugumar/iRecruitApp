//
//  InterViewerViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 6/30/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


protocol InterviewerDelegate : class {
    
    func sendInterviewer(Interviewer:String,tag:Int,interviewerID: String)
    
}


class InterViewerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var interviewerTable: UITableView!
    @IBOutlet weak var navigationButton: UIBarButtonItem!
    @IBOutlet var tblView: UITableView!
    var totalInterviewers: Int = 0
    
    var interViewerCell = InterviewerTableViewCell()
    weak var interviewerDelegate:InterviewerDelegate?
    var tag:Int?
    var JSONResponse = ["sample1", "sample2"]
    var nameJson:JSON = []
    var isSuccess:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard tag == nil else{
            navigationButton.target = self
            navigationButton.action = #selector(popPresentVC)
            return
        }
        navigationButton.target = revealViewController()
        navigationButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        interviewersList()
    }
    
    func popPresentVC(){
        self.navigationController?.popViewController(animated: true)
    }

    
    func interviewersList() {
        let headerToken = TokenStorage.shared.token
        guard let id = TokenStorage.shared.user["companyId"] else {
            return
        }
        let companyID = ["companyId": id]
        
        let headers: HTTPHeaders = ["Authorization": headerToken]
        
        Alamofire.request("http://13.90.149.245:3000/api/interviewers", method: .get, parameters: companyID,  headers: headers).responseJSON {
            response in
            switch response.result {
            case .success:
                let swiftyJsonVar = JSON(response.data!)
                self.JSONResponse[0] = String(describing: swiftyJsonVar["interviewers"])
               
                self.nameJson = swiftyJsonVar["interviewers"]
                self.totalInterviewers = self.nameJson.count
                if self.JSONResponse[0] != nil {
                    self.isSuccess = true
                    
                    self.tblView.reloadData()
                    
                } else if self.JSONResponse[1] == "false" {
               //     self.isSuccess = false
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return totalInterviewers
        
    }
    var intr = [String]()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "interviewerCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! InterviewerTableViewCell
        
        if isSuccess == true {
            let  nameValue = nameJson
            let nameField = String(describing: nameValue[indexPath.row]["name"])
            self.intr = [nameField]
            let designationField = String(describing: nameValue[indexPath.row]["designation"])
            cell.designationLbl.text = designationField
            cell.profileName.text = nameField
            
        }
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let  nameValue = nameJson
        let nameField = String(describing: nameValue[indexPath.row]["name"])
        let nameID = String(describing: nameValue[indexPath.row]["id"])
        guard let btnTag = tag else {
            return
        }
        interviewerDelegate?.sendInterviewer(Interviewer: nameField, tag: btnTag, interviewerID: nameID)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Warning", message: "Are you sure?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                let deleteInterviewer = self.nameJson
                let interviewerId = String(describing: deleteInterviewer[indexPath.row]["id"])
                self.deleteInterviewer(interviewerId: interviewerId)
                self.totalInterviewers -= 1
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            })
            alertController.addAction(deleteAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func deleteInterviewer(interviewerId: String) -> (Bool) {
        
        let token = TokenStorage.shared.token
        let headers: HTTPHeaders = ["Authorization": token]
        
        Alamofire.request("http://13.90.149.245:3000/api/interviewers/"+interviewerId, method: .delete, headers: headers)
            .responseJSON { response in
                print(response.result)
                switch  response.result {
                case .success:
                    guard let responseData = response.data else {return}
                    print(responseData)
                    let swiftyJsonVar = JSON(response.data!)
                    print("JSON Response is  \(swiftyJsonVar)")
                    var a = String(describing: swiftyJsonVar["interviewers"])
                    print(a)
                    
//                    self.swiftyJSONMe = JSON(responseData)
//                    contentArray[0] = String(describing: self.swiftyJSONMe["user"]["adminName"])
//                    contentArray[1] = String(describing: self.swiftyJSONMe["user"]["name"])
//                    contentArray[2] = String(describing: self.swiftyJSONMe["user"]["email"])
//                    contentArray[3] = String(describing: self.swiftyJSONMe["user"]["role"])
//                    contentArray[4] = String(describing: self.swiftyJSONMe["user"]["phone"])
//                    contentArray[5] = String(describing: self.swiftyJSONMe["user"]["id"])
//                    TokenStorage.shared.user["adminName"] = contentArray[0]
//                    TokenStorage.shared.user["name"] = contentArray[1]
//                    TokenStorage.shared.user["email"] = contentArray[2]
//                    TokenStorage.shared.user["role"] = contentArray[3]
//                    TokenStorage.shared.user["phone"] = contentArray[4]
//                    TokenStorage.shared.user["id"] = contentArray[5]
            //        return true
                case .failure(let error):
                    print("Error  is \(error)")
                    
                    break
          //         return false
                }
        }
        return true

    

}
}

