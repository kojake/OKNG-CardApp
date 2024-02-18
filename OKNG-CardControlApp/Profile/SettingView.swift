//
//  SettingView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/16.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var Gmail: String
    @Binding var Username: String
    @State var CurrentUsername: String = ""
    
    @State private var Passwordalert = false
    @State var alertmessage = ""
    
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
                Text("-Username").font(.title).fontWeight(.bold)
                TextField("Tap to Enter", text: $Username).frame(width: 250, height: 50).background(Color.gray.opacity(0.2)).cornerRadius(8)
            }.padding()
            VStack{
                Text("-Password").font(.title).fontWeight(.bold)
                Button(action: {
                    PasswordReset()
                }){
                    Text("パスワードリセット").font(.title3).fontWeight(.bold).frame(width: 230, height: 60).background(Color.blue).foregroundColor(Color.white).cornerRadius(8)
                }
            }
            Spacer()
            HStack{
                Button(action: {
                    if Username != CurrentUsername{
                        UsernameUpdate()
                        CurrentUsername = Username
                    }
                }){
                    Text("変更する").font(.title).fontWeight(.black).frame(width: 150, height: 60).background(Username != CurrentUsername ? Color.green : Color.gray).foregroundColor(Color.white).cornerRadius(10)
                }.disabled(Username != CurrentUsername)
                Button(action: {
                    
                }){
                    Text("アカウント削除").font(.title).fontWeight(.black).frame(width: 200, height: 60).background(Color.red).foregroundColor(Color.white).cornerRadius(10)
                }
            }.padding()
        }
        //ErrorAlert
        .alert(isPresented: $Passwordalert) {
            Alert(title: Text(alertmessage))
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            CurrentUsername = Username
        }
    }
    private func UsernameUpdate(){
        let db = Firestore.firestore()
        
        db.collection("UserList").document(Gmail).setData(["Username": Username], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            }
        }
    }
    private func PasswordReset(){
        Auth.auth().sendPasswordReset(withEmail: Gmail) { error in
            if let error = error {
                alertmessage = error.localizedDescription
                Passwordalert = true
            } else {
                alertmessage = "パスワードリセットリンクをメールに送信しました\nリンクからパスワードをリセットしてください。"
                Passwordalert = true
            }
        }
    }
}
