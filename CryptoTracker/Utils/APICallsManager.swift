//
//  APICallsManager.swift
//  CryptoTracker
//
//  Created by Salvatore Attanasio on 18/12/23.
//

import Foundation

class APICallsManager{
    enum APIError: Error {
        case badRequest(String)         // 400
        case unauthorised       // 401
        case forbidden          // 403
        case notFound           // 404
        case tooManyRequests    // 429
        case serviceUnavailable // 503
        case APIKeyMissing      // 10002
        case generic(String)
    }
    
    static let shared = APICallsManager()
    
    //Initializer access level change now
    private init(){}
    
    var currency: Currency = .dollars
    let decoder = JSONDecoder()
    
    private var components = URLComponents(string: "https://api.coingecko.com")
    
    func updateMarketData(vs_currency: String) async throws -> (Data, URLResponse) {
        guard var components = self.components else{
            throw URLError(.badURL)
        }
        
        components.path       = "/api/v3/coins/markets"
        components.queryItems = [
            URLQueryItem(name: "vs_currency", value: vs_currency),
            URLQueryItem(name: "order",     value: "market_cap_desc"),
            URLQueryItem(name: "per_page",  value: "100"),
            URLQueryItem(name: "page",      value: "1"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "x_cg_demo_api_key", value: Bundle.main.infoDictionary?["API_KEY"] as? String),
        ]
        
        guard let url = components.url else{
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try handleHTTPResponses(response as! HTTPURLResponse, data: data)
        
        return (data, response)
    }
    
    private func handleHTTPResponses (_ httpResponse: HTTPURLResponse, data: Data) throws {
        switch httpResponse.statusCode {
        case 200:   // OK
            return
        case 429:
            throw APIError.tooManyRequests
        case 401:
            throw APIError.unauthorised
        case 403:
            throw APIError.forbidden
        case 404:
            throw APIError.notFound
        default:
            throw APIError.generic( String(httpResponse.statusCode) )
        }
    }
}
