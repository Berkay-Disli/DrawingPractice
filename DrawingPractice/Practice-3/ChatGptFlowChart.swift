//
//  ChatGptFlowChart.swift
//  DrawingPractice
//
//  Created by Berkay Disli on 24.02.2023.
//

import SwiftUI

struct ChatGptFlowChart: View {
    let parent = PracticeNode(name: "Parent", children: [
        PracticeNode(name: "Child 1", children: [
            PracticeNode(name: "Grandchild 1-1", children: []),
            PracticeNode(name: "Grandchild 1-2", children: [])
        ]),
        PracticeNode(name: "Child 2", children: [
            PracticeNode(name: "Grandchild 2-1", children: []),
            PracticeNode(name: "Grandchild 2-2", children: [])
        ])
    ])
    
    var body: some View {
        VStack {
            if !parent.children.isEmpty {
                createChildNodeViews(parent)
                    .padding(.top, 50)
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func createChildNodeViews(_ node: PracticeNode) -> some View {
        HStack(spacing: 50) {
            ForEach(node.children) { child in
                createNodeView(child)
            }
        }
    }
    
    
    @ViewBuilder
    func createNodeView(_ node: PracticeNode) -> some View {
        VStack {
            Text(node.name)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            if !node.children.isEmpty {
                HStack(spacing: 50) {
                    ForEach(node.children) { child in
                        createNodeView(child)
                    }
                }
            }
        }
    }
    
    
}

struct ChatGptFlowChart_Previews: PreviewProvider {
    static var previews: some View {
        ChatGptFlowChart()
    }
}

struct PracticeNode: Identifiable {
    let id = UUID().uuidString
    let name: String
    var children: [PracticeNode]
}

