//
//  Story.swift
//  travel_schedule
//
//  Created by Иван Иван on 26.05.2025.
//

import SwiftUI

// MARK: - Story

final class Story: Identifiable, ObservableObject, Hashable {
    
    // MARK: - Public properties
    
    let id: UUID = UUID()
    let backgroundImage: String
    let title: String
    let description: String
    @Published var wasRead: Bool = false
    
    // MARK: - Public static properties
    
    static let title = "Text Text Text Text Text Text Text Text Text Text"
    static let description = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"

    static let story1 = Story(backgroundImage: "story1", title: title, description: description)
    static let story2 = Story(backgroundImage: "story2", title: title, description: description)
    static let story3 = Story(backgroundImage: "story3", title: title, description: description)
    static let story4 = Story(backgroundImage: "story4", title: title, description: description)
    static let story5 = Story(backgroundImage: "story5", title: title, description: description)
    static let story6 = Story(backgroundImage: "story6", title: title, description: description)
    
    // MARK: - Initializers
    
    init(backgroundImage: String, title: String, description: String) {
        self.backgroundImage = backgroundImage
        self.title = title
        self.description = description
    }
    
    // MARK: - Hashable methods
    
    static func == (lhs: Story, rhs: Story) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
