//
//  SelectionTableDetailView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/07.
//

import SwiftUI

struct SelectionTableDetailView: View {
    @Binding var SelectionTable: Int
    
    var body: some View {
        VStack{
            HStack{
                Text("Table \(SelectionTable + 1)").font(.largeTitle).fontWeight(.black).padding()
                Spacer()
            }
            Spacer()
            HStack{
                ForEach(0..<6) {index in
                    VStack{
                        Image(systemName: "person.fill").resizable().scaledToFit().frame(width: 70, height: 70).foregroundColor(.white).padding()
                        Text("Name").font(.title2).fontWeight(.black)
                        Spacer()
                        Text("OK").font(.largeTitle).fontWeight(.black).frame(width: 150, height: 100).background(Color.green).cornerRadius(10)
                        Spacer()
                    }.frame(width: 180, height: 300).background(Color.mint).cornerRadius(10)
                }
            }
            Spacer()
            Button(action: {
                
            }){
                Image(systemName: "xmark").frame(width: 80, height: 80).background(Color.black).foregroundColor(Color.white).cornerRadius(50)
            }.padding()
        }
    }
}
