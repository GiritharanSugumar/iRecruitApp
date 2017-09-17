//
//  ExperienceTableViewCell.swift
//  
//
//  Created by Giritharan Sugumar on 8/6/17.
//
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var year: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
