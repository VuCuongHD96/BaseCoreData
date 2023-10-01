//
//  DateCoreDataFetchRequest.swift
//  BaseCoreData
//
//  Created by Work on 30/09/2023.
//

import CoreData

class DateCoreDataFetchRequest: CoreDataBaseRequestType {

    typealias T = Item
    var request: NSFetchRequest<T>
    
    init() {
        let entityName = String(describing: T.self)
        request = NSFetchRequest<T>(entityName: entityName)
    }
}
