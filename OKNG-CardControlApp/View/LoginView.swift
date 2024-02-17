//
//  LoginView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/07.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    //Login
    @State var Gmail: String = ""
    @State var Password: String = ""
    
    //Erroralert
    @State var Errormessage: String = ""
    @State private var Erroralert = false
    
    //
    @State private var Showshould_SigninView = false
    @State private var Showshould_ContentView = false
    
    var body: some View {
        NavigationStack{
            NavigationLink(destination: ContentView(Gmail: $Gmail), isActive: $Showshould_ContentView){
                EmptyView()
            }
            NavigationLink(destination: SigninView(), isActive: $Showshould_SigninView){
                EmptyView()
            }
            VStack{
                Text("OKNG-Card").font(.largeTitle).fontWeight(.black).padding()
                VStack{
                    Text("Login").font(.largeTitle).fontWeight(.black)
                    Spacer()
                    TextField("Tap To Gmail", text: $Gmail).frame(width: 250, height: 60).background(Color.white).foregroundColor(Color.black).keyboardType(.emailAddress)
                    SecureField("Tap To Password", text: $Password).frame(width: 250, height: 60).background(Color.white).foregroundColor(Color.black)
                    Spacer()
                    Button(action: {
                        login()
                    }){
                        Text("Login").frame(width: 200, height: 60).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                    }.padding()
                    Button(action: {
                        Showshould_SigninView = true
                    }){
                        Text("Don't have an account?")
                    }
                }.frame(width: 300, height: 400).background(Color.gray.opacity(0.5)).cornerRadius(10)
            }
        }
        //キーボードを閉じる
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("閉じる") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
        //ErrorAlert
        .alert(isPresented: $Erroralert) {
            Alert(title: Text(Errormessage))
        }
    }
    
    private func login() {
        // Firebaseログインの処理
        Auth.auth().signIn(withEmail: Gmail, password: Password) { result, error in
            if let error = error {
                // エラーがある場合、エラーメッセージをセットしてアラートを表示
                Errormessage = error.localizedDescription
                Erroralert = true
            } else {
                Showshould_ContentView = true
            }
        }
    }
}

#Preview {
    LoginView()
}
