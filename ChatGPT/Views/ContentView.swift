//
//  ContentView.swift
//  ChatGPT
//
//  Created by Yurii on 16.03.2023.
//

import Combine
import SwiftUI

struct ContentView: View {
    @State private var messages = [Message]()
    @State private var text = ""
    @State private var cancellables = Set<AnyCancellable>()

    let service = OpenAIService()

    var disabled: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack {
            scroll
            txtfield
        }
        .padding()

    }

    var scroll: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(messages, id: \.id) { msg in
                    MessageView(msg: msg)
                }
            }
        }
    }

    var txtfield: some View {
        HStack {
            TextField("Enter a message", text: $text)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)

            Button {
                send()
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(disabled ? .gray : Color("GreenColor"))
                    .cornerRadius(10)
            }
            .disabled(disabled)
        }
    }

    func send() {
        let userMsg = Message(id: UUID().uuidString, content: text, date: Date(), sender: .user)
        messages.append(userMsg)

        service.send(msg: text).sink { completion in
        } receiveValue: { response in
            guard let answer = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

            let gptMsg = Message(id: response.id, content: answer, date: Date(), sender: .gpt)
            messages.append(gptMsg)
        }
        .store(in: &cancellables)

        text = ""
        hideKeyboard()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
