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
    
    @State private var Showshould_ProfileView = false
    
    var body: some View {
        ZStack{
            NavigationLink(destination: ProfileView(Gmail: $Gmail), isActive: $Showshould_ProfileView){
                EmptyView()
            }
            if UserStatus == "Student"{
                StatusView(Gmail: $Gmail, CardStatus: $CardStatus)
            } else {
                ControlView()
            }
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        Showshould_ProfileView = true
                    }){
                        VStack{
                            Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 50, height: 50).foregroundColor(Color.white)
                        }.frame(width: 80, height: 80).background(Color.black).cornerRadius(10)
                    }.padding()
                    Button(action: {
                        
                    }){
                        VStack{
                            Image(systemName: "message").resizable().scaledToFit().frame(width: 50, height: 50).foregroundColor(Color.white)
                        }.frame(width: 80, height: 80).background(Color.black).cornerRadius(10)
                    }
                }.padding()
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
