//
//  LoginView.swift
//  mock-app
//
//  Created by Eric Ming on 11/2/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var websocket: WebsocketModel
    @Binding var username: String
    var body: some View {
        VStack {
            TextField("username", text: $username)
                .padding()
            Button("Join Lobby") {
                websocket.sendMessage(JoinLobbyAction(username: username).encodeToString()!)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(username: .constant("eric"))
    }
}
