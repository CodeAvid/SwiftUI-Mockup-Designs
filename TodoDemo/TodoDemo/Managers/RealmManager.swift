//
//  RealmManager.swift
//  TodoDemo
//
//  Created by Benjamin Akhigbe on 20/01/2022.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject{
    
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    init(){
        openRealm()
        getTask()
    }
    
    // MARK: - Open a new Realm
    
    func openRealm(){
        do{
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
           localRealm = try Realm()
            
        }catch{
            print("Error opening Realm \(error)")
        }
    }
    
    
    // MARK: - Add Task to Realm
    
    func addTask(taskTitle: String){
        
        if let localRealm = localRealm {
            do {
                try localRealm.write{
                    let newTask = Task(value: ["title": taskTitle, "completed": false])
                    localRealm.add(newTask)
                    getTask()
                    print("added new task to realm \(newTask)")
                }
            } catch  {
                    print("Error adding task to Realm \(error)")
            }
        }
        
    }
    
    
    // MARK: - Get all Tasks from Realm
    
    func getTask() {
        let allTask = localRealm?.objects(Task.self).sorted(byKeyPath: "completed")
        tasks = []
        allTask?.forEach{ task in
            tasks.append(task)
        }
    }
    
    
    // MARK: - Update Task in Realm
    
    func updateTask(id: ObjectId, completed: Bool){
        if let localRealm = localRealm {
            do {
                
               let taskToUpdate =  localRealm.objects(Task.self).filter(NSPredicate(format: "id == id", id))
                
                guard !taskToUpdate.isEmpty else { return }
                
                try localRealm.write({
                    taskToUpdate[0].completed = completed
                    getTask()
                    print("Updated task with \(id): Completed status: \(completed)")
                    
                })
            } catch  {
                print("Error updating task \(id) in Realm \(error)")
            }
        }
    }
    
    // MARK: - Delete Task in Realm
    
    func deleteTask(id: ObjectId){
        if let localRealm = localRealm {
            do {
                
                let taskToDelete =  localRealm.objects(Task.self).filter(NSPredicate(format: "id == id", id))
                
                guard !taskToDelete.isEmpty else { return }
                 
                try localRealm.write{
                    localRealm.delete(taskToDelete)
                    getTask()
                    print("Deleted Task with id \(id)")
                }
            } catch {
                print("Error deleting task \(id) from Realm \(error)")
            }
        }
    }
}


