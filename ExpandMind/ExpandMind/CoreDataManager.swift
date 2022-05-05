//
//  CoreDataManager.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/04.
//

import Foundation
import CoreData

class CoreDataManager : ObservableObject{
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name:"Model")
        container.loadPersistentStores{ (_, error) in
            if let error = error as NSError?{
                fatalError("Unresolved Error: \(error)")
            }
        }
        
    }
    
    }
