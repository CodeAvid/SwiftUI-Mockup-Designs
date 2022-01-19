//
//  AddTaskView.swift
//  TodoDemo
//
//  Created by Benjamin Akhigbe on 19/01/2022.
//

import SwiftUI

struct AddTaskView: View {
    
    @State private var title: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Create new task")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
    TextField("Enter your task here", text: $title)
                .textFieldStyle(.roundedBorder)
            Button{
                print("Task added")
            } label: {
                Text("Add task")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color(hue: 0.328, saturation: 0.789, brightness: 0.408))
                    .cornerRadius(20)
            }
            Spacer()
            
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
