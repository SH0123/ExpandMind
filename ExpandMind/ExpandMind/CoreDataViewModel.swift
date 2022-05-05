//
//  CoreDataViewModel.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/05.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject{
    let manager = CoreDataManager.instance
        
    func saveContext(context: NSManagedObjectContext){
        do{
            try context.save()
        }catch{
            let error = error as NSError
            fatalError("\(error)")
        }
    }
    
    func addCategory(division: String, isSelected: Bool, context: NSManagedObjectContext){
        let category = CategoryCheck(context: context)
        category.division = division
                
        saveContext(context: context)
    }
    
    func addWritings(date: String, division: String, id: String, isBookmarked: Bool, summary: String, thoughts: String, title: String, context: NSManagedObjectContext){
        let writings = VideoWriting(context: context)
        writings.id = id
        writings.division = division
        writings.date = date
        writings.title = title
        writings.summary = summary
        writings.thoughts = thoughts
        writings.isBookmarked = isBookmarked
        
        saveContext(context: context)
    }
    
    func deleteCategory(category: CategoryCheck, context: NSManagedObjectContext){
        context.delete(category)
        saveContext(context: context)
    }
    
}
