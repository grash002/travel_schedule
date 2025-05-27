//
//  PreviewViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 26.05.2025.
//

import SwiftUI

final class FullStoriesViewModel: ObservableObject {
    @Published var stories: [Story] = [.story1, .story2, .story3, .story4, .story5, .story6]
    @Published var currentStoryIndex = 0
    @Published var path = NavigationPath()
    
    func nextStory() {
        let nextValue = currentStoryIndex + 1
        if nextValue <= stories.count - 1 {
            currentStoryIndex = nextValue
        } else {
            currentStoryIndex = 0
        }
    }
}
