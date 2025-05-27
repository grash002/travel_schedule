//
//  ProgressBarView.swift
//  travel_schedule
//
//  Created by Иван Иван on 27.05.2025.
//

import SwiftUI

// MARK: - ProgressBarView

struct ProgressBarView: View {
    
    // MARK: - Public properties
    
    let numberOfSections: Int
    let progress: CGFloat
    
    // MARK: - Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                progressBar(geometry)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
        .frame(height: 6)
    }
    
    // MARK: - ViewBuilders
    
    @ViewBuilder
    func progressBar(_ geometry: GeometryProxy) -> some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .frame(width: geometry.size.width, height: .progressBarHeight)
            .foregroundColor(.white)
        
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .frame(
                width: min(
                    progress * geometry.size.width,
                    geometry.size.width
                ),
                height: .progressBarHeight
            )
            .foregroundColor(Color.blue)
    }
    @ViewBuilder
    func MaskView(numberOfSections: Int) -> some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView
            }
        }
    }
    
    // MARK: - Views
    
    var MaskFragmentView: some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: .progressBarHeight)
            .foregroundStyle(.white)
    }
}

#Preview {
    ProgressBarView(numberOfSections: 5, progress: 0.5)
}
