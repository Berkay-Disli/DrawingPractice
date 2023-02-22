//
//  ColorPicker1.swift
//  DrawingPractice
//
//  Created by Berkay Disli on 22.02.2023.
//

import SwiftUI

struct ColorPicker1: View {
    let colors:  [Color] = [.gray, .black, .cyan, .teal ,.blue, .green, .yellow, .orange, .red, .purple, .brown]
    
    @Binding var selectedColor: Color
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack {
                ForEach(colors, id: \.self) { item in
                    item.frame(width: 40, height: 40)
                        .border(item == selectedColor ? Color.white :  Color.clear, width: 4)
                        .shadow(radius: 2)
                        .onTapGesture {
                            selectedColor = item
                        }
                }
            }.padding()
        }
        .frame(height: 50)
    }
}

struct ColorPicker1_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker1(selectedColor: .constant(.green))
    }
}
