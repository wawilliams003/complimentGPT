//
//  Compliment.swift
//  complimentGPT
//
//  Created by Wayne Williams on 9/21/25.
//


enum ComplimentType: String {
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

class Compliment {
    let text: String
    let Date: Date
    let image: String?
    var type: ComplimentType // = .description
    
    init(text: String, Date: Date, image: String? = nil, type: ComplimentType) {
        self.text = text
        self.Date = Date
        self.image = image
        self.type = type
    }
}


