//
//  RegisterTableViewswift
//  interviewer
//
//  Created by Giritharan Sugumar on 6/27/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit


protocol sendDataDelegate {
    func returnValue(strData: String, tagValue: Int)
}

class RegisterTableViewCell: UITableViewCell , UITextFieldDelegate {
    
    @IBOutlet weak var textFields: UITextField!
    @IBOutlet weak var lbl: UILabel!
    
    var delegate:sendDataDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFields.delegate = self
    }
   
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let unwrappedValue = textField.text else {
            return
        }
        delegate?.returnValue(strData: unwrappedValue, tagValue: textField.tag)
    }
    
    func setData(label: String, textValue: String, tag:Int) {
        lbl.text = label
        textFields.text = textValue
        textFields.tag = tag
        textFields.isSecureTextEntry = false
        textFields.autocapitalizationType = .none
        textFields.keyboardType = .default
        if lbl.text == "Company Name" {
            textFields.autocapitalizationType = .words
        } else if lbl.text == "Company Website" {
            textFields.keyboardType = .URL
        } else if lbl.text == "Company Address" {
            textFields.autocapitalizationType = .words
        } else if lbl.text == "Admin Name" {
            textFields.autocapitalizationType = .words
        } else if lbl.text == "Admin Email" {
            textFields.keyboardType = .emailAddress
        } else if lbl.text == "Admin Phone Number" {
            textFields.keyboardType = .phonePad
        } else if lbl.text == "Create Password" {
            textFields.isSecureTextEntry = true
        } else if lbl.text == "Confirm Password" {
            textFields.isSecureTextEntry = true
        }
    }
    
}
