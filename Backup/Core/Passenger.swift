//
//  Passenger.swift
//  Backup
//
//  Created by Undo Hatsune on 2023/07/28.
//

import Foundation


public struct Passenger {
    public var url: URL
    public var constraint: Constraint
    
    public init(url: URL, constraint: Constraint = .necessary) {
        self.url = url
        self.constraint = constraint
    }
    
    public init(base: URL, component: String, constraint: Constraint = .necessary) {
        self.url = base.appendingPathComponent(component)
        self.constraint = constraint
    }
    
    public init(base: Base, component: String, constraint: Constraint = .necessary) {
        self.url = base.url.appendingPathComponent(component)
        self.constraint = constraint
    }
}


extension Passenger {
    public enum Constraint {
        case necessary
        case optional
    }
    
    public enum Base {
        case document
        
        fileprivate var url: URL {
            switch self {
            case .document:
                return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            }
        }
    }
}
