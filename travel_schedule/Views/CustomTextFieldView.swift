//
//  CustomTextFieldView.swift
//  travel_schedule
//
//  Created by Иван Иван on 30.04.2025.
//

import SwiftUI

struct CustomTextFieldView: View {
    @Binding var text: String?
    var placeHolder: String
    var onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            ZStack(alignment: .leading) {
                
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
    }
}

#Preview {
    CustomTextFieldView(text: .constant("TEXT"), placeHolder: "PLACE") {
        
    }
}
