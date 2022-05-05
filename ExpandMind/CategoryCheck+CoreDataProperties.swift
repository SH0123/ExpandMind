//
//  CategoryCheck+CoreDataProperties.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/04.
//
//

import Foundation
import CoreData


extension CategoryCheck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCheck> {
        return NSFetchRequest<CategoryCheck>(entityName: "CategoryCheck")
    }

    @NSManaged public var division: String?
    @NSManaged public var isSelected: Bool

}

extension CategoryCheck : Identifiable {

}
