//
//  TalkView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/18.
//

import SwiftUI

struct TalkView: View {
    @State var SelectedTalk: String = "a"
    @State var TalkHistory: [String:String] = [:]
    
    @State var SendMessage: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text(SelectedTalk).font(.system(size: 45)).fontWeight(.black).padding()
                Spacer()
            }
            Spacer()
            ZStack{
                HStack{
                    TextField("Aa", text: $SendMessage).font(.title3).fontWeight(.bold).frame(maxWidth: .infinity, maxHeight: 60).background(Color.gray).cornerRadius(8)
                }.padding()
                HStack{
                    Spacer()
                    Button(action: {
                        
                    }){
                        Image(systemName: "arrowshape.up.fill").frame(width: 70, height: 70).background(Color.blue).foregroundColor(Color.white).cornerRadius(50)
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    TalkView()
}
