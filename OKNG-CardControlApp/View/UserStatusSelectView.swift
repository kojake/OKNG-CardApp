//
//  UserStatusSelectView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/08.
//

import SwiftUI
import FirebaseFirestore

struct UserStatusSelectView: View {
    @Binding var Gmail: String
    @Binding var Username: String
    @State var SelectionUserStatus = ""
    
    @State private var Showshould_FirstTalkUserSelectView = false
    
    var body: some View {
        VStack{
            NavigationLink(destination: FirstTalkUserSelectView(Gmail: $Gmail, Username: $Username), isActive: $Showshould_FirstTalkUserSelectView){
                EmptyView()
            }
            
            Text("あなたはどちらの属性ですか？").font(.system(size: 50)).fontWeight(.bold)
            Text("あなたの属性の方をタップしてください").font(.title)
            HStack{
                Button(action: {
                    SelectionUserStatus = "Student"
                    UserStatusDecision()
                }){
                    VStack{
                        Text("生徒").font(.largeTitle).fontWeight(.bold).padding()
                        Image(systemName: "graduationcap").resizable().scaledToFit().frame(width: 100, height: 100)
                        Spacer()
                        Text("生徒は自分の\nカードステータスを\n自由に変更できます。").font(.title2)
                        Spacer()
                    }.frame(width: 300, height: 400).background(Color.blue.opacity(0.8)).foregroundColor(Color.white).cornerRadius(20).shadow(radius: 3)
                }.padding()
                Button(action: {
                    SelectionUserStatus = "Teacher"
                    UserStatusDecision()
                }){
                    VStack{
                        Text("教師").font(.largeTitle).fontWeight(.bold).padding()
                        Image(systemName: "pencil.and.scribble").resizable().scaledToFit().frame(width: 100, height: 100)
                        Spacer()
                        Text("教師は生徒全体の\nカードステータスを見れ、\n生徒の権限を自由に\n変更できます。").font(.title2)
                        Spacer()
                    }.frame(width: 300, height: 400).background(Color.green.opacity(0.8)).foregroundColor(Color.black).cornerRadius(20).shadow(radius: 3)
                }
            }.padding()
        }.navigationBarBackButtonHidden(true)
    }
    private func UserStatusDecision(){
        let db = Firestore.firestore()

        db.collection("UserList").document(Gmail).setData(["UserStatus": SelectionUserStatus], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                Showshould_FirstTalkUserSelectView = true
            }
        }
    }
}
