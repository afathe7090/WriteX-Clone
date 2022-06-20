//
//  RealmDataBaseManager.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 20/06/2022.
//

import Foundation
import RealmSwift
import UIKit

protocol RealmDBManagerProtocol: AnyObject{
    func insert<T: Object>(_ model: T)
    func read<T: Object>(_ model: T.Type ,completion: @escaping([T])-> Void)
    func readByIndex<T: Object>(_ model: T.Type,at index: Int ,completion: @escaping(T)-> Void)
    func deleteObj<T: Object>(_ model: T)
    func deleteByIndex<T: Object>(_ model: T.Type, at index: Int)
    func deletAll()
}



extension UIViewController {
    var realm: RealmDBManagerProtocol {
        return RealmDBManager()
    }
}




/// Description
/// - Container To do all operation that in Protocol
class RealmDBManager: RealmDBManagerProtocol{
    
    private let realm: Realm = try! Realm()
    
    var notificationToken: NotificationToken?
    
    
    /// Description
    /// - insert data in model bt Object
    func insert<T: Object>(_ model: T){
        do{
            try realm.write({
                self.realm.add(model.self)
                print("Added Model")
            })
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    /// Description
    /// - Used To Read all data
    func read<T: Object>(_ model: T.Type ,completion: @escaping([T])-> Void){
        let objects = realm.objects(model.self)
        completion(objects.toArray(ofType: T.self))
    }
    
    
    /// Description
    /// - Read data by index
    /// - It comman used in tableView or CollectionView
    func readByIndex<T: Object>(_ model: T.Type,at index: Int ,completion: @escaping(T)-> Void){
        let objects = realm.objects(model.self)
        guard index <= objects.count - 1 else{return}
        print("Read bt index")
        completion(objects[index])
    }
    
    
    
    /// Description
    /// - Delete all data in Realm
    func deletAll(){
        do{
            try realm.write({
                realm.deleteAll()
                print("delete all ")
            })
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    /// Delete by object
    /// - Taking Model Of Object
    func deleteObj<T: Object>(_ model: T){
        
        do{
            try realm.write({
                realm.delete(model.self)
            })
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    /// Delete Object Bt index
    ///  - Take the Modek of Object that store in Realm
    ///  - at Take the Index Of Parametars and delete it By index
    ///  - We Can Use it in tableVIew or collectioView To remove By iNdex
    func deleteByIndex<T: Object>(_ model: T.Type, at index: Int){
        let objects = realm.objects(model.self)
        guard index <= objects.count - 1 else{print("Error Of index");return}
        do{
            try realm.write({
                print(objects[index])
                realm.delete(objects[index])
                print("Delete")
            })
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
    /// To observe To change in Realm DB with completions
    ///  - model is the class of Object the stored data by structure
    ///  - initialCompletion:  what to do if changed in realm
    ///  - updateCompletion: Update by ( deletations , insertaion , modifications) to update data that changed
    ///  - errorCompletion: Return error to Observe
    func observeToChange<T: Object>(_ model: T.Type, initialCompletion: @escaping()->Void ,updateCompletion: @escaping (([Int], [Int], [Int])->Void), errorCompletion: @escaping(Error)->Void){
        
        let objects = realm.objects(model.self)
        notificationToken = objects.observe(on: DispatchQueue.main) { realmChange in
            switch realmChange {
            case .initial:
                initialCompletion()
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                updateCompletion(deletions , insertions , modifications)
            case .error(let error):
                errorCompletion(error)
            }
        }
    }
    
    
}


extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
