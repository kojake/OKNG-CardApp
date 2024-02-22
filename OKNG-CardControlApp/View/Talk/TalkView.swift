//
//  TalkView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/18.
//

import SwiftUI
import FirebaseFirestore

struct TalkView: View {
    @Binding var SelectedTalk: String
    @State var SendMessage: String = ""
    
    @State private var TalkHistory: [TalkModel] = [
        TalkModel(name: "You", message: "a"),
        TalkModel(name: "You", message: "b"),
        TalkModel(name: "Your", message: "c")
    ]
    @State var TapMessage = ""
    @State var TapMessageIndex = 0
    
    @State private var Showshould_TapMessageEditView = false
    
    var body: some View {
        VStack{
            HStack{
                Text(SelectedTalk).font(.system(size: 45)).fontWeight(.black).padding()
                Spacer()
            }
            Spacer()
            ScrollView{
                ForEach(TalkHistory.indices, id: \.self) { index in
                    let talkmodel = TalkHistory[index]
                    HStack{
                        if talkmodel.name == "You"{
                            Spacer()
                        }
                        VStack(alignment: .leading){
                            VStack{
                                HStack{
                                    if talkmodel.name == "You"{
                                        Spacer()
                                    }
                                    Text(talkmodel.name).font(.title2).fontWeight(.bold)
                                    if talkmodel.name != "You"{
                                        Spacer()
                                    }
                                }
                                HStack{
                                    if talkmodel.name == "You"{
                                        Spacer()
                                    }
                                    Text(talkmodel.message).font(.title3).fontWeight(.bold)
                                    if talkmodel.name != "You"{
                                        Spacer()
                                    }
                                }
                            }.padding()
                        }.frame(width: 400, height: 60).background(talkmodel.name == "You" ? Color.green : Color.red).foregroundColor(Color.white).cornerRadius(6).padding()
                            .onLongPressGesture(perform: {
                                if talkmodel.name == "You"{
                                    TapMessage = talkmodel.message
                                    TapMessageIndex = index
                                    Showshould_TapMessageEditView = true
                                }
                            })
                        if talkmodel.name != "You"{
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
            ZStack{
                HStack{
                    TextField("Aa", text: $SendMessage).font(.title3).fontWeight(.bold).frame(maxWidth: .infinity, maxHeight: 60).background(Color.gray).cornerRadius(8)
                }.padding()
                HStack{
                    Spacer()
                    Button(action: {
                        TalkHistory.append(TalkModel(name: "You", message: SendMessage))
                        SendMessage = ""
                    }){
                        if !SendMessage.isEmpty{
                            Image(systemName: "arrowshape.up.fill").frame(width: 70, height: 70).background(Color.blue).foregroundColor(Color.white).cornerRadius(50)
                        }
                    }.padding()
                }
            }
        }
        .sheet(isPresented: $Showshould_TapMessageEditView){
            TapMessageEditView(TapMessage: $TapMessage, TapMessageIndex: $TapMessageIndex, TalkHistory: $TalkHistory)
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("閉じる") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
        .onAppear{
            
        }
    }
}
