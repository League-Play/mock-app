//
//  LobbyView.swift
//  mock-app
//
//  Created by Eric Ming on 11/2/23.
//

import SwiftUI

struct LobbyView: View {
    @EnvironmentObject var websocket: WebsocketModel;
    @State private var textInput = "";
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            TextField(
                "Send this to websocket",
                text: $textInput
            ).onSubmit {
                websocket.sendMessage(textInput)
            }
            List(websocket.messages, id: \.self) { message in
                Text(message)
            }
        }
        .padding()
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView()
    }
}
