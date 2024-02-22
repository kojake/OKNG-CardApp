//
//  MessageView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/18.
//

import SwiftUI
import FirebaseFirestore

struct SelectTalkView: View {
    @State var TalkUserList: [String] = []
    
    var body: some View {
        ZStack{
            List{
                ForEach(0..<TalkUserList.count, id: \.self) { index in
                    NavigationLink(destination: TalkView(SelectedTalk: $TalkUserList[index]),
                        label: {
                            Text(TalkUserList[index])
                        }
                    )
                }
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        TalkUserListGet()
                    }){
                        VStack{
                            Image(systemName: "arrow.circlepath").resizable().scaledToFit().frame(width: 40, height: 40).foregroundColor(Color.white)
                        }.frame(width: 70, height: 70).background(Color.brown).cornerRadius(8).shadow(radius: 10)
                    }.padding()
                }
            }
        }
        .navigationBarTitle("TalkList")
        .onAppear{
            TalkUserListGet()
        }
    }
    func TalkUserListGet(){
        let db = Firestore.firestore()
        
        db.collection("TalkUserList").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                TalkUserList = documents.map { $0.documentID }
            }
        }
    }
}

#Preview {
    SelectTalkView()
}
