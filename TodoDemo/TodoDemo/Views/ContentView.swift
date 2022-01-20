//
//  ContentView.swift
//  TodoDemo
//
//  Created by Benjamin Akhigbe on 19/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAddTaskView =  false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            TaskView()
                AddButton()
                    .padding()
                    .onTapGesture {
                        showAddTaskView.toggle()
                    }
        }
        .sheet(isPresented: $showAddTaskView){
            AddTaskView()
        }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
