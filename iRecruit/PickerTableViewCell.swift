//
//  PickerTableViewCell.swift
//  
//
//  Created by Giritharan Sugumar on 8/8/17.
//
//

import UIKit

protocol ExperienceDelegate: class {
    func sendYear(year: Int)
    func sendMonth(month: Int)
}


class PickerTableViewCell: UITableViewCell {

    @IBOutlet var yearLbl: UILabel!
    @IBOutlet var yearAddButton: UIButton!
    @IBOutlet var yearMinusButton: UIButton!

    @IBOutlet var monthLbl: UILabel!
    @IBOutlet var monthAddButton: UIButton!
    @IBOutlet var monthMinusButton: UIButton!
    
    weak var experience: ExperienceDelegate?
    
    var yearValue:Int = 0 {
        didSet {
            yearLbl.text = "\(yearValue)"
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
    
    @IBAction func yearAddBtn(_ sender: Any) {
        yearValue += 1
        yearLbl.text = String(yearValue)
        experience?.sendYear(year: yearValue)
    }
    
    @IBAction func yearMinusBtn(_ sender: Any) {
        yearValue -= 1
        if yearValue < 0 {
            yearValue = 0
        }
        
        yearLbl.text = String(yearValue)
        experience?.sendYear(year: yearValue)
    }
    
    @IBAction func monthAddBtn(_ sender: Any) {
        monthValue += 1
        if monthValue > 12 {
            monthValue = 12
        }
        
        monthLbl.text = String(monthValue)
        experience?.sendMonth(month: monthValue)
    }
    
    @IBAction func monthMinusBtn(_ sender: Any) {
        monthValue -= 1
        if monthValue < 0 {
            monthValue = 0
        }
        
        monthLbl.text = String(monthValue)
        experience?.sendMonth(month: monthValue)
    }

}
