//
//  Compliment.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/21/25.
//



enum ComplimentType: String, Codable {
    case description
    case photo
    
    var iconName: String {
        switch self {
        case .description: return "text.bubble"
        case .photo: return "photo"
        }
    }
}

import Foundation
import UIKit

class Compliment: Codable {
    //let uid: String = UUID().uuidString
    let text: String
    let date: Date
    let image: Data?
    var type: ComplimentType // = .description
    
    init(text: String, date: Date, image: Data? = nil, type: ComplimentType) {
        self.text = text
        self.date = date
        self.image = image
        self.type = type
    }
    
    
}


