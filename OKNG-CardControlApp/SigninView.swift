//
//  SigninView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/07.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct SigninView: View {
    //Login
    @State var NewGmail: String = ""
    @State var NewPassword: String = ""
    @State var NewUsername: String = ""
    
    //Erroralert
    @State var Errormessage: String = ""
    @State private var Erroralert = false
    
    //
    @Environment(\.dismiss) var dismiss
    @State private var Showshould_UserStatusSelectView = false
    
    var body: some View {
        VStack{
            NavigationLink(destination: UserStatusSelectView(Gmail: $NewGmail), isActive: $Showshould_UserStatusSelectView){
                EmptyView()
            }
            Text("OKNG-Card").font(.largeTitle).fontWeight(.black).padding()
            VStack{
                Text("Sign in").font(.largeTitle).fontWeight(.black)
                Spacer()
                TextField("Tap To NewUsername", text: $NewUsername).frame(width: 250, height: 60).background(Color.white).foregroundColor(Color.black)
                TextField("Tap To NewGmail", text: $NewGmail).frame(width: 250, height: 60).background(Color.white).foregroundColor(Color.black).keyboardType(.emailAddress)
                TextField("Tap To NewPassword", text: $NewPassword).frame(width: 250, height: 60).background(Color.white).foregroundColor(Color.black)
                Spacer()
                Button(action: {
                    signUp()
                }){
                    Text("Sign in").frame(width: 200, height: 60).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                }.padding()
                Button(action: {
                    dismiss()
                }){
                    Text("Do you have an account?")
                }
            }.frame(width: 300, height: 400).background(Color.gray.opacity(0.5)).cornerRadius(10)
        }
        .navigationBarBackButtonHidden(true)
        //キーボードを閉じる
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("閉じる") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
    }
    private func signUp() {
        Auth.auth().createUser(withEmail: NewGmail, password: NewPassword) { (result, error) in
            if let error = error {
                Errormessage = error.localizedDescription
                Erroralert = true
            } else {
                NewAccountCreate()
                Showshould_UserStatusSelectView = true
            }
        }
    }
    private func NewAccountCreate(){
        let db = Firestore.firestore()
        
        // 新しいコレクションを作成
        let collectionReference = db.collection("UserList")
        
        // ドキュメントを追加
        let data: [String: Any] = [
            "Username": NewUsername,
            "UserStatus": "",
            "CardStatus": false,
            "SeatedSeats": "None"
        ]
        
        collectionReference.document(NewGmail).setData(data) { error in
            if let error = error {
                print("\(error)")
            } else {
                print("document add faile")
            }
        }
    }
}

#Preview {
    SigninView()
}
