//
//  DetailPresencaViewController.swift
//  UIKitHandsOn
//
//  Created by Gabriela Bezerra on 16/01/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import UIKit

class DetailPresencaViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var detailText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionLabel.text = detailText
    }
    
}
