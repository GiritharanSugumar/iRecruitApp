
//  ViewController.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 6/26/17.
//  Copyright © 2017 giritharan. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON


class TokenStorage {
    static let shared = TokenStorage()
    public var token: String = ""
    public var user = [String:String]()
}

//protocol sendTokenDelegate: class {
//    func sendToken(login:String)
//}


class SignInViewController: UIViewController  {
    
    @IBOutlet weak var navigationButton: UIBarButtonItem!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let validation = Validation()
    var swiftyJSONMe: JSON = []
//   weak var delegateToken:sendTokenDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any adtionl setup after loading the view, typically from a nib.
        self.navigationButton.target = revealViewController()
        self.navigationButton.action = #selector(SWRevealViewController.revealToggle(_:))
        setUpUI()
        loginAzure(email: "abcd@abcd.com", password: "abcdabcd")
    }
    
    func setUpUI() {
        emailTextField.layer.cornerRadius = 2.0
        passwordTextField.layer.cornerRadius = 2.0
        emailTextField.layer.borderColor = (UIColor.darkGray).cgColor
        passwordTextField.layer.borderColor = (UIColor.darkGray).cgColor
        passwordTextField.isSecureTextEntry = true
    }
    
    //Action Methods
    @IBAction func SignInButton(_ sender: Any) {
        guard let email = emailTextField.text else {
            print("No input Texts")
            return
        }
        guard let password = passwordTextField.text  else {
            print("No Password texts")
            return
        }
        
        let isEmailIDValid = validation.checkValidEmailID(emailAddress: email)
        var isFieldsSuccess:Bool = false
        var isCheckFields:Bool = false
        
        if ((email.isEmpty) || (password.isEmpty))  {
            isFieldsSuccess = false
            alertMessage(message: "Enter all the Fields")
        } else {
            isCheckFields = true
        }
        if isEmailIDValid {
            print("Valid Email")
            isFieldsSuccess = true
        } else {
            
            alertMessage(message: "Enter Valid Email ID")
        }
        if isFieldsSuccess == true &&  isCheckFields == true {
            loginAzure(email: email, password: password)
        }
        
        //    /* Save the Session */
        //        let userdefault = UserDefaults.standard
        //        userdefault.set(true, forKey: "isLogin")
    }
    
    var headerString:String = ""
    func loginAzure(email: String, password: String) {
        
        let mail = email
        let pass = password
        
        var JSONResponse = ["sample1", "sample2"]
        Alamofire.request("http://13.90.149.245:3000/auth/api/login", method: .post, parameters: [ "email": mail,"password": pass], encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            switch response.result {
            case .success:
                let swiftyJsonVar = JSON(response.data!)
                //            print("SW is  \(swiftyJsonVar)")
                var isSuccess:Bool = false
                JSONResponse[0] = String(describing: swiftyJsonVar["isSuccess"])
                JSONResponse[1] = String(describing: swiftyJsonVar["token"])
                print("Lol \(JSONResponse[0]), \(JSONResponse[1])")
                self.headerString = JSONResponse[1]
                
                            
                
                if JSONResponse[0] == "true" {
                    isSuccess = true
                } else if JSONResponse[1] == "false" {
                    isSuccess = false
                }
                
                 let token = JSONResponse[1]
                
                if !(token.isEmpty) {
                    self.getMe(tokenValue: token)
                    TokenStorage.shared.token = token
                    
                }
                if isSuccess == true && JSONResponse[1] != nil {
           
                    //Move to homePage
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let sw = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                    self.view.window?.rootViewController = sw
                    let destinationController = self.storyboard?.instantiateViewController(withIdentifier: "Interviews") as! InterviewsViewController
                    
                    let navigationController = UINavigationController(rootViewController: destinationController)
                    
                    sw.pushFrontViewController(navigationController, animated: true)
                    
                } else  {
                    self.alertMessage(message: "You Entered wrong credentials")
                }
                break
            case .failure(let error):
                self.alertMessage(message: "Something went Wrong")
            }
            
        }
        
        
    }
    
    func getMe(tokenValue: String) {
        
        var contentArray = ["","","","","",""]
        
        let headers: HTTPHeaders = ["Authorization": tokenValue]
        Alamofire.request("http://13.90.149.245:3000/api/me", headers: headers)
            .responseJSON { response in
                
                switch  response.result {
                case .success:
                    guard let responseData = response.data else {return}
                    self.swiftyJSONMe = JSON(responseData)
                    contentArray[0] = String(describing: self.swiftyJSONMe["user"]["adminName"])
                    contentArray[1] = String(describing: self.swiftyJSONMe["user"]["name"])
                    contentArray[2] = String(describing: self.swiftyJSONMe["user"]["email"])
                    contentArray[3] = String(describing: self.swiftyJSONMe["user"]["role"])
                    contentArray[4] = String(describing: self.swiftyJSONMe["user"]["phone"])
                    contentArray[5] = String(describing: self.swiftyJSONMe["user"]["id"])
                    TokenStorage.shared.user["adminName"] = contentArray[0]
                    TokenStorage.shared.user["name"] = contentArray[1]
                    TokenStorage.shared.user["email"] = contentArray[2]
                    TokenStorage.shared.user["role"] = contentArray[3]
                    TokenStorage.shared.user["phone"] = contentArray[4]
                    TokenStorage.shared.user["id"] = contentArray[5]
               
                case .failure:
                    break
                    
                }
        }

    }

    
    func alertMessage(message:String) {
        let  myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        myAlert.addAction(okAction)
        present(myAlert, animated:true, completion:nil);
        
    }
    
}

