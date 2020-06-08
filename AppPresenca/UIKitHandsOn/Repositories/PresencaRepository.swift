//
//  PresencaRepository.swift
//  UIKitHandsOn
//
//  Created by Gabriela Bezerra on 14/01/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

class PresencaRepository {

    func listar(completion: @escaping ([Presenca]) -> Void) {
        
        HTTP.get.request(url: PresencaAPI.listar.url) { data, response, errorMessage in
            
            if let errorMessage = errorMessage {
                print(errorMessage)
                completion([])
                return
            }
            
            guard let data = data, let response = response else {
                completion([])
                return
            }
            
            switch response.statusCode {
            case 200:
                let presencas: [Presenca] = (try? JSONDecoder().decode(Array<Presenca>.self, from: data)) ?? []
                completion(presencas)
                return
            default:
                completion([])
                return
            }
            
        }
        
    }
    
    func assinar(nome: String, completion: @escaping (String?) -> Void = { message in }) {
        
        HTTP.post.request(url: PresencaAPI.assinar.url, body: ["nome": nome]) { data, response, errorMessage in
            
            if let errorMessage = errorMessage {
                print(errorMessage)
                completion(errorMessage)
                return
            }
                       
            guard let data = data, let response = response else {
                completion("No Data or Response")
                return
            }
                       
            switch response.statusCode {
            case 200:
                completion("Frequencia Assinada com Sucesso!")
                return
            default:
                let error: String? = (try? JSONDecoder().decode(AssinarResponse.self, from: data))?.reason
                completion(error)
            }
                       
        }
        
    }
}
