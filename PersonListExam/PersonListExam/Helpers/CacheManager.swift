//
//  CacheManager.swift
//  PersonListExam
//
//  Created by JLCS on 09/07/2018.
//  Copyright © 2018 JLCS. All rights reserved.
//

import Foundation
import Cache

class CacheManager {
    static let shared = CacheManager()
    private init() {}
    private let diskConfig = DiskConfig(name: "Floppy")
    private let memoryConfig = MemoryConfig(expiry: .date(Date().addingTimeInterval(2*60)), countLimit: 10, totalCostLimit: 10)
    
    
    lazy var storage: Storage? = {
        do {
            let storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
            return storage
        } catch {
            print(error)
            return nil
        }
    }()
    
    
}
