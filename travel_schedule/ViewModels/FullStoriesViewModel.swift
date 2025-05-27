//
//  PreviewViewModel.swift
//  travel_schedule
//
//  Created by Иван Иван on 26.05.2025.
//

import SwiftUI
import Combine

// MARK: - FullStoriesViewModel

final class FullStoriesViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var stories: [Story] = [.story1, .story2, .story3, .story4, .story5, .story6]
    @Published var progress: CGFloat = 0
    @Published var timer: Timer.TimerPublisher
    var currentStory: Story { stories[currentStoryIndex] }
    var currentStoryIndex: Int { Int(progress * CGFloat(stories.count)) }
    
    // MARK: - Private properties
    
    private let configuration: StoryConfig
    @Published private var cancellable: Cancellable?
    
    // MARK: - Initializers
    
    init(stories: [Story] = [.story1, .story2, .story3, .story4, .story5, .story6]) {
        self.stories = stories
        configuration = StoryConfig(storiesCount: stories.count)
        timer = Self.createTimer(configuration: configuration)
    }
    
    // MARK: - Public methods
    
    func setProgress(story: Story){
        if let index = stories.firstIndex(of: story){
            progress = CGFloat(index) / CGFloat(stories.count)
        }
    }
    func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        withAnimation {
            progress = nextProgress
        }
    }
    func nextStory() {
        let storiesCount = stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
        stories[nextStoryIndex].wasRead = true
    }
    func previousStory() {
        let storiesCount = stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex - 1 > 0 ? currentStoryIndex - 1 : 0
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
        stories[nextStoryIndex].wasRead = true
    }
    func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    func onAppear() {
        stories[currentStoryIndex].wasRead = true
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    func onDisappear() {
        cancellable?.cancel()
    }
    func onReceive() {
        timerTick()
    }

    private static func createTimer(configuration: StoryConfig) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
    
}
