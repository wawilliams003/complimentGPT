//
//  ComplimentStorage.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/21/25.
//

import Foundation

struct ComplimentStorage {
    private static var complimentsFileURL: URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0].appendingPathComponent("compliments.json")
    }
    
    
    static func save(_ compliment: Compliment) {
        do {
            var compliments = load()
            compliments.append(compliment)
            let data = try JSONEncoder().encode(compliments)
            try data.write(to: complimentsFileURL, options: [.atomic])
            print("Saved Successfully: \(complimentsFileURL.path)")
            
        } catch {
            print("Error Saving File: \(error)")
        }
    }
    
    
    static func saveAll(_ compliments: [Compliment]) {
        do {
            let data = try JSONEncoder().encode(compliments)
            try data.write(to: complimentsFileURL, options: [.atomic])
            print("Saved All Successfully: \(complimentsFileURL.path)")
        } catch {
            print("Error Saving All: \(error)")
        }
    }
    
    static func load() -> [Compliment] {
        do{
            let data = try Data(contentsOf: complimentsFileURL)
            let compliments = try JSONDecoder().decode([Compliment].self, from: data)
            let sorted = compliments.sorted(by: {$0.date > $1.date})
            return sorted
        }catch{
            print("Error Loading File: \(error)")
            return []
        }
    }
    
    static func delete() {
        do {
            
            try? FileManager.default.removeItem(at: complimentsFileURL)
            print("Delete Succesfully")
        } catch {
            print("Error deleting file: \(error)")
        }
    }
    
    
}
