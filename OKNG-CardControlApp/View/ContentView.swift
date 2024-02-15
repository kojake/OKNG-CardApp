//
//  ContentView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/07.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    @Binding var Gmail: String
    @State var UserStatus: String = ""
    @State var CardStatus: Bool = false
    
    var body: some View {
        VStack{
            if UserStatus == "Student"{
                StatusView(Gmail: $Gmail, CardStatus: $CardStatus)
            } else {
                ControlView()
            }
        }
        .onAppear{
            UserDataGet()
        }
    }
    private func UserDataGet(){
        let db = Firestore.firestore()
        
        //UserStatus
        db.collection("UserList").document(Gmail).getDocument { (document, error) in
            if let document = document, document.exists {
                if let userstatus = document.data()?["UserStatus"] as? String {
                    UserStatus = userstatus
                }
            }
        }
        //CardStatus
        db.collection("UserList").document(Gmail).getDocument { (document, error) in
            if let document = document, document.exists {
                if let cardstatus = document.data()?["CardStatus"] as? Bool {
                    CardStatus = cardstatus
                }
            }
        }
    }
}
