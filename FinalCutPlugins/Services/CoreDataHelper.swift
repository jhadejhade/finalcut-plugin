//
//  CoreDataHelper.swift
//  FinalCutPlugins
//
//  Created by Jade Lapuz on 7/1/25.
//

import CoreData
import SwiftUI

class CoreDataHelper<T: NSManagedObject>: ObservableObject {
    private let viewContext: NSManagedObjectContext
    private let entityName: String
    
    init(viewContext: NSManagedObjectContext, entityName: String? = nil) {
        self.viewContext = viewContext
        self.entityName = entityName ?? String(describing: T.self)
    }
    
    // MARK: - Fetch Operations
    
    func fetchItems(sortDescriptors: [NSSortDescriptor] = []) async throws -> [T] {
        let request = NSFetchRequest<T>(entityName: entityName)
        request.sortDescriptors = sortDescriptors
        
        do {
            return try viewContext.fetch(request)
        } catch {
            throw error
        }
    }
    
    func fetchItems(predicate: NSPredicate, sortDescriptors: [NSSortDescriptor] = []) async throws -> [T] {
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            return try viewContext.fetch(request)
        } catch {
            throw error
        }
    }
    
    // MARK: - CRUD Operations
    
    @discardableResult
    func createItem(configure: (T) -> Void = { _ in }) async -> T {
        let newItem = NSEntityDescription.insertNewObject(forEntityName: entityName, into: viewContext) as! T
        configure(newItem)
        await saveContext()
        return newItem
    }
    
    func deleteItem(_ item: T) async {
        viewContext.delete(item)
        await saveContext()
    }
    
    func deleteAll() async throws {
        let items = try await fetchItems()
        items.forEach(viewContext.delete)
        await saveContext()
    }
    
    // MARK: - Save Operations
    
    func saveContext() async {
        guard viewContext.hasChanges else { return }
        
        await viewContext.perform {
            do {
                try self.viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error saving \(self.entityName): \(nsError), \(nsError.userInfo)")
                // In production, you might want to handle this more gracefully
            }
        }
    }
}
