//
//  ShimmerEffect.swift
//  PhotoBoxKit
//
//  Created by Despo on 31.05.25.
//


import SwiftUI

@available(iOS 16, *)
struct ShimmerEffect: View {
  @State private var startingPoint: UnitPoint = .init(x: -1.8, y: -1.2)
  @State private var endingPoint: UnitPoint = .init(x: 0, y: -0.2)
  
  private var gradientColors: [Color] = [
    .gray.opacity(0.2),
    .white.opacity(0.2),
    .gray.opacity(0.2),
  ]
  
  var body: some View {
    LinearGradient(
      colors: gradientColors,
      startPoint: startingPoint,
      endPoint: endingPoint
    )
    .onAppear {
      withAnimation(.easeOut(duration: 1).repeatForever(autoreverses: false)) {
        startingPoint = .init(x: 1, y: 1)
        endingPoint = .init(x: 2.2, y: 2.2)
      }
    }
  }
}
