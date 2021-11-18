//
// Created by Кирилл Михайлин on 18.11.2021.
//

import Foundation

class Request: APIRequest {

    var path: String
    var method: HTTPMethod
    var query: [URLQueryItem]?
    var headers: [String : String]?
    var body: Data?

    init(path: String, method: HTTPMethod = .get, body: Data? = nil, headers: [String : String] = [:], query: [URLQueryItem] = []) {
        self.path = path
        self.method = method
        self.body = body
        self.headers = headers
        self.query = query
    }
}
