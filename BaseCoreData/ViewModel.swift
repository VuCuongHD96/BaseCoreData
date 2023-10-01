//
//  ViewModel.swift
//  BaseCoreData
//
//  Created by Work on 02/10/2023.
//

import Combine
import Foundation
import CoreData

class ViewModel {
    
    let dateRepository = DateRepository(coreDataManager: .shared)
    var cancelablle = Set<AnyCancellable>()
    
    struct Input {
        var loadTrigger = PassthroughSubject<Void, Never>()
        var addTrigger = PassthroughSubject<Void, Never>()
    }
    
    class Output: ObservableObject {
        @Published var itemList = [Item]()
        @Published var saveSucceded = false
    }
    
    func transform(_ input: Input) -> Output {
        
        let output = Output()
        let errorTracker = ErrorTracker()
        input.loadTrigger
            .flatMap { _ in
                self.dateRepository.getItemList()
                    .trackError(errorTracker)
                    .asDriver()
            }
            .assign(to: \.itemList, on: output)
            .store(in: &cancelablle)
        
        input.addTrigger
            .handleEvents { _ in
                let newItem = Item()
            }
            .flatMap { _ in
                self.dateRepository.save()
                    .trackError(errorTracker)
                    .asDriver()
            }
            .assign(to: \.saveSucceded, on: output)
            .store(in: &cancelablle)
        
        return output
    }
}


typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher where Failure: Error {
    func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}

public typealias Driver<T> = AnyPublisher<T, Never>

extension Publisher {
    public func asDriver() -> Driver<Output> {
        return self.catch { _ in Empty() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    public static func just(_ output: Output) -> Driver<Output> {
        return Just(output).eraseToAnyPublisher()
    }
    
    public static func empty() -> Driver<Output> {
        return Empty().eraseToAnyPublisher()
    }
}

extension Item {
    
    convenience init() {
        self.init(context: CoreDataManager.shared.container.viewContext)
        self.timestamp = Date.now
    }
}
