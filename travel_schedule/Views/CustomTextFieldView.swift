//
//  CustomTextFieldView.swift
//  travel_schedule
//
//  Created by Иван Иван on 30.04.2025.
//

import SwiftUI

// MARK: - CustomTextFieldView

struct CustomTextFieldView: View {
    
    // MARK: - Public properties
    
    @Binding var text: String?
    var placeHolder: String
    var onTap: () -> Void
    
    // MARK: - Content
    
    var body: some View {
        Button {
            onTap()
        } label: {
            buttonLabel
        }
    }
    
    // MARK: - Views
    
    private var buttonLabel: some View {
        ZStack(alignment: .leading) {
            textTitle
            if ((text ?? "").isEmpty) {
                Text(placeHolder)
                    .font(.system(size: 17))
                    .frame(maxHeight: 48)
                    .padding(.leading, 16)
                    .foregroundColor(.gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    private var textTitle: some View {
        TextField("", text: Binding(
            get: { text ?? ""},
            set: {newValue in text = newValue}))
        .foregroundColor(Color.black)
        .font(.system(size:17))
        .frame(maxHeight: 48)
        .padding(.horizontal, 16)
        .multilineTextAlignment(.leading)
        .background(Color.white)
        .disabled(true)
    }
}

// MARK: - Preview

#Preview {
    CustomTextFieldView(text: .constant("TEXT"), placeHolder: "PLACE") {
        
    }
}
