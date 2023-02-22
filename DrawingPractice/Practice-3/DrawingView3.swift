//
//  DrawingView3.swift
//  DrawingPractice
//
//  Created by Berkay Disli on 22.02.2023.
//

import Foundation

import SwiftUI
import PencilKit

struct DrawingView3: UIViewRepresentable {
    
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: UIColor.black, width: 15)
        canvasView.backgroundColor = UIColor.white
        canvasView.isOpaque = false
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // No need to update the view here.
    }
}
