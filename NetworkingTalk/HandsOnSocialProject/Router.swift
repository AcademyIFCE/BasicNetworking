//
//  Router.swift
//  Medium
//
//  Created by Gabriela Bezerra on 07/06/20.
//

import Foundation

enum Router {
    
    case getAllProjects(countryCode: String? = nil)
    case searchProject(countryCode: String? = nil, theme: String? = nil, query: [String])
    
    var scheme: String {
            return "https"
    }
    
    var host: String {
            return "api.globalgiving.org"
    }
    
    var path: String {
        switch self {
        case .getAllProjects(let countryCode):
            if let countryCode = countryCode {
                return "/api/public/projectservice/countries/\(countryCode)/projects"
            } else {
                return "/api/public/projectservice/all/projects"
            }
            
        case .searchProject:
            return "/api/public/services/search/projects"
            
        }
    }
    
    var params: [URLQueryItem] {
        
        //Essa maneira de armazenar API Key não é segura, mas pode ser utilizada em ambiente de desenvolvimento. Em projetos onde a segurança é prioridade, essa chave não deve estar explícita.
        //Se você quiser estudar um pouco mais sobre: https://nshipster.com/secrets/
        let apiKey = "f0859eb6-e16d-470c-93b4-5d7d10fce06b"
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        switch self {
        case .searchProject(let countryCode, let theme, let query):
            
            //Concatenando o valor da query com +
            let concatenatedKeywords = query.joined(separator: "+")
            
            //Concatenando as chave:valor do parametro filter
            var concatenatedFilter = ""
            if let countryCode = countryCode { concatenatedFilter += "country:\(countryCode)," }
            if let theme = theme { concatenatedFilter += "theme:\(theme)" }
            
            queryItems.append(contentsOf: [
                URLQueryItem(name: "q", value: concatenatedKeywords),
                URLQueryItem(name: "filter", value: concatenatedFilter)
            ])
            
            break
            
        default:
            break
        }
        
        return queryItems
    }
    
    var header: [String : String] {
        switch self {
        default:
            return [
                "Accept":"application/json",
                "Content-Type":"application/json"
            ]
        }
    }
    
    var body: Data? {
        switch self {
        default:
            return nil
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        if !self.params.isEmpty {
            components.queryItems = self.params
        }
        
        return components.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method
        request.allHTTPHeaderFields = self.header
        
        return request
    }
    
}

/*
 Guiding Resources
 https://www.globalgiving.org/api/methods/
 https://medium.com/@rinradaswift/networking-layer-in-swift-5-111b02db1639
*/
