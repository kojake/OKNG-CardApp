//
//  CardStatusView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/08.
//

import SwiftUI
import FirebaseFirestore

struct StatusView: View {
    //User
    @State var Username: String = ""
    @Binding var Gmail: String
    @Binding var CardStatus: Bool
    
    @State var Previoustable: Int = 0
    @State var SelectionTableValue: Int = 0
    
    //Table    
    @State private var SelectTableSeatPeopleList: [String] = []
    @State private var SelectTableCardStatusList: [Bool] = []
    

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
                        Text("Table1").tag(1)
                        Text("Table2").tag(2)
                        Text("Table3").tag(3)
                        Text("Table4").tag(4)
                        Text("Table5").tag(5)
                        Text("Table6").tag(6)
                        Text("Table7").tag(7)
                        Text("Table8").tag(8)
                    }.frame(width: 150, height: 70).background(Color.white).cornerRadius(10)
                    Button(action: {
                        MySeatedSeatsUpdate()
                        if let ElementNumber = MySeateddSeatsElementNumber(of: Username, in: SelectTableSeatPeopleList){
                            SelectTableSeatPeopleList.remove(at: ElementNumber)
                            SelectTableCardStatusList.remove(at: ElementNumber)
                        }
                        TableUpdate(TableNumber: Previoustable)
                        SelectTableSeatPeopleList.append(Username)
                        SelectTableCardStatusList.append(false)
                        TableUpdate(TableNumber: SelectionTableValue)
                        Previoustable = SelectionTableValue
                    }){
                        Text("変更する").font(.title2).fontWeight(.bold).frame(width: 130, height: 50).background(Previoustable == SelectionTableValue ? Color.gray : Color.blue).foregroundColor(Color.white).cornerRadius(10)
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
        .onAppear{
            SeatedSeatsGet()
            PeopleSeatedAtSelectTables()
            UsernameGet()
        }
    }
    //UsernameGet
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
    //CardStatus
    private func CardStatusChange(){
        let db = Firestore.firestore()
        let MyElementNumber = MySeateddSeatsElementNumber(of: Username, in: SelectTableSeatPeopleList)

        db.collection("UserList").document(Gmail).setData(["CardStatus": CardStatus], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            }
        }
        
        SelectTableCardStatusList[MyElementNumber!] = CardStatus
        db.collection("TableList").document("Table\(SelectionTableValue)").setData(["CardStatus": SelectTableCardStatusList], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            }
        }
    }
    //User Seated Get
    private func SeatedSeatsGet(){
        let db = Firestore.firestore()
        
        db.collection("UserList").document(Gmail).getDocument { (document, error) in
            if let document = document, document.exists {
                if let seatedseats = document.data()?["SeatedSeats"] as? String {
                    if seatedseats == "Table1"{
                        SelectionTableValue = 1
                        Previoustable = 1
                    } else if seatedseats == "Table2"{
                        SelectionTableValue = 2
                        Previoustable = 2
                    } else if seatedseats == "Table3"{
                        SelectionTableValue = 3
                        Previoustable = 3
                    } else if seatedseats == "Table4"{
                        SelectionTableValue = 4
                        Previoustable = 4
                    } else if seatedseats == "Table5"{
                        SelectionTableValue = 5
                        Previoustable = 5
                    } else if seatedseats == "Table6"{
                        SelectionTableValue = 6
                        Previoustable = 6
                    } else if seatedseats == "Table7"{
                        SelectionTableValue = 7
                        Previoustable = 7
                    } else if seatedseats == "Table8"{
                        SelectionTableValue = 8
                        Previoustable = 8
                    } else {
                        SelectionTableValue = 0
                        Previoustable = 0
                    }
                }
            }
        }
    }
    //
    private func PeopleSeatedAtSelectTables(){
        let db = Firestore.firestore()
        
        db.collection("UserList").document(Gmail).getDocument { (document, error) in
            if let document = document, document.exists {
                if let seatedseats = document.data()?["SeatedSeats"] as? String {
                    if seatedseats != "None"{
                        db.collection("TableList").document(seatedseats).getDocument { (document, error) in
                            if let document = document, document.exists {
                                if let people = document.data()?["People"] as? [String] {
                                    SelectTableSeatPeopleList = people
                                }
                            }
                        }
                        db.collection("TableList").document(seatedseats).getDocument { (document, error) in
                            if let document = document, document.exists {
                                if let status = document.data()?["CardStatus"] as? [Bool] {
                                    SelectTableCardStatusList = status
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    private func MySeateddSeatsElementNumber(of element: String, in array: [String]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == element {
                return index
            }
        }
        return nil
    }
    //MySeatedSeats Update Deleted
    private func MySeatedSeatsUpdate(){
        var seatedseats = ""
        if SelectionTableValue == 0{
            seatedseats = "None"
        } else {
            seatedseats = "Table\(SelectionTableValue)"
        }
        
        let db = Firestore.firestore()
        
        db.collection("UserList").document(Gmail).setData(["SeatedSeats": seatedseats], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            }
        }
    }
    private func TableUpdate(TableNumber: Int){
        let db = Firestore.firestore()
        
        db.collection("TableList").document("Table\(TableNumber)").setData([
            "People": SelectTableSeatPeopleList,
            "CardStatus": SelectTableCardStatusList
                                                                                   ], merge: true) { error in
            if let error = error {
                print("Error updating document: \(error)")
            }
        }
    }
}
