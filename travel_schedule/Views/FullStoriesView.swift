//
//  StoryDetailedView.swift
//  travel_schedule
//
//  Created by Иван Иван on 26.05.2025.
//

import SwiftUI
import Combine

// MARK: - FullStoriesView

struct FullStoriesView: View {
    
    // MARK: - Public properties
    
    @StateObject var viewModel: FullStoriesViewModel
    @Binding var path: NavigationPath
    @State private var dragOffset: CGFloat = 0
    
    // MARK: - Content
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black
                .ignoresSafeArea()
            storyView
                .offset(x: dragOffset)
                .opacity(1 - Double(abs(dragOffset) / 200))
                .animation(.easeInOut(duration: 0.3), value: dragOffset)
            
            progressAndCloseView
        }
        .background(Color.black.ignoresSafeArea())
        .onTapGesture {
            viewModel.nextStory()
            viewModel.resetTimer()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
        .onReceive(viewModel.timer) { _ in
            viewModel.onReceive()
        }
        .gesture(drag)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Views
    
    var storyView: some View {
        Group {
            Image(viewModel.currentStory.backgroundImage)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 40))
            VStack(spacing: 16) {
                Spacer()
                Text(viewModel.currentStory.title)
                    .font(.system(size: 34, weight: .bold))
                Text(viewModel.currentStory.description)
                    .font(.system(size: 17))
            }
            .foregroundColor(.white)
            .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
        }
    }
    
    var progressAndCloseView: some View {
        VStack(alignment: .trailing, spacing: 16) {
            ProgressBarView(numberOfSections: viewModel.stories.count, progress: viewModel.progress)
            
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    path.removeLast()
                    viewModel.onDisappear()
                }
            }) {
                Image("closeButton")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 12)
            }
        }
        .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation.width
            }
            .onEnded { value in
                let threshold: CGFloat = 50
                if value.translation.width < -threshold {
                    withAnimation {
                        dragOffset = -300
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        viewModel.nextStory()
                        viewModel.resetTimer()
                        dragOffset = 0
                    }
                } else if value.translation.width > threshold {
                    withAnimation {
                        dragOffset = 300
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        viewModel.previousStory()
                        viewModel.resetTimer()
                        dragOffset = 0
                    }
                } else {
                    withAnimation {
                        dragOffset = 0
                    }
                }
            }
    }
}

// MARK: - Preview

#Preview {
    FullStoriesView(viewModel: FullStoriesViewModel(), path: .constant(NavigationPath()))
}
