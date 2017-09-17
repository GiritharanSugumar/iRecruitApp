//
//  OngoingTableViewCell.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/4/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit
//protocol OngoingTblViewCellDelegate {
//    

//    func plusButtonClicked() -> Int
//    
//}
class StatusTableViewCell

: UITableViewCell {

    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        statusLbl.font = Style.sectionHeaderTitleFont
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
