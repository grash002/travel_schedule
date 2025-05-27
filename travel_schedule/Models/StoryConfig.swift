//
//  File.swift
//  travel_schedule
//
//  Created by Иван Иван on 27.05.2025.
//

import Foundation

// MARK: - StoryConfig

struct StoryConfig {
    
    // MARK: - Public properties
    
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat
    
    // MARK: - Initializers
    
    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.25
    ) {
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}
