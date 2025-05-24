//
//  ChoiceCityView.swift
//  travel_schedule
//
//  Created by Иван Иван on 05.05.2025.
//

import SwiftUI

// MARK: - ChoiceCityView

struct ChoiceCityView: View {
    
    // MARK: - Public properties
    
    @Binding var selectedCity: String?
    @Binding var path: NavigationPath
    @ObservedObject var viewModel: ChoiceCityViewModel
    @State var isNavigated = false
    var onSelected: () -> Void
    
    // MARK: - Content
    
    var body: some View {
        mainView
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                backToolBarContent
                titleToolBarContent
            }
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private var mainView: some View {
        if let error = viewModel.error {
            switch error {
            case .ServerError:
                ServerErrorView()
            case .InternetError:
                InternetErrorView()
            default:
                ServerErrorView()
            }
        } else if viewModel.isLoading {
            progressView
        }
        else {
            cityList
        }
    }
    @ViewBuilder
    private var cityList: some View {
        if !viewModel.filteredCity.isEmpty {
            mainScroll
        } else {
            notFoundView
        }
    }
    private var progressView: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
    private var notFoundView: some View {
        VStack {
            Spacer()
            Text("Город не найден")
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height)
    }
    private var mainScroll: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredCity) { station in
                    ChoiceCityRowView(station: station)
                        .onTapGesture {
                            selectedCity = station.name
                            onSelected()
                        }
                }
            }
        }
    }
    
    
    // MARK: - ToolBarContent
    
    private var backToolBarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                path.removeLast()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.primary)
                    .imageScale(.large)
            }
        }
    }
    private var titleToolBarContent: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("Выбор города")
                .font(.system(size: 17,weight: .bold))
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Preview

#Preview {
    ChoiceCityView(selectedCity: .constant(""),
                   path: .constant(NavigationPath()),
                   viewModel: ChoiceCityViewModel()){ }
}
