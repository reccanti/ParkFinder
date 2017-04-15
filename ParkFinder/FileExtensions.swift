//
//  FileExtensions.swift
//  ParkFinder
//
//  Created by Benjamin Wilcox on 4/15/17.
//  Copyright © 2017 Benjamin Wilcox. All rights reserved.
//

import Foundation

extension FileManager {
    
    static var documentsDirectory: URL {
        return self.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
    }
}
