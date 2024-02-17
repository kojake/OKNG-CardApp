//
//  SettingView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/16.
//

import SwiftUI
import FirebaseFirestore

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var Gmail: String
    @State var Username: String = ""
    @State var CurrentUsername: String = ""
    @State var Password: String = ""
    @State var CurrentPassword: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "xmark").resizable().scaledToFit().frame(width: 40, height: 40).foregroundColor(Color.black)
                }.padding()
                Spacer()
                Text("Settings").font(.system(size: 40)).fontWeight(.black).padding()
                Spacer()
            }
            Spacer()
            VStack{
                Text("Username").font(.title).fontWeight(.bold)
                TextField("Tap to Enter", text: $Username).frame(width: 250, height: 50).background(Color.gray.opacity(0.2)).cornerRadius(8)
            }
            VStack{
                Text("Password").font(.title).fontWeight(.bold)
                TextField("Tap to Enter", text: $Password).frame(width: 250, height: 50).background(Color.gray.opacity(0.2)).cornerRadius(8)
            }
            Spacer()
            HStack{
                Button(action: {
                    if Username != CurrentUsername{
                        UsernameUpdate()
                        CurrentUsername = Username
                    }
                }){
                    Text("変更する").font(.title).fontWeight(.black).frame(width: 150, height: 60).background(Username != CurrentUsername || Password != CurrentPassword ? Color.green : Color.gray).foregroundColor(Color.white).cornerRadius(10)
                }
                Button(action: {
                    
                }){
                    Text("アカウント削除").font(.title).fontWeight(.black).frame(width: 200, height: 60).background(Color.red).foregroundColor(Color.white).cornerRadius(10)
                }
            }.padding()
        }.navigationBarBackButtonHidden(true)
    }
    private func UsernameUpdate(){
        let db = Firestore.firestore()
        
        db.collection("UserList").document(Gmail).setData(["Username": Username], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            }
        }
    }
}
