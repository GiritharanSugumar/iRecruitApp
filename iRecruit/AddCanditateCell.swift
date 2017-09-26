//
//  AddCanditateCell.swift
//  iRecruit
//
//  Created by Giritharan Sugumar on 8/22/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

protocol candidateDelegates {
    func candidate(text: String, tagValue:Int)
}

class AddCanditateCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet var headLabel: UILabel!
    @IBOutlet var textEnter: UITextField!
    
    var candidateDelegate:candidateDelegates?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textEnter.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textValue = textField.text else {
            return
        }
        candidateDelegate?.candidate(text: textValue, tagValue: textField.tag)
    }
    
    func showCandidates(labelFields: String, candidateText: String, tag: Int) {
        headLabel.text = labelFields
        textEnter.text = candidateText
        textEnter.tag = tag
    }
}
