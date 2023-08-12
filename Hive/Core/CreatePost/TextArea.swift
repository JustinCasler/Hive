//
//  TextArea.swift
//  Hive
//
//  Created by justin casler on 4/21/23.
//

import SwiftUI

struct TextArea: View {
    
    @Binding var text: String
    let placeholder: String
    
    init(_ placeholder: String, text: Binding<String>){
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            else {
                TextEditor(text: $text)
                    .padding(4)
            }
        }
        .font(.body)
    }
}

struct TextArea_Previews: PreviewProvider {
    static var previews: some View {
        @State var title = ""
        TextArea("holder", text : $title)
    }
}
