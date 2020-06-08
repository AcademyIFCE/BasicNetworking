//
//  ListaDePresencaViewController.swift
//  UIKitHandsOn
//
//  Created by Gabriela Bezerra on 16/01/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import UIKit

class ListaDePresencaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presencas: [Presenca] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        PresencaRepository().listar { [weak self] (presencas) in
            self?.presencas = presencas
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destiny = segue.destination as? DetailPresencaViewController,
            let sendedPresenca = sender as? Presenca, segue.identifier == "detailPresenca" {
            
            destiny.detailText = "\(sendedPresenca.nome) veio hoje!\nID: \(sendedPresenca.id)"
        }
    }
    
}

extension ListaDePresencaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presencas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = presencas[indexPath.row].nome
        cell.detailTextLabel?.text = "Presente"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "NOMES"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let presenca: Presenca = presencas[indexPath.row]
        
        self.performSegue(withIdentifier: "detailPresenca", sender: presenca)
    }
}
