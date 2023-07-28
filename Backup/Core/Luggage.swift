//
//  Luggage.swift
//  Backup
//
//  Created by Undo Hatsune on 2023/07/28.
//

import Foundation


public protocol LuggageLike: Codable {
    init()
    
    var creationTime: Date? { get }
    
    var version: Int? { get }
    
    var device: String? { get }
    
    var payload: Data? { get }
}


open class DefaultLuggage: LuggageLike {
    public required init() {}
    
    open var creationTime: Date?
    
    open var version: Int?
    
    open var device: String?
    
    open var payload: Data?
    
    init(creationTime: Date? = nil, version: Int? = nil, device: String? = nil, payload: Data? = nil) {
        self.creationTime = creationTime
        self.version = version
        self.device = device
        self.payload = payload
    }
    
    public enum CodingKeys: String, CodingKey {
        case creationTime = "ct"
        case version = "vs"
        case device = "dv"
        case payload = "pl"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        creationTime = try values.decode(Date?.self, forKey: .creationTime)
        version = try values.decode(Int?.self, forKey: .version)
        device = try values.decode(String?.self, forKey: .device)
        payload = try values.decode(Data?.self, forKey: .payload)
    }
}
