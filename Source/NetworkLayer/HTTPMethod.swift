//
// Created by Кирилл Михайлин on 18.11.2021.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"

    var value: String { return self.rawValue }
}
