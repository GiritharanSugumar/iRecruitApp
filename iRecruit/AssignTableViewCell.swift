//
//  AssignTableViewCell.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 8/5/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

class AssignTableViewCell: UITableViewCell {

    @IBOutlet weak var AssignedDate: UILabel!
    @IBOutlet weak var AssignedRole: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
