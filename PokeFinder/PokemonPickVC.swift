//
//  PokemonPickVC.swift
//  PokeFinder
//
//  Created by LionMane Software on 2/27/17.
//  Copyright © 2017 LionMane Software. All rights reserved.
//

import UIKit
import MapKit

class PokemonPickVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var collection: UICollectionView!
    var loc: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        // Do any additional setup after loading the view.
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            cell.configureCell(pokeIndex: indexPath.row)
            
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let vc = ViewController()
        vc.initGeoFire()
        vc.createSighting(forLocation: loc!, withPokemon: Int(indexPath.row + 1))
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return PokeAnnotation.pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
    }



}
