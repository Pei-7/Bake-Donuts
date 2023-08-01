//
//  Result.swift
//  Bake Donuts
//
//  Created by 陳佩琪 on 2023/7/31.
//

import Foundation

enum Result {
    case allCorrect, twoCorrect, oneCorrect, noneCorrect
    
    var string: String {
        switch self {
        case .allCorrect:
            return "Yipee, this meets all my expectations!"
        case .twoCorrect:
            return "OK, though taste is not quite as I imagined..."
        case .oneCorrect:
            return "Oh, it's not exactly what I had in mind..."
        case .noneCorrect:
            return "Nope, it's not at all what I ordered."
        }
    }
    
    var imageName: String {
        switch self {
        case .allCorrect:
            return "happy"
        case .twoCorrect:
            return "soso"
        case .oneCorrect:
            return "sad"
        case .noneCorrect:
            return "cry"
        }
    }
}
