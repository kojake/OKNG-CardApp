//
//  CardStatusView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/08.
//

import SwiftUI
import FirebaseFirestore

struct StatusView: View {
    @Binding var Gmail: String
    @Binding var CardStatus: Bool
    @State var SelectionTableValue: Int = 0

    var body: some View {
        VStack{
            HStack{
                Text("Change Status").font(.largeTitle).fontWeight(.black).padding()
                Spacer()
                Image(systemName: "graduationcap.fill").resizable().scaledToFit().frame(width: 100, height: 100).foregroundColor(.blue).padding()
            }
            Spacer()
            HStack{
                VStack{
                    Text("現在座っているテーブル").font(.title2).fontWeight(.black).foregroundColor(Color.white).padding()
                    Spacer()
                    Picker("", selection: $SelectionTableValue) {
                        Text("座らない").tag(0)
                        Text("テーブル1").tag(1)
                        Text("テーブル2").tag(2)
                        Text("テーブル3").tag(3)
                        Text("テーブル4").tag(4)
                        Text("テーブル5").tag(5)
                        Text("テーブル6").tag(6)
                        Text("テーブル7").tag(7)
                        Text("テーブル8").tag(8)
                    }.frame(width: 150, height: 70).background(Color.white).cornerRadius(10)
                    Button(action: {
                        
                    }){
                        Text("変更する").font(.title2).fontWeight(.bold).frame(width: 130, height: 50).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
                    }
                    Spacer()
                }.frame(width: 280, height: 300).background(Color.brown).cornerRadius(10)
                VStack{
                    Text("タップしてカードの\nステータスを変更").fontWeight(.bold)
                    Button(action: {
                        if CardStatus{
                            CardStatus = false
                            CardStatusChange()
                        } else {
                            CardStatus = true
                            CardStatusChange()
                        }
                    }){
                        VStack{
                            if CardStatus{
                                Text("OK").font(.largeTitle).fontWeight(.black)
                            } else {
                                Text("NG").font(.largeTitle).fontWeight(.black)
                            }
                        }.frame(width: 200, height: 100).background(CardStatus ? Color.green : Color.red).foregroundColor(Color.white).cornerRadius(10)
                    }
                }
            }
            Spacer()
        }.navigationBarBackButtonHidden(true)
    }
    private func CardStatusChange(){
        let db = Firestore.firestore()

        db.collection("UserList").document(Gmail).setData(["CardStatus": CardStatus], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            }
        }
    }
}
