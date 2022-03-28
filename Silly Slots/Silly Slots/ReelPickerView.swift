//
//  ReelPickerView.swift
//  Silly Slots
//
//  Created by Caroline Mitchem on 3/24/22.
//

import UIKit
import Parse
import Foundation

class ReelPickerView: UIPickerView {
    var images = [PFObject]()
    
    enum K {
        static let emojiFont  = "Apple Color Emoji"
        static let win        = "Winner!"
        static let lose       = "3 In A Row"
        static let sound      = "Slots"
        static let imageArray = ["🍋", "❤️", "🍒", "🍌", "🍊", "🔔", "🍉", "👑"]
        static let rattle     = "Rattle"
    }

}
