//
//  RoleTableViewCell.swift
//  iRecruit
//
//  Created by Giritharan Sugumar on 8/22/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

class RoleTableViewCell: UITableViewCell {

    @IBOutlet var roleText: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
