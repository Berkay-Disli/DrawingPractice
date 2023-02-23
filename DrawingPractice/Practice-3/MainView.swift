//
//  MainView.swift
//  DrawingPractice
//
//  Created by Berkay Disli on 22.02.2023.
//

import SwiftUI

struct MainView: View {
    // MARK: Gestures
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
    
    // A new node
    @State private var added = false
    @State private var nodes: [NodeItem] = [
        .init(name: "Parent", bgFilled: true, bgColor: .blue, childNodes: [
            .init(name: "Child-1", bgFilled: false, bgColor: .pink, childNodes: [
                .init(name: "GrandChild-1", bgFilled: true, bgColor: .orange, childNodes: []), .init(name: "GrandChild-2", bgFilled: true, bgColor: .cyan, childNodes: [])]),
            .init(name: "Child-2", bgFilled: false, bgColor: .pink, childNodes: [
                .init(name: "GrandChild-3", bgFilled: true, bgColor: .green, childNodes: []),
                .init(name: "GrandChild-4", bgFilled: false, bgColor: .teal, childNodes: [])])])
    ]
    
    
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                //let size = proxy.size
                
                ZStack {
                    Color.pink.opacity(0.1)
                        .ignoresSafeArea()
                    
                    VStack {
                        VStack {
                            HStack(spacing: 0) {
                                Text("Practice")
                                    .font(.system(size: 22))
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 4)
                                    }
                                    .onTapGesture {
                                        added.toggle()
                                    }
                                
                                if added {
                                    HStack(spacing: 0) {
                                        Rectangle()
                                            .fill(.black)
                                            .frame(width: 50, height: 4)
                                        
                                        Text("Practice 2")
                                            .font(.system(size: 22))
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                            .padding()
                                            .background {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.black, lineWidth: 4)
                                            }
                                    }
                                    .transition(.opacity.animation(.easeInOut))
                                    
                                    
                                }
                                
                            }
                        }
                        
                        
                    }
                    //.frame(width: size.width, height: size.height)
                    .padding()
                    .border(.orange, width: 4)
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

struct NodeItem: Identifiable {
    let id = UUID().uuidString
    let name: String
    let bgFilled: Bool
    let bgColor: Color
    var childNodes: [NodeItem]
}
