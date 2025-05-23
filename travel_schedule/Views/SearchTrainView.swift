//
//  SearchTrainView.swift
//  travel_schedule
//
//  Created by Иван Иван on 30.04.2025.
//

import SwiftUI

//MARK: - SearchTrainView

struct SearchTrainView: View {
    
    //MARK: - Properties
    
    @Binding var departurePoint: Station
    @Binding var arrivalPoint: Station
    @Binding var selectedField: SelectedField?
    @Binding var path: NavigationPath
    @State var isNavigated: Bool = false
    private let imageHeight: Double = 36

    //MARK: - Content
    
    var body: some View {
            ZStack {
                Color.blue
                HStack {
                    textFields
                    switchButton
                }
            }
            .frame(height: 128)
            .cornerRadius(20)
    }
    
    //MARK: - Views
    
    private var textFields: some View {
        VStack {
            CustomTextFieldView(text: Binding(get: { departurePoint.name }, set: {newValue in
                guard let newValue else { return }
                departurePoint.name = newValue  }),
                                placeHolder: "Откуда") {
                path.append(SelectedField.departure)
                }
                CustomTextFieldView(text: Binding(get: { arrivalPoint.name }, set: {newValue in
                    guard let newValue else { return }
                    arrivalPoint.name = newValue }),
                                    placeHolder: "Куда") {
                    selectedField = .arrival
                    path.append(SelectedField.arrival)
                }
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding(16)
    }
    private var switchButton: some View {
        Button {
            swap(&departurePoint, &arrivalPoint)
        } label: {
            Image(systemName: "arrow.2.squarepath")
                .resizable()
                .foregroundColor(.blue)
                .scaledToFit()
                .padding(6)
                .frame(width: imageHeight, height: imageHeight)
                .background(Color.white)
                .cornerRadius(imageHeight / 2)
        }
        .padding(.trailing, 16)
    }
}

//MARK: - Preview

#Preview {
    SearchTrainView(departurePoint: .constant(Station(name: "", code: "")),
                    arrivalPoint: .constant(Station(name: "", code: "")),
                    selectedField: .constant(.arrival),
                    path: .constant(NavigationPath()))
}
