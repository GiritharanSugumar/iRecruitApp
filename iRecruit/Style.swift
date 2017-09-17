//
//  Style.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 6/28/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

import Foundation
import UIKit

struct Style { 	// MARK: ToDo Table Section Headers
    static var sectionHeaderTitleFont = UIFont(name: ".SF NS Text", size: 20)
    static var sectionHeaderTitleColor = UIColor.white
    static var sectionHeaderBackgroundColor = UIColor.black
    static var sectionHeaderBackgroundColorHighlighted = UIColor.gray
    static var sectionHeaderAlpha: CGFloat = 1.0
    
    

}


//As you can see, all the style variables are static. This means they belong to the struct and can be accessed anywhere in your project without the need to instantiate the struct. You can use them in your code like this 


//self.contentView.backgroundColor = Style.sectionHeaderBackgroundColor
