//
//  CacheController.swift
//  RecipeApp_NextLevel
//
//  Created by tesco on 16/12/19.
//  Copyright © 2019 tesco. All rights reserved.
//

import Foundation
import UIKit

enum CacheAccessError: Error {
    case invalidPath
    case unknownCacheItem
    case corruptLastUpdatedTime
}

class CacheController: NSObject {
    
    fileprivate let cacheFileExtension = "keyedArchive"
    fileprivate var cacheDirectory: String? {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        if let cachePath = paths.first, let bundleIdentifier = Bundle.main.bundleIdentifier {
            let writeDirectory = cachePath.appending("/\(bundleIdentifier)/recipeCache")
            return writeDirectory
        }
        return nil
    }
    
    @discardableResult func saveCache(forName name: String, withContent content: Any) throws -> Bool {
        let savePath = try archivePath(forName: name)
        let fileManager = FileManager.default
        if let svelteDirectory = cacheDirectory, !fileManager.fileExists(atPath: svelteDirectory) {
            let directoryURL = URL(fileURLWithPath: svelteDirectory, isDirectory: true)
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: false)
        }
        return NSKeyedArchiver.archiveRootObject(content, toFile: savePath)
    }
    
    func getCache(forName name: String) throws -> Any? {
        let readPath = try archivePath(forName: name)
        return NSKeyedUnarchiver.unarchiveObject(withFile: readPath)
    }
    
    func clearAllCache() throws {
        guard let svelteDirectory = cacheDirectory else { return }
        try FileManager.default.removeItem(atPath: svelteDirectory)
    }
    
    private func archivePath(forName name: String) throws -> String {
        guard let archiveDirectory = cacheDirectory else {
            throw CacheAccessError.invalidPath
        }
        let archivePath = archiveDirectory.appending("/\(name).\(cacheFileExtension)")
        return archivePath
    }
    
}
