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
    func createOrUpdateItem(
        predicate: NSPredicate? = nil,
        configure: (T) -> Void = { _ in }
    ) async -> T {
        var item: T
        
        if let predicate = predicate {
            // Try to find existing item
            let request = NSFetchRequest<T>(entityName: entityName)
            request.predicate = predicate
            request.fetchLimit = 1
            
            do {
                let existingItems = try viewContext.fetch(request)
                if let existingItem = existingItems.first {
                    item = existingItem
                } else {
                    item = NSEntityDescription.insertNewObject(forEntityName: entityName, into: viewContext) as! T
                }
            } catch {
                // If fetch fails, create new item
                item = NSEntityDescription.insertNewObject(forEntityName: entityName, into: viewContext) as! T
            }
        } else {
            // No predicate provided, always create new item
            item = NSEntityDescription.insertNewObject(forEntityName: entityName, into: viewContext) as! T
        }
        
        configure(item)
        await saveContext()
        return item
    }
    
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
    
    func deleteItem(with id: String) async {
        let predicate = NSPredicate(format: "id == %@", id)
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let items = try viewContext.fetch(request)
            if let item = items.first {
                viewContext.delete(item)
                await saveContext()
            }
        } catch {
            print("Error deleting item with id \(id): \(error)")
        }
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
