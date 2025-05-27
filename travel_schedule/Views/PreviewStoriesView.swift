//
//  PreviewStories.swift
//  travel_schedule
//
//  Created by Иван Иван on 26.05.2025.
//

import SwiftUI

// MARK: - PreviewStoriesView

struct PreviewStoriesView: View {
    
    // MARK: - Public properties
    
    @ObservedObject var viewModel: FullStoriesViewModel
    @Binding var path: NavigationPath
    
    // MARK: - Content
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal){
                HStack(spacing: 12) {
                    storiesView
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    // MARK: - Views
    
    var storiesView: some View {
        ForEach(viewModel.stories, id: \.self) { story in
            preview(story: story)
                .frame(width: 92, height: 140)
                .opacity(story.wasRead ? 0.5 : 1)
                .onTapGesture {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)){
                        viewModel.setProgress(story: story)
                        path.append("FullStoriesView")
                    }
                }
        }
    }
    
    // MARK: - ViewBuilders
    
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

// MARK: - Preview

#Preview {
    PreviewStoriesView(viewModel: FullStoriesViewModel(), path: .constant(NavigationPath()))
}
