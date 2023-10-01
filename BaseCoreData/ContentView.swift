//
//  ContentView.swift
//  BaseCoreData
//
//  Created by Work on 30/09/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    private var items: [Item] = []
    
    let input: ViewModel.Input
    @ObservedObject var output: ViewModel.Output
    
    init() {
        input = ViewModel.Input()
        output = ViewModel().transform(input)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(output.itemList) { item in
                    Text(item.timestamp!, formatter: itemFormatter)
                }
                .onAppear {
                    input.loadTrigger.send()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "plus.app.fill")
                            .onTapGesture {
                                input.addTrigger.send()
                            }
                    }
                }
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
