//
//  OtherTransaction.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

struct OtherTransaction: Transaction {
    
    let purpose: String
    
    init(purpose: String) {
        self.purpose = purpose
    }
}