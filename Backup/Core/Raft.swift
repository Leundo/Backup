//
//  Raft.swift
//  Backup
//
//  Created by Undo Hatsune on 2023/07/28.
//

import Foundation
import Zip


public class Raft<Ticket: TicketLike, Luggage: LuggageLike> {
    
    public static func arriveStation(passengers: [Passenger], with luggage: Luggage? = nil) throws {
        if FileManager.default.directoryExists(atUrl: Ticket.stationFolder) {
            try FileManager.default.removeItem(at: Ticket.stationFolder)
        }
        try FileManager.default.createDirectory(at: Ticket.stationFolder, withIntermediateDirectories: true)
        
        for passenger in passengers {
            do {
                try FileManager.default.copyItem(at: passenger.url, to: Ticket.stationFolder.appendingPathComponent(passenger.url.lastPathComponent))
            } catch {
                if passenger.constraint == .necessary {
                    throw error
                }
            }
        }
        
        let luggage = luggage ?? Luggage()
        let encorder = JSONEncoder()
        let json = try encorder.encode(luggage)
        try json.write(to: Ticket.luggageRackFileAtStation)
    }
    
    public static func arriveAttraction(at name: String) throws {
        let contents = try FileManager.default.contentsOfDirectory(at: Ticket.stationFolder, includingPropertiesForKeys: nil)
        try Zip.zipFiles(paths: contents, zipFilePath: Ticket.getAttractionFile(name), password: Ticket.code, progress: { (_) -> () in
        })
    }
    
    @discardableResult
    public static func arriveDock(from name: String) throws -> Luggage? {
        try Zip.unzipFile(Ticket.getAttractionFile(name), destination: Ticket.dockFolder, overwrite: true, password: Ticket.code, progress: { (_) -> () in
        })
        let json = try? Data(contentsOf: Ticket.luggageRackFileAtDock)
        let decorder = JSONDecoder()
        guard let json = json else { return nil }
        return try? decorder.decode(Luggage.self, from: json)
    }
}


extension Raft {
    public static func scoutAttractions() throws -> [URL] {
        return try FileManager.default.contentsOfDirectory(at: Ticket.backupFolder, includingPropertiesForKeys: nil).filter {
            return $0.pathExtension == Ticket.backupExtension
        }
    }
    
    public static func scoutAttractionName() throws -> [String] {
        return try FileManager.default.contentsOfDirectory(at: Ticket.backupFolder, includingPropertiesForKeys: nil).filter {
            print($0.pathExtension)
            return $0.pathExtension == Ticket.backupExtension
        }.map {
            return $0.deletingPathExtension().lastPathComponent
        }
    }
}
