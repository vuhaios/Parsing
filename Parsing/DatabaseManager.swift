//
//  DatabaseManager.swift
//  Parsing
//
//  Created by Sai Sailesh Kumar Suri on 02/11/18.
//  Copyright © 2018 Honeywell. All rights reserved.
//

import UIKit

import CoreData

class DatabaseManager: NSObject {
    
    
    func saveBooksData(_ booksArray : NSMutableArray){
        let context = self.persistentContainer.viewContext
        
        for dictionary in booksArray{
            let dict : NSDictionary = dictionary as! NSDictionary
            let title : String = dict.value(forKey: "title") as! String
            if checkIfBookExists(title: title){
                let entity = NSEntityDescription.entity(forEntityName: "Books", in: context)
                let book = NSManagedObject(entity: entity!, insertInto: context)
                book.setValue(dict.value(forKey: "title"), forKey: "title")
                book.setValue(dict.value(forKey: "country"), forKey: "country")
                book.setValue(dict.value(forKey: "date"), forKey: "date")
                book.setValue(dict.value(forKey: "textSnippet"), forKey: "snippet")
                book.setValue(dict.value(forKey: "contentVersion"), forKey: "version")
                self.saveContext()
            }
        }
    }
    
    func fetchBooks() -> NSMutableArray {
        let array = NSMutableArray.init()
        let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Books")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            for book in results as! [Books]{
                let dictionary = NSMutableDictionary.init()
                dictionary.setValue(book.value(forKey: "title"), forKey: "title")
                dictionary.setValue(book.value(forKey: "country"), forKey: "country")
                dictionary.setValue(book.value(forKey: "date"), forKey: "date")
                dictionary.setValue(book.value(forKey: "snippet"), forKey: "textSnippet")
                dictionary.setValue(book.value(forKey: "version"), forKey: "contentVersion")
                array.add(dictionary)
            }
            return array
        } catch  {
            print("reading database error")
        }
        return array
    }
    
    func checkIfBookExists(title : String) -> Bool{
        let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Books")
        request.predicate = NSPredicate.init(format: "title = %@", title)
        request.returnsObjectsAsFaults = false
        do {
           let result = try context.fetch(request)
            if result.count > 0{
                return false
            }
            return true
            
        } catch  {
            print("reading database error")

            return true
        }
    }
    
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Parsing")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
