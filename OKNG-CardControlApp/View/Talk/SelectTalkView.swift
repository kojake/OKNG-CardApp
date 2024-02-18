//
//  MessageView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/18.
//

import SwiftUI

struct SelectTalkView: View {
    @State var TalkPartnerList: [String] = ["a","b","c"]
    
    var body: some View {
        VStack{
            List{
                ForEach(0..<TalkPartnerList.count, id: \.self) { index in
                    NavigationLink(destination: TalkView(),
                        label: {
                            Text(TalkPartnerList[index])
                        }
                    )
                }
            }
        }
        .navigationBarTitle("TalkList")
    }
}

#Preview {
    SelectTalkView()
}
