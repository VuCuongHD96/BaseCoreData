//
//  CoreDataBaseRepository.swift
//  BaseCoreData
//
//  Created by Work on 02/10/2023.
//

import Foundation

class CoreDataBaseRepository {
    
    var coreDataManager: CoreDataManager!
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}
