//
//  CandidateExperienceTableViewCell.swift
//  iRecruit
//
//  Created by Giritharan Sugumar on 9/25/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

protocol CandidateExperienceDelegate: class {
    func sendYear(year: Int)
    func sendMonth(month: Int)
}

class CandidateExperienceTableViewCell: UITableViewCell {

    
    @IBOutlet var experienceLbl: UILabel!
    @IBOutlet var yearPlusBtn: UIButton!
    @IBOutlet var yearlbl: UILabel!
    @IBOutlet var yearAddBtn: NSLayoutConstraint!
    
    @IBOutlet var monthMinusBtn: UIButton!
    @IBOutlet var monthAddBtn: UIButton!
    @IBOutlet var monthLbl: UILabel!
    
    weak var experience: CandidateExperienceDelegate?
    
    var yearValue:Int = 0 {
        didSet {
            yearlbl.text = "\(yearValue)"
        }
    }
    
    var monthValue:Int = 0 {
        didSet {
            monthLbl.text = "\(monthValue)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        monthValue = 0
        yearValue = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func yearAddButton(_ sender: Any) {
        yearValue += 1
        yearlbl.text = String(yearValue)
        experience?.sendYear(year: yearValue)
    }
    
    @IBAction func yearMinusButton(_ sender: Any) {
        yearValue -= 1
        if yearValue < 0 {
            yearValue = 0
        }
        
        yearlbl.text = String(yearValue)
        experience?.sendYear(year: yearValue)
    }

    @IBAction func monthMinusButton(_ sender: Any) {
        monthValue -= 1
        if monthValue < 0 {
            monthValue = 0
        }
        
        monthLbl.text = String(monthValue)
        experience?.sendMonth(month: monthValue)
    }

    
    
    @IBAction func monthAddButton(_ sender: Any) {
        monthValue += 1
        if monthValue > 12 {
            monthValue = 12
        }
        
        monthLbl.text = String(monthValue)
        experience?.sendMonth(month: monthValue)
    }
    
}
