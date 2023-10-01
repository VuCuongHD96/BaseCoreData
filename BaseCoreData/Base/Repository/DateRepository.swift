//
//  DateRepository.swift
//  BaseCoreData
//
//  Created by Work on 30/09/2023.
//

import Combine

class DateRepository: CoreDataBaseRepository {
    
    func getItemList() -> AnyPublisher<[Item], Error> {
        let input = DateCoreDataFetchRequest()
        return coreDataManager.request(input: input)
    }
    
    func save() -> AnyPublisher<Bool, Error> {
        return coreDataManager.save()
    }
}
