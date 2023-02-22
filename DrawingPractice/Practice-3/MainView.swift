//
//  MainView.swift
//  DrawingPractice
//
//  Created by Berkay Disli on 22.02.2023.
//

import SwiftUI

struct MainView: View {
    @GestureState var magnifyBy = 1.0
    @State var magScale: CGFloat = 1
    @State var progressingScale: CGFloat = 1
    @State var dragged = CGSize.zero
    @State private var accumulated = CGSize.zero
    
    var magnify: some Gesture {
        MagnificationGesture()
            .onChanged { progressingScale = $0 }
            .onEnded {
                magScale *= $0
                progressingScale = 1
            }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged{ value in
                self.dragged = CGSize(width: value.translation.width + self.accumulated.width, height: value.translation.height + self.accumulated.height)
            }
            .onEnded{ value in
                self.dragged = CGSize(width: value.translation.width + self.accumulated.width, height: value.translation.height + self.accumulated.height)
                self.accumulated = self.dragged
            }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let size = proxy.size
                
                ZStack {
                    Color.pink.opacity(0.1)
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("Practice")
                            .font(.system(size: 22))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 4)
                            }
                    }
                    .scaleEffect(self.magScale * progressingScale)
                    .offset(x: dragged.width, y: dragged.height)
                    
                    /*
                     .gesture(
                     DragGesture()
                     .onChanged { value in
                     let translation = value.translation
                     canvasView.contentOffset = CGPoint(x: canvasView.contentOffset.x - translation.width, y: canvasView.contentOffset.y - translation.height)
                     }
                     )
                     */
                }
                .gesture(drag)
                .gesture(magnify)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        magScale = 1
                        progressingScale = 1
                        dragged = .zero
                        accumulated = .zero
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(.black)
                    }
                    
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
