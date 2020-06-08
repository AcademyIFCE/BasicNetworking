//
//  AssinarListaViewController.swift
//  UIKitHandsOn
//
//  Created by Gabriela Bezerra on 13/01/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import UIKit

class PresencaStoryboardViewController: UIViewController {

    // 03.1 Adicionando @IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 04.1 Delegate
        textField.delegate = self
        
        self.textField.addTarget(self, action: #selector(focus), for: .editingDidBegin)
        self.textField.addTarget(self, action: #selector(unfocus), for: .editingDidEnd)
    }
    
    // 03.2 Adicionando @IBAction
    @IBAction func assinar(_ sender: UIButton) {
        
        print("Fazer requisição assinando presença")
        
        if let nome = self.textField.text, nome.replacingOccurrences(of: " ", with: "") != "" {
            
            // Chamando Repository
            PresencaRepository().assinar(nome: nome) { message in
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }
            }
            
        }
        
    }
    
    // Mais UIControl
    @objc func focus() {
        if UIScreen.main.bounds.midY < self.textField.center.y {
            UIView.animate(withDuration: 0.25) {
                let newPos = CGPoint(x: self.view.center.x, y: self.view.center.y - (self.textField.center.y - self.view.center.y) + 15)
                self.view.center = newPos
            }
        }
    }
       
    @objc func unfocus() {
        UIView.animate(withDuration: 0.15) {
            let originalPos = CGPoint(x: self.view.center.x, y: UIScreen.main.bounds.midY)
            self.view.center = originalPos
        }
    }
    
    func centroDaSubview(para subview: UIView, em view: UIView) -> CGPoint {
        let x = view.bounds.size.width/2 - subview.frame.size.width/2
        let y = view.bounds.size.height/2 - subview.frame.size.height/2
        return CGPoint(x: x, y: y)
    }
    

}

// 04.2 Metodos padrao do UITextFieldDelegate
extension PresencaStoryboardViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = textField.text?.localizedCapitalized
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return Int(string) == nil
    }
    
}
