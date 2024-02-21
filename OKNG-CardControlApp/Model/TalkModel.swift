//
//  TalkModel.swift
//  OKNG-CardControlApp
//
//  Created by kaito on 2024/02/19.
//

import Foundation
import FirebaseFirestoreSwift

struct TalkModel: Codable{
    var id = UUID()
    var name: String
    var message: String
}

