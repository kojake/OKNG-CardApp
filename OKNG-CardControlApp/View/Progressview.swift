//
//  ProgressView.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/21.
//

import SwiftUI

struct Progressview: View {
    var body: some View {
        VStack{
            ProgressView()
                .progressViewStyle(.circular)
                .padding()
                .tint(Color.white)
                .background(Color.gray)
                .cornerRadius(8)
                .scaleEffect(1.2)
        }
    }
}

#Preview {
    Progressview()
}
