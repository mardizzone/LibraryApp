//
//  UIButtonExtension.swift
//  BookCatalog
//
//  Created by Michael Ardizzone on 3/6/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit
import Foundation

extension UIButton {
    //we'll use this function to make our buttons look better
    func makeoverButton() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor.white
    }
}
