//
//  CDManager.swift
//  BudgetThink
//
//  Created by Farras Doko on 28/05/20.
//  Copyright © 2020 Boyband. All rights reserved.
//

import UIKit
import CoreData

class CDManager {
    private var objectContext: NSManagedObjectContext
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static let shared = CDManager()
    
    private init() {
        objectContext = appDelegate!.persistentContainer.viewContext
    }
    
    func loadData() -> [Finance] {
        let request: NSFetchRequest<Finance> = Finance.fetchRequest()
        request.returnsObjectsAsFaults = false
        var finances = [Finance]()
        do {
            try finances = objectContext.fetch(request)
        } catch {
            print("couldn't load data")
        }
        return finances
    }
    
    func addData(finance: Financed) {
        let entity = NSEntityDescription.entity(forEntityName: "Finance", in: objectContext)
        let newData = NSManagedObject(entity: entity!, insertInto: objectContext)
        newData.setValue(finance.desc, forKey: "desc")
        newData.setValue(finance.date, forKey: "date")
        newData.setValue(finance.category, forKey: "category")
        newData.setValue(finance.repeatAmount, forKey: "repeatAmount")
        newData.setValue(finance.repeatPeriod, forKey: "repeatPeriod")
        newData.setValue(finance.img, forKey: "receipt")
        
        do {
            try objectContext.save()
            print("saved \(newData)")
        }catch let error as NSError{
            print("couldn't save. \(error)")
        }
    }
    
    func deleteData(id: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Finance")
        request.predicate = NSPredicate(format: "category = %@", id)
        
        do {
            let objects = try objectContext.fetch(request)
            for obj in objects {
                let objectToDelete = obj as! NSManagedObject
                objectContext.delete(objectToDelete)
            }
            
            do {
                try objectContext.save()
            } catch {
                print("error saving after deletion: \(error)")
            }
        } catch {
            print("error fetching for deletion: \(error)")
        }
    }
}
