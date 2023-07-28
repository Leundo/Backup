//
//  Ticket.swift
//  Backup
//
//  Created by Undo Hatsune on 2023/07/28.
//

import Foundation
import Zip


public protocol TicketLike {
    static var backupFolder: URL { get }
    
    static var stationFolder: URL { get }
    
    static var dockFolder: URL { get }
    
    static var backupExtension: String { get }
    
    static var code: String? { get }
    
    static var luggageRack: String { get }
        
    static func register()
}


extension TicketLike {
    static func getAttractionFile(_ name: String) -> URL {
        return backupFolder.appendingPathComponent(name).appendingPathExtension(backupExtension)
    }
    
    static var luggageRackFileAtStation: URL {
        return stationFolder.appendingPathComponent(luggageRack)
    }
    
    static var luggageRackFileAtDock: URL {
        return dockFolder.appendingPathComponent(luggageRack)
    }
}


public class DefaultTicket: TicketLike {
    public static let backupFolder: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Backups")
    
    public static let stationFolder: URL = backupFolder.appendingPathComponent("Station")
    
    public static let dockFolder: URL = backupFolder.appendingPathComponent("Dock")
    
    public static let backupExtension: String = "backup"
    
    public static let code: String? = "bTSKhg-OnLoVH-6Bvaoi"
    
    public static let luggageRack: String = "luggage"
    
    public static func register() {
        Zip.addCustomFileExtension(backupExtension)
    }
}
