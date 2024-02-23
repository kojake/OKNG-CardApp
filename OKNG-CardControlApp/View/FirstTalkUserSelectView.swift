//
//  FirstTalkUserSelectView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/23.
//

import SwiftUI
import FirebaseFirestore

struct FirstTalkUserSelectView: View {
    @State var UserList: [String] = []
    @Binding var Gmail: String
    @Binding var Username: String
    
    @State private var Showshould_ContentView = false
    
    var body: some View {
        VStack{
            NavigationLink(destination: ContentView(Gmail: $Gmail), isActive: $Showshould_ContentView){
                EmptyView()
            }
            Text("トークしたい人を1人選択してください").font(.system(size: 40)).fontWeight(.bold)
            Text("※FirebaseDatabaseフィールド登録の為最初の1人を選択してください。\n登録した後もトークしたい人を選べます。")
            Spacer()
            ZStack{
                Image(systemName: "message").resizable().scaledToFit().frame(width: 100, height: 100)
                ScrollView{
                    ForEach(0..<UserList.count, id: \.self) { index in
                        HStack{
                            HStack{
                                Image(systemName: "person").resizable().scaledToFit().frame(width: 35, height: 35)
                                Text(UserList[index]).font(.title).fontWeight(.bold)
                            }.padding()
                            Spacer()
                            Button(action: {
                                NewTalkUserCreate()
                            }){
                                Text("登録").font(.title2).fontWeight(.black).frame(width: 100, height: 50).background(Color.black).foregroundColor(Color.white).cornerRadius(10)
                            }.padding()
                        }.frame(width: 480, height: 60).background(Color.white).cornerRadius(8).padding()
                    }
                }.frame(width: 500, height: 550).background(Color.blue.opacity(0.5)).cornerRadius(20)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            UserListGet()
        }
    }
    private func UserListGet(){
        let db = Firestore.firestore()
        
        db.collection("UserList").getDocuments { snapshot, error in
             if let error = error {
                 print("Error getting documents: \(error)")
             } else {
                 var values: [String] = []

                 for document in snapshot!.documents {
                     if let value = document.data()["Username"] as? String {
                         values.append(value)
                     }
                 }

                 DispatchQueue.main.async {
                     UserList = values
                 }
             }
         }
    }
    
    private func NewTalkUserCreate(){
        let db = Firestore.firestore()

        let collectionReference = db.collection("TalkUserList")

        let data: [String: Any] = [
            Username: [TalkModel]()
        ]
        
        collectionReference.document(Username).setData(data) { error in
            if let error = error {
                print("\(error)")
            } else {
                Showshould_ContentView = true
            }
        }
    }
}
