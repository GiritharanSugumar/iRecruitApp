//
//  AddInterviewerViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/4/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class AddInterviewerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, InterviewerDelegates {

    let interviewerLabelFields = ["Name", "Email", "Phone", "Designation"]
    
    var interviewerTextFields = ["","","",""]
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interviewerLabelFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "AddInterviewer"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AddInterviewerTableViewCell
        cell.intDelegate = self
        cell.showFields(labelField: interviewerLabelFields[indexPath.row], text: interviewerTextFields[indexPath.row], tag: indexPath.row)
        
        return cell

    }
 
    func interviewer(text: String, tagValue: Int) {
       interviewerTextFields[tagValue] = text
        
    }
    
    @IBAction func saveInterviewerBtn(_ sender: Any) {
        
        var emptyFields:Bool = false
        var emailValid:Bool = false
        var phoneValid:Bool = false
            /* Check Empty */
        if interviewerTextFields[0].isEmpty || interviewerTextFields[1].isEmpty || interviewerTextFields[2].isEmpty || interviewerTextFields[3].isEmpty  {
            alertMessage(message: "Please Enter All The Fields")
        } else {
            emptyFields = true
        }
        
        var validation = Validation()
        if validation.checkValidEmailID(emailAddress: interviewerTextFields[1]) {
            emailValid = true
            print("Valid email id")
        } else {
            alertMessage(message: "Enter Valid Email ID")
        }
        
        if interviewerTextFields[2].characters.count < 8 {
            alertMessage(message: "Enter Valid Phone Number")
        } else {
            phoneValid = true
        }
        
        if emptyFields && emailValid && phoneValid {
           addInterviewerAPI()
        }
        
        
      }

    
    func addInterviewerAPI()  {
        
        let receivedToken = TokenStorage.shared.token
        let companyID = TokenStorage.shared.user["companyId"]
        var JSONResponse = ["sample1", "sample2"]
        let headers: HTTPHeaders = ["Authorization": receivedToken]
        let apiFields = ["name": interviewerTextFields[0], "email": interviewerTextFields[1],  "phone": interviewerTextFields[2], "designation": interviewerTextFields[3], "companyId": companyID ]
        
        Alamofire.request("http://13.90.149.245:3000/api/interviewers", method: .post, parameters: apiFields, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            switch response.result {
            case .success:
                let swiftyJsonVar = JSON(response.data!)
                var isSuccess:Bool = false
                JSONResponse[0] = String(describing: swiftyJsonVar["isSuccess"])
                JSONResponse[1] = String(describing: swiftyJsonVar["token"])
                if JSONResponse[0] == "true" {
                    isSuccess = true
                
                } else if JSONResponse[1] == "false" {
                    isSuccess = false
                }
                if isSuccess == true && JSONResponse[1] != nil {
                    let myAlert = UIAlertController(title: "Alert", message: "Interviewer Added Successful", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "✅", style: .default, handler: { (alert) in
                        //opens homePage
                        self.openInterviewersVC()
                    })
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                } else  {
                    self.alertMessage(message: "You Entered wrong credentials")
                }
                break
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
  
    func openInterviewersVC () {
        let interviewerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InterViewer") as! InterViewerViewController
      navigationController?.pushViewController(interviewerVC, animated: true)
    }
    
    func alertMessage(message:String) {
        let  myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        myAlert.addAction(okAction)
        present(myAlert, animated:true, completion:nil);
        
    }
}
