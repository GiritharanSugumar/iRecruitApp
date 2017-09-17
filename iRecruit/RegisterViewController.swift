//
//  RegisterViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 6/26/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , sendDataDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    var companyFields = ["Company Name", "Company Website", "Company Address", "Admin Name", "Admin Email",  "Admin Phone Number", "Create Password", "Confirm Password"]
    var textFieldValues = ["", "", "", "", "", "", "", ""]
    let validation = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyFields.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RegisterTableViewCell
        cell.delegate = self
        cell.setData(label: companyFields[indexPath.row], textValue: textFieldValues[indexPath.row], tag:indexPath.row)
        return cell
    }
    
    func returnValue(strData: String, tagValue: Int) {
        self.textFieldValues[tagValue] = strData
    }
    // give some tag,use didEndEditing,
    
    @IBAction func signUpButton(_ sender: Any) {
        var checkFields:Bool = false
        var checkwebsite:Bool = false
        var checkEmail:Bool = false
        var checkPhone:Bool = false
        var checkPassword: Bool = false
        
        /* Check Empty Fields */
        if textFieldValues[0].isEmpty || textFieldValues[1].isEmpty || textFieldValues[2].isEmpty || textFieldValues[3].isEmpty || textFieldValues[4].isEmpty || textFieldValues[5].isEmpty || textFieldValues[6].isEmpty || textFieldValues[7].isEmpty  {
            self.alertMessage(message: "Please enter all the fields")
            checkFields = false
        } else {
            checkFields = true
        }
        
        /* Website Validation */
        if validation.checkWebsite(website: textFieldValues[1]) {
            checkwebsite = true
        } else {
            checkwebsite = false
            alertMessage(message: "Please Enter Valid Website Address")
        }
        
        let emailID:String
        /* Email Validation */
        if validation.checkValidEmailID(emailAddress: textFieldValues[4]) {
            checkEmail = true
            print("Valid email id")
            emailID = textFieldValues[4]
        } else {
            checkEmail = false
            alertMessage(message: "Enter Valid Email ID")
        }
        
        /* Phone Number Validation */
        if textFieldValues[5].characters.count < 7 {
            checkPhone = false
            alertMessage(message: "Please Enter Valid Mobile Number")
        } else {
            checkPhone = true
        }
        
        
        /* Password validation */
        if textFieldValues[6].characters.count < 8 || textFieldValues[7].characters.count < 8 {
            self.alertMessage(message: "Password should contain minimum 8 characters length")
            checkPassword = false
        } else {
            checkPassword = true
        }
        if textFieldValues[6] != textFieldValues[7] {
            self.alertMessage(message: "Your passwords didn't match")
            checkPassword = false
        } else {
            checkPassword = true
        }
        
        if checkFields && checkPassword && checkPhone && checkEmail && checkwebsite{
            signUpAzure()
        } else {
            self.alertMessage(message: "Please enter the correct fields")
        }
        
    }
    
    func signUpAzure() {
        var JSONResponse = ["sample1", "sample2"]
        print("API values are \(textFieldValues)")
        let apiTest = ["name": textFieldValues[0], "site": textFieldValues[1],  "email": textFieldValues[4], "address": textFieldValues[2], "password": textFieldValues[6], "adminName": textFieldValues[3], "phone": textFieldValues[5]]
        
        print("APITEST is \(apiTest)")
        Alamofire.request("http://13.90.149.245:3000/auth/api/signup", method: .post, parameters: apiTest, encoding: JSONEncoding.default, headers: nil).responseJSON {
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
                if isSuccess == true && JSONResponse[1] != nil {
                    let myAlert = UIAlertController(title: "Alert", message: "Sign-Up Successful", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "✅", style: .default, handler: { (alert) in
                        //opens homePage
                        self.openSignInVC()
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
    
    func openSignInVC () {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        self.present(loginVC, animated: true, completion: nil)
    }
    
    func alertMessage(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    
    func isValidated() -> Bool {
        
        for eachItem in textFieldValues {
            
            if (eachItem.isEmpty) {
                
                return false
            }
        }
        return true
    }
    
}
