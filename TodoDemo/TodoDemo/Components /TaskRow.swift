//
//  TaskRow.swift
//  TodoDemo
//
//  Created by Benjamin Akhigbe on 19/01/2022.
//

import SwiftUI

struct TaskRow: View {
    var task: String
    var isCompleted: Bool
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: isCompleted ? "checkmark.circle": "circle")
            Text(task)
            
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: "Do Laundry", isCompleted: true)
    }
}
