//
// Created by Кирилл Михайлин on 18.11.2021.
//

import Foundation

class APIClient {

    public init(host: String, scheme: String = "https", apiKey: [String : String] = [:]) {
        self.urlComponents.host = host
        self.urlComponents.scheme = scheme
        self.apiKey = apiKey
    }

    public func send(request: APIRequest, completion: @escaping (Data?, Error?) -> Void) {
        guard let endpointURL = createEndpointURL(from: request) else { return }

        let urlRequest = createUrlRequest(from: endpointURL, method: request.method.value, body: request.body)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) {data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            completion(data, nil)
        }

        task.resume()
    }

    private var urlComponents = URLComponents()
    
    private var apiKey: [String : String] = [:]

    private func createEndpointURL(from request: APIRequest) -> URL? {
        var currentUrlComponents = URLComponents()
        let queryItems = createQueryParams(request.query ?? [])

        currentUrlComponents.host = self.urlComponents.host
        currentUrlComponents.scheme = self.urlComponents.scheme
        currentUrlComponents.path = request.path
        currentUrlComponents.queryItems = queryItems.count > 0 ? queryItems : nil

        return currentUrlComponents.url
    }

    private func createUrlRequest(from endpointURL: URL, method: String, body: Data?) -> URLRequest {
        var urlRequest = URLRequest(url: endpointURL)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body

        return urlRequest
    }
    
    private func createQueryParams(_ params: [URLQueryItem] = []) -> [URLQueryItem] {
        guard let name = apiKey.keys.first,
              let key = apiKey.values.first else {
            return params
        }

        let apiKeyQuery = URLQueryItem(name: name, value: key)

        var queryArray = params
        queryArray.append(apiKeyQuery)

        return queryArray
    }
}
