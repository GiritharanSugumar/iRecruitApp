//
//  HomeInterviewPageTableViewCell.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 8/2/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import UIKit

class HomeInterviewPageTableViewCell: UITableViewCell {

    @IBOutlet weak var color: UIView!
    @IBOutlet weak var candidateName: UILabel!
    @IBOutlet weak var candidateRole: UILabel!
    @IBOutlet weak var candidateExperience: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
