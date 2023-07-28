//
//  FileManager+.swift
//  Backup
//
//  Created by Undo Hatsune on 2023/07/28.
//

import Foundation


extension FileManager {
    func directoryExists(atUrl url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = self.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}
