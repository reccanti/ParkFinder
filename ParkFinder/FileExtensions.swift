//
//  FileExtensions.swift
//  ParkFinder
//
//  Created by Benjamin Wilcox on 4/15/17.
//  Copyright © 2017 Benjamin Wilcox. All rights reserved.
//

import Foundation

extension FileManager {
    
    /**
     * return the path to the documents directory
     */
    static var documentsDirectory: URL {
        return self.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    }
    
    /**
     * returns the URL of the file as it would exist
     * in the documents directory
     */
    static func filePathInDocumentsDirectory(filename: String)-> URL {
        return FileManager.documentsDirectory.appendingPathComponent(filename)
    }
    
    /**
     * checks to see if the given file exists in the
     * documents directory
     */
    static func fileExistsInDocumentsDirectory(filename: String)-> Bool {
        let path = filePathInDocumentsDirectory(filename: filename).path
        return FileManager.default.fileExists(atPath: path)
    }
}
