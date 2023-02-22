//
//  LineModel1.swift
//  DrawingPractice
//
//  Created by Berkay Disli on 22.02.2023.
//

import Foundation
import SwiftUI

struct LineModel1: Identifiable {
    let id = UUID()
    var points: [CGPoint]
    var linewidth: CGFloat
    var color: Color
}
