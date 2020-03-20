//
//  nomeProduto.swift
//  Balaio individual
//
//  Created by Luis Eduardo de Melo Corrêa Ramos on 10/03/20.
//  Copyright © 2020 Luis Eduardo de Melo Corrêa Ramos. All rights reserved.
//

import UIKit
class Produto {
    var nomeProduto: String
    var uniConsD:String
    var uniDesp:String
    var taxaConv:Double
    var imgIcon: UIImage
    init(nomeProduto: String, uniConsD: String, uniDesp: String, taxaConv: Double, imgIcon: UIImage) {
        self.nomeProduto = nomeProduto
        self.uniConsD = uniConsD
        self.uniDesp = uniDesp
        self.taxaConv = taxaConv
        self.imgIcon = imgIcon
    }
}
