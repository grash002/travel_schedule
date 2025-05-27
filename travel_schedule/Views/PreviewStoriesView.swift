//
//  PreviewStories.swift
//  travel_schedule
//
//  Created by Иван Иван on 26.05.2025.
//

import SwiftUI

struct PreviewStoriesView: View {
    @StateObject private var viewModel = FullStoriesViewModel()
    @Namespace var animation
    
    var body: some View {
        ZStack {
            
            if let selectedStory = viewModel.selectedStory, viewModel.showFullScreen {
                FullStories(story: selectedStory,
                            animation: animation,
                            viewModel: viewModel,
                            isShown: $viewModel.showFullScreen,
                            currentStoryIndex: $viewModel.currentStoryIndex)
            } else {
                ScrollView(.horizontal){
                    HStack(spacing: 12) {
                        ForEach(viewModel.stories, id: \.self) { story in
                            preview(story: story)
                                .frame(width: 92, height: 140)
                                .opacity(story.wasRead ? 0.5 : 1)
                                .matchedGeometryEffect(id: story.id, in: animation)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)){
                                        viewModel.selectedStory = story
                                        viewModel.showFullScreen = true
                                        if let index = viewModel.stories.firstIndex(where: {$0.id == story.id }) {
                                            viewModel.currentStoryIndex = index
                                        }
                                    }
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .onAppear {
                    viewModel.stories[0].wasRead.toggle()
                }
            }
        }
    }
    
    @ViewBuilder
    private func preview(story: Story) -> some View {
        ZStack {
            backgroundImage(story: story)
            VStack {
                Spacer()
                Text(story.title)
                    .foregroundStyle(.white)
                    .font(.system(size: 12))
                    .lineLimit(3)
            }
            .padding(.bottom, 12)
            .padding(.horizontal, 8)
        }
    }
    @ViewBuilder
    private func backgroundImage(story: Story) -> some View {
        Image(story.backgroundImage)
            .resizable()
            .frame(width: 84, height: 132)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                !story.wasRead
                ? AnyView(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.blue, lineWidth: 4)
                ) : AnyView(EmptyView())
            )
    }
}

#Preview {
    PreviewStoriesView()
}
