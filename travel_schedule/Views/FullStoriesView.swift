//
//  StoryDetailedView.swift
//  travel_schedule
//
//  Created by Иван Иван on 26.05.2025.
//

import SwiftUI

struct FullStories: View {
    var story: Story
    var animation: Namespace.ID
    @StateObject var viewModel: FullStoriesViewModel
    @Binding var isShown: Bool
    @Binding var currentStoryIndex: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black
                .ignoresSafeArea()
            Image(story.backgroundImage)
                .resizable()
                .scaledToFill()
                .matchedGeometryEffect(id: story.id, in: animation)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Spacer()
                Text(story.title)
                    .font(.system(size: 34, weight: .bold))
                Text(story.description)
                    .font(.system(size: 17))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
            
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    isShown = false
                }
            }) {
                Image("closeButton")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .transition(.opacity)
        .onTapGesture {
            viewModel.nextStory()
        }
    }
}


#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @Namespace var animation
    @State var isShown = true
    
    var body: some View {
        FullStories(
            story: Story.story1,
            animation: animation,
            viewModel: FullStoriesViewModel(),
            isShown: $isShown,
            currentStoryIndex: .constant(0)
        )
    }
}
