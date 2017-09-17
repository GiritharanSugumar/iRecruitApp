//
//  AddInterviewerTableViewCell.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/4/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

protocol InterviewerDelegates {
    func interviewer(text: String, tagValue:Int)
}

class AddInterviewerTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var interviewerText: UITextField!

    var intDelegate:InterviewerDelegates?
    override func awakeFromNib() {
        super.awakeFromNib()
      interviewerText.delegate = self
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textValue = textField.text else {
            return
        }
        intDelegate?.interviewer(text: textValue, tagValue: textField.tag)
    }
    
    func showFields(labelField: String, text: String, tag: Int) {
    label.text = labelField
    interviewerText.text = text
    interviewerText.tag = tag
        if tag == 0 {
            interviewerText.autocapitalizationType = .words
        } else if tag == 1 {
            interviewerText.keyboardType = .emailAddress
        } else if tag == 2 {
            interviewerText.keyboardType = .phonePad
        } else if tag == 3 {
            interviewerText.autocapitalizationType = .words
        }
        
    }

//    func setData(labelValue: String, textFieldValue: String, tag: Int) {
//       label.text = labelValue
//       textField.text = textFieldValue
//    }
}
