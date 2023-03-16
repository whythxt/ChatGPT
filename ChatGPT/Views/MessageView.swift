//
//  MessageView.swift
//  ChatGPT
//
//  Created by Yurii on 16.03.2023.
//

import SwiftUI

struct MessageView: View {
    @Environment(\.colorScheme) var colorScheme

    var gptColor: Color {
        colorScheme == .dark ? .white : .black
    }

    var gptBackground: Color {
        colorScheme == .dark ? .white.opacity(0.3) : .gray.opacity(0.1)
    }

    let msg: Message

    var body: some View {
        HStack {
            if msg.sender == .user { Spacer() }

            HStack {
                if msg.sender == .gpt {
                    Image("gpt")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }

                Text(msg.content)
                    .foregroundColor(msg.sender == .user ? .white : gptColor)
                    .padding()
                    .background(msg.sender == .user ? Color("GreenColor") : gptBackground)
                    .cornerRadius(15)
            }

            if msg.sender == .gpt { Spacer() }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(msg: .example[0])
    }
}
