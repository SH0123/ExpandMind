//
//  VideoWriting+CoreDataProperties.swift
//  ExpandMind
//
//  Created by sanghyo on 2022/05/04.
//
//

import Foundation
import CoreData


extension VideoWriting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideoWriting> {
        return NSFetchRequest<VideoWriting>(entityName: "VideoWriting")
    }

    @NSManaged public var date: String?
    @NSManaged public var division: String?
    @NSManaged public var id: String?
    @NSManaged public var isBookmarked: Bool
    @NSManaged public var summary: String?
    @NSManaged public var thoughts: String?
    @NSManaged public var title: String?

}

extension VideoWriting : Identifiable {

}
