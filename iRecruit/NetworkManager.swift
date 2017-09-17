//
//  NetworkManager.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/30/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol loginDelegate : class {
    func resultData(retDat: String)
}


class NetworkManager {
  let baseurl = "http://192.168.1.14:3000/"
   static var resultJSON = ""
    var newResult = String()
    weak var delegate: loginDelegate?
    static func login() {
        let baseurl = "http://192.168.1.14:3000/login"
        let loginurl = "/login"
//    init(userName: String, password: String) {
//        let data : [String: AnyObject?] = ["email": userName as AnyObject, "password": password as AnyObject]
        var statusCode: Int
        Alamofire.request(baseurl, method: .post, parameters: ["email": "test2255","password":"test2"],encoding: JSONEncoding.default, headers: nil).responseJSON {
            
            response in
            
            switch response.result {
            case .success:
                print(response.data!)
                break
            case .failure(let error):
                
                print(error)
            }
        }
    }
   
    
    
    func loginAzure(email: String, password: String) -> Bool {
       
        let mail = email
        let pass = password
        var status:Bool = false
        Alamofire.request("http://13.90.149.245:3000/auth/api/login", method: .post, parameters: [ "email": mail,"password": pass], encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            
            print("Response Value is \(response.result.isSuccess)")
            print("Response data is \(response.data!)")
            
            switch response.result {
            case .success:
                let swiftyJsonVar = JSON(response.data!)
                
                print("JSON Var is \(swiftyJsonVar)")
              NetworkManager.resultJSON = String(describing: swiftyJsonVar["token"])
           //     self.delegate?.resultData(retDat: NetworkManager.resultJSON)
                print("SwiftyJSON is \(swiftyJsonVar["token"])")
                self.newResult = String(describing: swiftyJsonVar["isSuccess"])
               self.delegate?.resultData(retDat: self.newResult)
                if self.newResult == "true" {
                    print("NEW RESULT is \(self.newResult)")

                status = true
                    print("status in switch is \(status)")
                }
                break
            case .failure(let error):
                print(error)
            }
            
        }
        print("STATUS OF \(status)")
        return status
    }
    
    static func getRequest() {
            //Alamofire.request("http://192.168.1.14:3000/").response { response in // method defaults to `.get`
                Alamofire.request("http://13.90.149.245:3000").response { response in // method defaults to `.get`
                if(response.error == nil) {
                    let swiftyJsonVar = JSON(response.data!)
                    print(swiftyJsonVar)
                } else {
                    
                }
            }
            
        }
    
    static func testAlamo() {
        Alamofire.request("http://192.168.1.14:3000/").response { response in
            print(response)
        
    }
    }
    
}
