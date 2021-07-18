//
//  NetworkLayer.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 25.05.2021.
//

import Foundation

let youtube_Key = "AIzaSyB1YaDWZl-IeTfo0aaeyEB-tpd8Kkc-kAs"

var valueSelected = "sidhAsana"

class NetworkLayer {
    static let shared = NetworkLayer()
    private init() {}
        
    func sendRequest<G: Decodable, T: PRequest>(_ request: T, clas: G.Type) {
        guard let url = URL(string: request.url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.type.rawValue
        URLSession.shared.dataTask(with: urlRequest) { (data, respose, error) in
            if let error = error { request.onError?(error.localizedDescription); return }
            do {
                let jsonResults: G = try JSONDecoder().decode(G.self, from: data ?? Data())
                request.onSuccess?(jsonResults as! T.responseType)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}


class YouTubeRequest: PRequest{
    
    typealias responseType = YouTubeVideo
    
    var url: String
    var type: HTTPType = .GET
    var onError: ((String) -> Void)?
    var onSuccess: ((responseType) -> Void)?
    init(url: String, onError: ((String) -> Void)?, onSuccess: ((responseType) -> Void)?) {
        self.url = url
        self.onError = onError
        self.onSuccess = onSuccess
    }

}

class ImageRequest: PRequest {
    
    typealias responseType = YogaAsana
    
    var url: String
    var type: HTTPType = .GET
    var onError: ((String) -> Void)?
    var onSuccess: ((responseType) -> Void)?
    init(url: String, onError: ((String) -> Void)?, onSuccess: ((responseType) -> Void)?) {
        self.onError = onError
        self.onSuccess = onSuccess
        self.url = url
    }

}

protocol PRequest {
    associatedtype responseType
    var url: String { set get }
    var type: HTTPType { get set }
    var onError: ((String) -> Void)? { get set }
    var onSuccess: ((responseType) -> Void)? { get set }
}

enum HTTPType: String {
    case GET
    case POST
}
