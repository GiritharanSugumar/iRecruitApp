//
//  ImageRadius.swift
//  interviewer
//
//  Created by Giritharan Sugumar on 7/21/17.
//  Copyright © 2017 giritharan. All rights reserved.
//

class ImageRadius: UIImageView {
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
