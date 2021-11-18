//
// Created by Кирилл Михайлин on 18.11.2021.
//

import Foundation

protocol APIRequest {

    var path: String { get }
    var method: HTTPMethod { get }
    var query: [URLQueryItem]? { get }
    var headers: [String: String]? { get set }
    var body: Data? { get set }
}
