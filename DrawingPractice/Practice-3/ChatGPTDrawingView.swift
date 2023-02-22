//
//  ChatGPTDrawingView.swift
//  DrawingPractice
//
//  Created by Berkay Disli on 22.02.2023.
//

import SwiftUI
import PencilKit

struct ChatGPTDrawingView: View {
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    @State private var canvasWidth: CGFloat = UIScreen.main.bounds.width
    @State private var canvasHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
            
                DrawingView3(canvasView: $canvasView)
                    .frame(width: canvasWidth, height: canvasHeight)
                    .background(Color.white)
                    .border(Color.black)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                let scale = max(min(canvasWidth / UIScreen.main.bounds.width * value.magnitude, 2.0), 0.5)
                                canvasWidth = UIScreen.main.bounds.width * scale
                                canvasHeight = UIScreen.main.bounds.height * scale
                            }
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let translation = value.translation
                                canvasView.contentOffset = CGPoint(x: canvasView.contentOffset.x - translation.width, y: canvasView.contentOffset.y - translation.height)
                            }
                    )
                /*
                if let toolPickerView = $toolPicker.visible {
                    toolPickerView
                        .frame(width: 300, height: 300)
                }
                */
            }
            .onAppear {
                canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
                canvasView.backgroundColor = .white
                toolPicker.addObserver(canvasView)
                toolPicker.setVisible(true, forFirstResponder: canvasView)
            }
        }
    }
}

struct ChatGPTDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPTDrawingView()
    }
}
