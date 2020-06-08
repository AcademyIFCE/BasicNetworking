//
//  main.swift
//  Medium
//
//  Created by Gabriela Bezerra on 07/06/20.
//

import Foundation

ServiceLayer.request(router: .getAllProjects(countryCode: nil)) { (result) in
    print("\n\n❤️ PROJECTS RESULT: \(result)")
    switch result {
    case .success(let data):
        guard let data = data else { return }
        
        if let dictionary: [String: Any] = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
           let innerDictionary = dictionary["projects"] as? [String: Any],
           let projectsArrayDictionary = innerDictionary["project"] as? Array<[String: Any]>,
           let projectsArrayData = try? JSONSerialization.data(withJSONObject: projectsArrayDictionary, options: []) {

            do {
                let projects = try JSONDecoder().decode([Project].self, from: projectsArrayData)
                projects.forEach {
                    print("""
                    Nome - \($0.title)
                    Description - \($0.summary)
                    Region - \($0.region)
                    Organization - \($0.organization.name ?? "Undefined")
                    Donation Link - \($0.projectLink ?? "Undefined")
                        
                    """)
                }
            } catch {
                print(String(bytes: data, encoding: .utf8) ?? "nil")
                print(error)
            }
        }
        
    case .failure(let error):
        print(error.localizedDescription)
    }
}


ServiceLayer.request(router: .searchProject(countryCode: "BR", theme: nil, query: ["Amazon"])) { (result) in
    print("\n\n🔎 SEARCH PROJECTS RESULT: \(result)")
    switch result {
    case .success(let data):
        guard let data = data else { return }
        
        if let dictionary: [String: Any] = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
           let searchDicionary = dictionary["search"] as? [String : Any],
           let responseDictionary = searchDicionary["response"] as? [String : Any],
           let innerDictionary = responseDictionary["projects"] as? [String: Any],
           let projectsArrayDictionary = innerDictionary["project"] as? Array<[String: Any]>,
           let projectsArrayData = try? JSONSerialization.data(withJSONObject: projectsArrayDictionary, options: []) {

            do {
                let projects = try JSONDecoder().decode([Project].self, from: projectsArrayData)
                projects.forEach {
                    print("""
                    Nome - \($0.title)
                    Description - \($0.summary)
                    Region - \($0.region)
                    Organization - \($0.organization.name ?? "Undefined")
                    Donation Link - \($0.projectLink ?? "Undefined")
                        
                    """)
                }
            } catch {
                print(String(bytes: data, encoding: .utf8) ?? "nil")
                print(error)
            }
        }
    case .failure(let error):
        print(error.localizedDescription)
    }
}


RunLoop.main.run(until: .distantFuture)
