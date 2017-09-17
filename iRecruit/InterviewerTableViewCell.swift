//
//  InterviewerTableViewCell.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/4/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

class InterviewerTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet var designationLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
