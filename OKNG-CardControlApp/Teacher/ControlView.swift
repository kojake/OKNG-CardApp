//
//  ControlView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/08.
//

import SwiftUI

struct ControlView: View {
    @State var Selectiontable: Int = 0
    @State private var Showshould_SelectionTableDetailView = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: SelectionTableDetailView(SelectionTable: $Selectiontable), isActive: $Showshould_SelectionTableDetailView){
                EmptyView()
            }
            HStack{
                Text("Control Center").font(.system(size: 50)).fontWeight(.black).padding()
                Spacer()
                Image(systemName: "pencil.and.scribble").resizable().scaledToFit().frame(width: 80, height: 80).padding()
            }
            Spacer()
            HStack{
                ForEach(0..<4) {index in
                    Button(action: {
                        Selectiontable = index + 1
                        Showshould_SelectionTableDetailView = true
                    }){
                        VStack{
                            Text("\(index + 1)").font(.title).fontWeight(.black).foregroundColor(Color.white)
                            Image("Table").resizable().scaledToFit().frame(width: 150, height: 150)
                        }.frame(width: 180, height: 200).background(Color.brown).cornerRadius(10)
                    }
                }
            }
            HStack{
                ForEach(4..<8) {index in
                    Button(action: {
                        Selectiontable = index
                        Showshould_SelectionTableDetailView = true
                    }){
                        VStack{
                            Text("\(index + 1)").font(.title).fontWeight(.black).foregroundColor(Color.white)
                            Image("Table").resizable().scaledToFit().frame(width: 150, height: 150)
                        }.frame(width: 180, height: 200).background(Color.brown).cornerRadius(10)
                    }
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ControlView()
}
