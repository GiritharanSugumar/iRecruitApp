//
//  RequiredTableViewCell.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 8/6/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

protocol RequiredTblCellDelegate : class {

    func sendNumberOfRound(noOFRounds:Int)
    func sendNumberOfCandidate(noOfCandidate:Int)
    
}

class RequiredTableViewCell: UITableViewCell , UITextFieldDelegate {
   
    @IBOutlet weak var requiredField: UILabel!
    
    @IBOutlet weak var valueLbl: UILabel!
    
    @IBOutlet weak var minusBtn: UIButton!
   
    @IBOutlet weak var plusBtn: UIButton!
//    var numberUserDefault = UserDefaults.standard
    weak var delegate:RequiredTblCellDelegate?
    var checkRound:Bool = false
    
   var number:Int = 0 {
        didSet {
            valueLbl.text = "\(number)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //requiredField.tag = 1
        number = 0
        
//        if number != 0 {
//            print("Number Present")
//            checkRound = true
//        }
    }
    
    
    
    @IBAction func minusButton(_ sender: Any) {
    
        number -= 1
        
        if number < 0 {
            number = 0
        }
        
//        numberUserDefault.set(number, forKey: "number")
//        numberUserDefvart.synchronize()
        if(self.minusBtn.tag == 1) {
        self.delegate?.sendNumberOfRound(noOFRounds: number)
        } else if(self.minusBtn.tag == 0) {
            self.delegate?.sendNumberOfCandidate(noOfCandidate: number)
        }
        

    }

   
    @IBAction func addButton(_ sender: Any) {
        
        number += 1
        
        if self.plusBtn.tag == 1 {
            
            if number >= 10 {
            number = 10
        }
        }

//        numberUserDefault.set(number, forKey: "number")
//        numberUserDefault.synchronize()
        if(self.plusBtn.tag == 1) {
            self.delegate?.sendNumberOfRound(noOFRounds: number)
        } else if(self.plusBtn.tag == 0) {
            self.delegate?.sendNumberOfCandidate(noOfCandidate: number)
        }
    }
   
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
