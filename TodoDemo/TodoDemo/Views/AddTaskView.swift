//
//  AddTaskView.swift
//  TodoDemo
//
//  Created by Benjamin Akhigbe on 19/01/2022.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("Create new task")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
    TextField("Enter your task here", text: $title)
                .textFieldStyle(.roundedBorder)
            Button{
                print("Task added")
                dismiss()
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
        .ignoresSafeArea()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
