
import Foundation

/*:
 # Requisições Web em Swift

 Consumir uma API em Swift é mais fácil do que você pensa!

 Para aprender a fazer isso, utilizaremos como exemplo a API de Presencas, que tem o intuito de cadastrar e listar a presença dos alunos digitalmente.


 ## Documentação da API de Presenças
 Repositório com sourcecode da API: <https://github.com/mtsrodrigues/PresencaAPI>

 ### Root URL:
 https://api-presenca.herokuapp.com

 ### Endpoints:

 #### Mostrar a lista de presença do dia atual, com todas os nomes já cadastrados:

 _Request:_

 HTTP Method: GET

 Route: /presenca/listar

 Header: -

 Body: -


 _Response_
 ```
 [
     {
         "id": 123,
         "nome" : "Gabriela Bezerra",
         "hora": "2020-01-16 13:43:14 +0000"
     }
 ]
 ```

 #### Assinar a presença do dia atual:

 _Request_

 HTTP Method: POST

 Route: /presenca/assinar

 Header: "Content-Type:application/json"

 Body: { "nome" : "Nome Completo" }

 _Response_

 200 OK
 ```
 {}
 ```

 ERROR 403
 ```
 {
     "error": true,
     "reason" : "Já assinou a lista de presença!"
 }
 ```

*/
/*:
 ## GET
 Fazendo uma requisição GET para listar os nomes já cadastrados na lista de presença do dia atual
*/

func listarPresencas() {
    let path: String = "https://api-presenca.herokuapp.com/presenca/listar"
    let url: URL = URL(string: path)!

    //GET
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("\n"+(response as! HTTPURLResponse).description)
        print("Body:\n"+String(data: data!, encoding: .utf8)!)
    }.resume()
}

//listarPresencas()

/*:
 ## POST
 Construindo um arquivo de Rotas, para listar as URLs de uma maneira mais clara e centralizada no projeto.
*/

func assinarPresenca() {

    let path: String = "https://api-presenca.herokuapp.com/presenca/assinar"
    guard let url: URL = URL(string: path) else { return }

    let body: [String : Any] = [
        "nome" : "Gabriela Bezerra"
    ]

    if let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        urlRequest.httpBody = data

        URLSession.shared.uploadTask(with: urlRequest, from: data) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("\n"+(response as! HTTPURLResponse).description)
            print("Body:\n"+String(data: data!, encoding: .utf8)!)
        }.resume()
    }

}

//assinarPresenca()

/*:
 ## Router
 Construindo um arquivo de Rotas, para listar as URLs de uma maneira mais clara e centralizada no projeto.
*/

protocol Router {
    var root: String { get }
    var url: URL? { get }
}

enum PresencaAPI: Router {

    case listar
    case assinar

    var root: String {
        get {
            return "https://api-presenca.herokuapp.com"
        }
    }

    var url: URL? {
        switch self {
        case .listar: return URL(string: root+"/presenca/listar")
        case .assinar: return URL(string: root+"/presenca/assinar")
        }
    }

}

//print(PresencaAPI.listar.url)

/*:
 ## Codable
 `Codable` é um protocolo usado para encodificar (encode) e decodificar (decode) JSONs numa requisição.

 É um protocolo muito útil para definir modelos (structs ou classes) para o corpo de cada requisição. Dessa forma, fica muito mais claro quais dados estão sendo enviados e recebitos dentro do App.

 Esse protocolo é a junção de outros 2 protocolos independentes: `Decodable` e `Encodable`.

 ## Decodable
 Protocolo usado para decodificar dados do tipo `Data` e transforma-los no tipo especificado na hora da decodificação.

 Esse tipo especificado deve assinar (estar conforme) o protocolo Decodable.

 Supondo que faremos uma requisição a URL especificada em `urlBuscarUsuario` que retorna o seguinte JSON:

 ```
 {
    "id": 3592,
    "nome": "Gabriela Bezerra",
    "email": "gabrieladecarvalhobezerra@gmail.com",
    "tipo": "admin"
 }

```
 Em swift, podemos representar o retorno dessa requisição com o seguinte modelo implementado como struct:

 *Obs: note que o modelo deve estar em conformidade com o protocolo Decodable.*

```
     struct Usuario: Decodable {
         let id: Int
         let nome: String
         let email: String
         let tipo: String
     }

```

 Para extrair uma variável do tipo Usuário a partir do json que retornou na requisição (tipo Data), utilizamos o `JSONDecoder()`

 e chamamos a função `decode(type: Decodable.Protocol, from: Data)`

 ```
    URLSession.shared.dataTask(url: urlBuscarUsuario) { data, response, error in

        guard let data = data else { return }

        if let usuario: Usuario = try? JSONDecoder().decode(type: Usuario.self, from: data) {

            print(usuario.nome)
            print(usuario.email)
            // ... podemos acessar as chaves como atributos normais do struct
        }
    }

 ```


*/

struct Presenca: Decodable {
    let id: Int
    let nome: String
    let hora: String
}

func listarPresencasComDecoder() {

    guard let url: URL = PresencaAPI.listar.url else { return }

    //GET
    URLSession.shared.dataTask(with: url) { data, response, error in

        if let error = error {
            print(error.localizedDescription)
            return
        }

        guard let data = data else { return }

        if let presencas: [Presenca] = try? JSONDecoder().decode(Array<Presenca>.self, from: data) {
            print("***** Lista de Presenças *****\n")
            presencas.forEach {
                print("ID: \($0.id)\nNome:\($0.nome)\nHora:\($0.hora)\n")
            }
        } else {
            print("Erro fazendo decode da lista de presenças!")
        }

    }.resume()
}

//listarPresencasComDecoder()

/*:
 ## Encodable
  Protocolo usado para codificar dados do tipo `Data` e transforma-los no tipo especificado na hora da encodificação.

  Esse tipo especificado deve assinar (estar conforme) o protocolo Encodable.

  Supondo que faremos uma requisição POST que envia o seguinte JSON para a URL especificada em `urlCadastrarUsuario`:

```
{
     "nome": "Gabriela Bezerra",
     "email": "gabrieladecarvalhobezerra@gmail.com",
     "senha": "123456"
}

```
  Em swift, podemos representar o corpo dessa requisição com o seguinte modelo implementado como struct:

  *Obs: note que o modelo deve estar em conformidade com o protocolo Encodable.*

```
struct CadastroUsuario: Encodable {
    let nome: String
    let email: String
    let senha: String
}
```
 Como vimos anteriormente, para enviar um JSON numa requisicao POST em swift, devemos primeiro transformá-lo numa variável do tipo Data.

 Essa transformação é feita utilizando o `JSONEncoder()` chamando a função `encode(value: Encodable)`

```
URLSession.shared.dataTask(url: urlBuscarUsuario) { data, response, error in

    guard let data = data else { return }

    if let usuario: Usuario = try? JSONDecoder().decode(type: Usuario.self, from: data) {

        print(usuario.nome)
        print(usuario.email)
        // ... podemos acessar as chaves como atributos normais do struct
    }
}

```
*/

struct AssinarPresencaJSON: Encodable {
    let nome: String
}

func assinarPresencaComEncoder(nome: String) {

    guard let url: URL = PresencaAPI.assinar.url else { return }

    let json: AssinarPresencaJSON = AssinarPresencaJSON(nome: nome)

    if let jsonData = try? JSONEncoder().encode(json) {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        urlRequest.httpBody = jsonData

        URLSession.shared.uploadTask(with: urlRequest, from: jsonData) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            print("\n"+(response as! HTTPURLResponse).description)
            print("Body:\n"+String(data: data!, encoding: .utf8)!)
        }.resume()

    }

}

//assinarPresencaComEncoder(nome: "Mateus Rodrigues")
//assinarPresencaComEncoder(nome: "Gabriela Bezerra")

/*:
 ## Callbacks
 Usando completions do tipo `@escaping closure` para executar uma ação após uma Requisição Web (assíncrona) ter sido terminada.
*/

func listarPresencas(completion: @escaping ([Presenca]) -> Void) {

    guard let url: URL = PresencaAPI.listar.url else { return }

    URLSession.shared.dataTask(with: url) { data, response, error in

        if let error = error {
            print(error.localizedDescription)
            completion([])
            return
        }

        guard let data = data else {
            completion([])
            return
        }

        if let presencas: [Presenca] = try? JSONDecoder().decode(Array<Presenca>.self, from: data) {
            completion(presencas)
        } else {
            print("Erro fazendo decode da lista de presenças!")
            completion([])
        }

    }.resume()

}

//assinarPresencaComEncoder(nome: "Yuri Frota")

listarPresencas() { presencas in
    print("***** LISTA DE PRESENÇAS *****\n")
    presencas.forEach {
        print($0.nome, $0.hora)
    }
    print("\n******************************")
}





























