//
//  TapMessageEditView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/21.
//

import SwiftUI

struct TapMessageEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var TapMessage: String
    @Binding var TapMessageIndex: Int
    @Binding var TalkHistory: [TalkModel]
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "xmark").resizable().scaledToFit().frame(width: 30, height: 30).foregroundColor(Color.black)
                }.padding()
                Spacer()
                Text(TapMessage).font(.largeTitle).fontWeight(.black).padding()
            }
            Spacer()
            Button(action:{
                TalkHistory.remove(at: TapMessageIndex)
                dismiss()
            }){
                HStack{
                    Text("送信取り消し").font(.title2).fontWeight(.bold).foregroundColor(Color.white)
                    Image(systemName: "trash").resizable().scaledToFit().frame(width: 50, height: 50).foregroundColor(Color.white)
                }.frame(width: 230, height: 70).background(Color.red).cornerRadius(8).shadow(radius: 10)
            }
            Spacer()
        }
    }
}
