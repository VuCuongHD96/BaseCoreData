//
//  CoreDataBaseRequest.swift
//  BaseCoreData
//
//  Created by Work on 30/09/2023.
//

import CoreData

protocol CoreDataBaseRequestType {
    associatedtype T: NSManagedObject
    var request: NSFetchRequest<T> { get }
}
