//
//  DrawingView1.swift
//  DrawingPractice
//
//  Created by Berkay Disli on 22.02.2023.
//

import SwiftUI

struct DrawingView1: View {
    @State private var selectedColor: Color = .black
    @State private var lines = [LineModel1]()
    @State private var undoLines = [LineModel1]()
    
    
    var body: some View {
        VStack {
            ColorPicker1(selectedColor: $selectedColor)
            
            Canvas { context, size in
                for line in lines {
                    let path = createPath(for: line.points)
                    context.stroke(path,
                                   with: .color(line.color),
                                   lineWidth: 4)
                }
            }
            .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                if value.translation.width + value.translation.height == 0 {
                    //length of line is zero -> new line
                    lines.append(LineModel1(points: [CGPoint](), linewidth: 1, color: selectedColor))
                } else {
                    let index = lines.count - 1
                    lines[index].points.append(value.location)
                }
            }))
            
            HStack {
                Button {
                    let line = lines.remove(at: lines.count - 1)
                    undoLines.append(line)
                    
                } label: {
                    Image(systemName: "chevron.backward.square.fill")
                        .imageScale(.large)
                    Text("Undo")
                }.disabled(lines.count == 0)
                
                Button {
                    let line = undoLines.removeLast()
                    lines.append(line)
                } label: {
                    Image(systemName: "chevron.forward.square.fill")
                        .imageScale(.large)
                    Text("Redo")
                }.disabled(undoLines.count == 0)
                
                Spacer()
                
                Button("Delete", role: .destructive) {
                    lines = [LineModel1]()
                    undoLines = [LineModel1]()
                }
            }
            .padding()
            
        }
    }
    
    
    func createPath(for line: [CGPoint]) -> Path {
        var path = Path()
        if let firstPoint = line.first {
            //use scaling factor
            path.move(to:firstPoint)
        }
        if line.count > 2 {
            for index in 1..<line.count {
                let mid = calculateMidPoint(line[index - 1], line[index])
                path.addQuadCurve(to: mid, control: line[index - 1])
            }
        }
        if let last = line.last {
            path.addLine(to: last)
        }
        return path
    }
    
    func calculateMidPoint(_ point1: CGPoint, _ point2: CGPoint) -> CGPoint {
        let newMidPoint = CGPoint(x: (point1.x + point2.x)/2, y: (point1.y + point2.y)/2)
        return newMidPoint
    }
}

struct DrawingView1_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView1()
    }
}
