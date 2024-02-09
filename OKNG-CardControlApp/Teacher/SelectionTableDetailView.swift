//
//  SelectionTableDetailView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/07.
//

import SwiftUI
import FirebaseFirestore

struct SelectionTableDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var SelectionTable: Int
    
    //Table
    @State private var SelectTableSeatPeopleList: [String] = []
    @State private var SelectTableCardStatusList: [Bool] = []
    
    var body: some View {
        VStack{
            HStack{
                Text("Table \(SelectionTable)").font(.largeTitle).fontWeight(.black).padding()
                Spacer()
            }
            Spacer()
            HStack{
                if SelectTableSeatPeopleList.isEmpty && $SelectTableCardStatusList.isEmpty{
                    VStack{
                        Image(systemName: "exclamationmark.triangle.fill").resizable().scaledToFit().frame(width: 100, height: 100).foregroundColor(Color.yellow)
                        Text("現在このテーブルに座っている人はいません。").font(.title).fontWeight(.bold)
                    }
                } else {
                    ForEach(0..<SelectTableSeatPeopleList.count, id: \.self) { index in
                        VStack{
                            Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 70, height: 70).foregroundColor(.white).padding()
                            Text(SelectTableSeatPeopleList[index]).font(.title2).fontWeight(.black)
                            Spacer()
                            if SelectTableCardStatusList[index]{
                                Text("OK").font(.largeTitle).fontWeight(.black).frame(width: 150, height: 100).background(Color.green).cornerRadius(10)
                            } else {
                                Text("NG").font(.largeTitle).fontWeight(.black).frame(width: 150, height: 100).background(Color.red).cornerRadius(10)
                            }
                            Spacer()
                        }.frame(width: 180, height: 300).background(Color.mint).cornerRadius(10)
                    }
                }
            }
            Spacer()
            Button(action: {
                dismiss()
            }){
                Image(systemName: "xmark").frame(width: 80, height: 80).background(Color.black).foregroundColor(Color.white).cornerRadius(50)
            }.padding()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            PeopleSeatedAtSelectTables()
        }
    }
    private func PeopleSeatedAtSelectTables(){
        let db = Firestore.firestore()
        
        db.collection("TableList").document("Table\(SelectionTable)").getDocument { (document, error) in
            if let document = document, document.exists {
                if let people = document.data()?["People"] as? [String] {
                    SelectTableSeatPeopleList = people
                }
            }
        }
        db.collection("TableList").document("Table\(SelectionTable)").getDocument { (document, error) in
            if let document = document, document.exists {
                if let status = document.data()?["CardStatus"] as? [Bool] {
                    SelectTableCardStatusList = status
                }
            }
        }
    }
}
