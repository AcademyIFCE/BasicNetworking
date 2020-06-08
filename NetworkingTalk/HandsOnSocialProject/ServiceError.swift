//
//  NetworkError.swift
//  Medium
//
//  Created by Gabriela Bezerra on 07/06/20.
//

import Foundation

enum ServiceError: Error {
    case requestFailed(description: String)
    case malformedURLRequest(url: String)
    case notFound
    case badRequest
    case unknownError(statusCode: Int)
    
    var localizedDescription: String {
        switch self {
        case .requestFailed(let description):
            return "Could not run request because: \(description)."
        case .malformedURLRequest(let url):
            return "Could not build URLRequest with \(url)"
        case .notFound:
            return "The Request returned status code 404, the route was not found."
        case .badRequest:
            return "The Request returned status code 400, Bad Request."
        case .unknownError(let statusCode):
            return "The Request returned status code \(statusCode), unknown meaning."
        }
    }
}
