//
//  main.swift
//  HandsOnLab
//
//  Created by Gabriela Bezerra on 07/06/20.
//

import Foundation

//MARK: - #0 Simple GET Request
//Criando um URLComponents e especificando cada componente
var components = URLComponents()
components.scheme = "https"
components.host = "api.github.com"
components.path = "/users/gabrielabezerra"

//Construindo a URL toda como um Optional
guard let url = components.url else {
    preconditionFailure("Failed to construct the URL")
}

// Criando uma URLSessionDataTask e configurando o seu callback (completionHandler)
let task = URLSession.shared.dataTask(with: url, completionHandler: {
    data, response, error in
    
    if let data = data {
        print("GITHUB:",String(bytes: data, encoding: .utf8)!,"\n\n")
    } else {
        print(error!.localizedDescription)
    }

})

//task.resume()





//MARK: - #1 GET, POST e DELETE Request para um server local
/// `GET` Read all Todos
func readAllTodos(completion: @escaping ([Todo]) -> Void) {
    
    var getTodoComponents = URLComponents()
    getTodoComponents.scheme = "http"
    getTodoComponents.host = "127.0.0.1"
    getTodoComponents.port = 8080
    getTodoComponents.path = "/todos"
    
    guard let getTodoURL = getTodoComponents.url else {
        preconditionFailure("Failed to construct the URL")
    }
    
    let getTodoTask = URLSession.shared.dataTask(with: getTodoURL, completionHandler: {
        data, response, error in
        
        if let data = data {
            print("TODOs:",String(bytes: data, encoding: .utf8)!,"\n\n")
            
            if let todoList = try? JSONDecoder().decode([Todo].self, from: data) {
                completion(todoList)
            } else {
                completion([])
            }
            
        } else {
            print(error!.localizedDescription)
            completion([])
        }
        
    })
    
    getTodoTask.resume()
}


/// `POST` Create new Todo
func createTodo(title: String) {
    
    var postTodoComponents = URLComponents()
    postTodoComponents.scheme = "http"
    postTodoComponents.host = "127.0.0.1"
    postTodoComponents.port = 8080
    postTodoComponents.path = "/todos"
    
    //Construindo a URL toda como um Optional
    guard let postTodoURL = postTodoComponents.url else {
        preconditionFailure("Failed to construct the URL")
    }
    
    let newTodo = Todo(title: title)
    
    var postTodoURLRequest = URLRequest(url: postTodoURL)
    postTodoURLRequest.httpMethod = "POST"
    postTodoURLRequest.httpBody = try? JSONEncoder().encode(newTodo)
    postTodoURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let postTodoTask = URLSession.shared.dataTask(with: postTodoURLRequest, completionHandler: {
        data, response, error in
        
        if let data = data {
            print("Creating TODO:",String(bytes: data, encoding: .utf8)!,"\n\n")
        } else {
            print(error!.localizedDescription)
        }
    })
    
    postTodoTask.resume()
}

func deleteTodo(id: String) {
    
    var deleteTodoComponents = URLComponents()
    deleteTodoComponents.scheme = "http"
    deleteTodoComponents.host = "127.0.0.1"
    deleteTodoComponents.port = 8080
    deleteTodoComponents.path = "/todos/\(id)"
    
    //Construindo a URL toda como um Optional
    guard let deleteTodoURL = deleteTodoComponents.url else {
        preconditionFailure("Failed to construct the URL")
    }
    
    var deleteTodoURLRequest = URLRequest(url: deleteTodoURL)
    deleteTodoURLRequest.httpMethod = "DELETE"
    
    let deleteTodoTask = URLSession.shared.dataTask(with: deleteTodoURLRequest, completionHandler: {
        data, response, error in
        
        if let data = data {
            print("Deleting TODO:",String(bytes: data, encoding: .utf8)!,"\n\n")
        } else {
            print(error!.localizedDescription)
        }
    })
    
    deleteTodoTask.resume()
    
}

readAllTodos(completion: {
    todoList in
    print("Parsed TODO List:",todoList,"\n\n")
})

//createTodo(title: "Write Reports")

//readAllTodos(completion: { todoList in
//    if let id = todoList.last?.id {
//        deleteTodo(id: id)
//    }
//})

RunLoop.main.run(until: .distantFuture)
