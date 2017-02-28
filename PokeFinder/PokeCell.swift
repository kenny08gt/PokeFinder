//
//  PokeCell.swift
//  PokeFinder
//
//  Created by LionMane Software on 2/27/17.
//  Copyright © 2017 LionMane Software. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokeIndex: Int){
        
        nameLbl.text = PokeAnnotation.pokemons[pokeIndex].capitalized
        thumbImg.image = UIImage(named: "\(pokeIndex+1)")
        
    }

}
