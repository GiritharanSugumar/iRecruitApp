//
//  Validation.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/18/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import Foundation
import UIKit

class Validation  {
    
    func checkValidEmailID(emailAddress: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddress as NSString
            let results = regex.matches(in: emailAddress, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
        }
        
        
        return returnValue
        
    }
    
    func checkWebsite(website: String) -> Bool {
        var returnValue = true
        let websiteRegEx = "[A-Z0-9a-z.-_]+\\.[A-Za-z]{2,3}"
        
        do {
            let webex = try NSRegularExpression(pattern: websiteRegEx)
            let nsString = website as NSString
            let results = webex.matches(in: website, range: NSRange(location: 0, length: nsString.length))
            
            
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("Invalid webex: \(error.localizedDescription)")
        }
    return returnValue
        
    }
    
    
}
