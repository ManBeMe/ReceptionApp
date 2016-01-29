//
//  Transaction.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

protocol Transaction {
    
    typealias VisitorType: Visitor
    
    var visitor: VisitorType? { get set }
}