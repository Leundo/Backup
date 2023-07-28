//
//  RaftTests.swift
//  BackupTests
//
//  Created by Undo Hatsune on 2023/07/28.
//

import XCTest
@testable import Backup


final class RaftTests: XCTestCase {
    
    
    var passengers = [
        Passenger(base: .document, component: "passage1.txt"),
        Passenger(base: .document, component: "void.void", constraint: .optional),
        Passenger(base: .document, component: "ship"),
    ]

    override func setUpWithError() throws {
        DefaultTicket.register()
        print(NSHomeDirectory())
    }

    override func tearDownWithError() throws {
        
    }

    func testStation() throws {
        let luggage = DefaultLuggage(creationTime: Date(), version: 1, device: "unkown", payload: Data(repeating: 2, count: 4))
        try Raft<DefaultTicket, DefaultLuggage>.arriveStation(passengers: passengers, with: luggage)
    }

    func testAttraction() throws {
        try Raft<DefaultTicket, DefaultLuggage>.arriveAttraction(at: "Attr")
    }
    
    func testDock() throws {
        let luggage = try Raft<DefaultTicket, DefaultLuggage>.arriveDock(from: "Attr")
        print(luggage?.payload)
    }
    
    func testScouting() throws {
        print(try Raft<DefaultTicket, DefaultLuggage>.scoutAttractionName())
    }
}
