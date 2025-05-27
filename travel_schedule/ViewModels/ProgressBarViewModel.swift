//
//  ProgressViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 28.05.2025.
//

import Foundation

// MARK: - ProgressViewModel
@MainActor
final class ProgressBarViewModel: ObservableObject {
    
    @Published var numberOfSections: Int
    @Published var progress: CGFloat
    
    init(numberOfSections: Int, progress: CGFloat) {
        self.numberOfSections = numberOfSections
        self.progress = progress
    }
}
