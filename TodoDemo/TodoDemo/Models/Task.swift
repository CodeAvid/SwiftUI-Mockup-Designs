//
//  Task.swift
//  TodoDemo
//
//  Created by Benjamin Akhigbe on 20/01/2022.
//

import Foundation
import RealmSwift


class Task: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
}
