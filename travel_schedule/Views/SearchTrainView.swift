//
//  SearchTrainView.swift
//  travel_schedule
//
//  Created by Иван Иван on 30.04.2025.
//

import SwiftUI

struct SearchTrainView: View {
    @Binding var departurePoint: Station
    @Binding var arrivalPoint: Station
    @Binding var selectedField: SelectedField?
    @Binding var path: NavigationPath
    
    @State var isNavigated: Bool = false

    private let imageHeight: Double = 36

    var body: some View {
            ZStack {
                Color.blue
                HStack {
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
            .frame(height: 128)
            .cornerRadius(20)
    }
}


#Preview {
    SearchTrainView(departurePoint: .constant(Station(name: "", code: "")),
                    arrivalPoint: .constant(Station(name: "", code: "")),
                    selectedField: .constant(.arrival),
                    path: .constant(NavigationPath()))
}
