//
//  Order.swift
//  CupcakeCorner
//
//  Created by Shah Md Imran Hossain on 1/5/23.
//

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        // didSet is called after value is set
        // after value is set
        // do post processing what you need to be done
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
