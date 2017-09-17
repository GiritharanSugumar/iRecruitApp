//
//  RoundsTableViewCell.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/5/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

class RoundsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var roundNumber: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var typeOfRound: UILabel!
    @IBOutlet weak var selectedPeoples: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
