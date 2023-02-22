//
//  DrawingView2.swift
//  DrawingPractice
//
//  Created by Berkay Disli on 22.02.2023.
//

import SwiftUI
import PencilKit

struct DrawingView2: UIViewRepresentable {
    // to capture drawings for saving into albums
    @Binding var canvas: PKCanvasView
    @Binding var isdraw: Bool
    @Binding var type: PKInkingTool.InkType
    @Binding var color: Color
    
    
    // Updating inktype
    
     var ink : PKInkingTool {
        
        PKInkingTool(type, color: UIColor(color))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvas.drawingPolicy = .anyInput
        canvas.tool = isdraw ? ink : eraser
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // updating the tool whenever the view updates
        
        uiView.tool = isdraw ? ink : eraser
        
    }
}
