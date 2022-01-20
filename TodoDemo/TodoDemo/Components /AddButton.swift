//
//  SmallAddButton.swift
//  TodoDemo
//
//  Created by Benjamin Akhigbe on 19/01/2022.
//

import SwiftUI

struct AddButton: View {
    var size: CGFloat = 50
    var body: some View {
        ZStack{
            Circle()
                .frame(width: size)
                .foregroundColor(Color(hue: 0.328, saturation: 0.789, brightness: 0.408))
            
            Text("+")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
        }
        .frame(height: size)
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
