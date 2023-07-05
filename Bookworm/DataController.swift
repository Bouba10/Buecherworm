//
//  DataController.swift
//  Bookworm
//
//  Created by Boubacar sidiki barry on 04.07.23.
//

import CoreData
import Foundation

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "BookwormModel")
    
    init(){
        container.loadPersistentStores { description ,error  in
            if let error = error {
                
                print("Core Data failed to load \(error.localizedDescription)")
                
            }
            
        }
    }
}
