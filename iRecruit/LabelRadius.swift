//
//  LabelRadius.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/24/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

class LabelRadius: UILabel {
    @ IBInspectable var cornerRadius: CGFloat {
        
        get {
            
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
