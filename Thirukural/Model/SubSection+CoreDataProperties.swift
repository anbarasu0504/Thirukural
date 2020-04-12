//
//  SubSection+CoreDataProperties.swift
//  Thirukural
//
//  Created by Anbarasu S on 28/03/20.
//  Copyright © 2020 Uyar Valluvam. All rights reserved.
//
//

import Foundation
import CoreData

func allObjectCount<T: NSManagedObject>(ofType:T.Type,fromMOC moc: NSManagedObjectContext) -> Int {
    let request = T.fetchRequest() as! NSFetchRequest<T>
    do {
        let count = try moc.count(for: request as! NSFetchRequest<NSFetchRequestResult>)
        return count
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        return 0
    }
}

extension CDSubSection: Identifiable {

    @nonobjc public class func allObjectsFetchRequest() -> NSFetchRequest<CDSubSection> {
        let request = CDSubSection.fetchRequest() as! NSFetchRequest<CDSubSection>
        request.sortDescriptors = [NSSortDescriptor(key: "subSectionIndex", ascending: true)]
        return request
    }

    @nonobjc public class func fetchSubSectionWithRecordname(_ recordName: String, fromMOC moc:NSManagedObjectContext) -> CDSubSection? {
        let request = CDSubSection.fetchRequest() as! NSFetchRequest<CDSubSection>
        request.sortDescriptors = [NSSortDescriptor(key: "subSectionIndex", ascending: true)]
        request.predicate = NSPredicate(format: "recordName = %@", recordName)

        do {
          let objects = try moc.fetch(request)

            if let validObject = objects.first {
                return validObject
            } else {
                return CDSubSection(context: moc)
            }

        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }

    }

    @nonobjc public class func childSubSections(section: CDSection, fromMOC moc: NSManagedObjectContext) -> [CDSubSection] {
           let request = CDSubSection.fetchRequest() as! NSFetchRequest<CDSubSection>
           request.sortDescriptors = [NSSortDescriptor(key: "subSectionIndex",ascending: true)]
           request.predicate = NSPredicate(format: "parentSection = %@",section.recordName)

           do {
               let objects = try moc.fetch(request)
               return objects
           } catch let error as NSError {
               print("Could not fetch. \(error), \(error.userInfo)")
               return []
           }

    }

    var childCoupletsIndexRange: (firstIndex: Int, lastIndex: Int) {
        switch self.subSectionIndex {
        case 1: return (1,40)
        case 2: return (41,240)
        case 3: return (241,370)
        case 4: return (371,380)
        case 5: return (381,630)
        case 6: return (631,730)
        case 7: return (731,950)
        case 8: return (951,1080)
        case 9: return (1081,1150)
        case 10: return (1151,1330)
        default: return (0,0)
        }
    }

    var coupletRange: String {
        return "\(self.childCoupletsIndexRange.firstIndex) - \(self.childCoupletsIndexRange.lastIndex)"
    }

    public var id: String {
        return recordName
    }


    @NSManaged public var recordName: String
    @NSManaged public var subSectionIndex: Int16
    @NSManaged public var subSectionTamil: String
    @NSManaged public var parentSection: String

}
