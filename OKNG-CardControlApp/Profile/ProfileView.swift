//
//  ProfileView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/15.
//

import SwiftUI
import FirebaseFirestore

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var Username: String = ""
    @Binding var Gmail: String
    
    @State private var Showshould_SetteingView = false
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "chevron.backward").resizable().scaledToFit().frame(width: 70, height: 70).foregroundColor(Color.black)
                }.padding()
                Spacer()
                HStack{
                    Image(systemName: "person").resizable().scaledToFit().frame(width: 80, height: 80)
                    Text("Profile").font(.system(size: 35)).fontWeight(.black)
                }.padding()
            }
            Spacer()
            VStack{
                VStack{
                    Image(systemName: "person").resizable().scaledToFit().frame(width: 80, height: 80).foregroundColor(Color.white)
                }.frame(width: 100, height: 100).background(Color.white.opacity(0.5)).cornerRadius(10).padding()
                Text(Username).font(.title).fontWeight(.bold).foregroundStyle(Color.white)
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        Showshould_SetteingView = true
                    }){
                        HStack{
                            Image(systemName: "gearshape.fill").resizable().scaledToFit().frame(width: 40, height: 40).foregroundColor(Color.white)
                        }.frame(width: 100, height: 60).background(Color.black).cornerRadius(20)
                    }.padding()
                }
            }.frame(width: 300, height: 450).background(Color.blue).cornerRadius(10).padding()
            Spacer()
        }
        .onAppear{
            UsernameGet()
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $Showshould_SetteingView){
            SettingView(Gmail: $Gmail, Username: $Username)
        }
    }
    private func UsernameGet(){
        let db = Firestore.firestore()

        db.collection("UserList").document(Gmail).getDocument { (document, error) in
            if let document = document, document.exists {
                if let username = document.data()?["Username"] as? String {
                    Username = username
                }
            }
        }
    }
}
