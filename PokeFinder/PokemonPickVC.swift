//
//  PokemonPickVC.swift
//  PokeFinder
//
//  Created by LionMane Software on 2/27/17.
//  Copyright © 2017 LionMane Software. All rights reserved.
//

import UIKit
import MapKit

class PokemonPickVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var loc: CLLocation?
    var filterPokemon = [String]()
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        // Do any additional setup after loading the view.
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
            if inSearchMode{
                let pokemon = filterPokemon[indexPath.row]
                let index = PokeAnnotation.pokemons.index(of: pokemon)

                cell.configureCell(pokemon: pokemon, pokeIndex: index!)
            }else{
                let pokemon = PokeAnnotation.pokemons[indexPath.row]
                cell.configureCell(pokemon: pokemon, pokeIndex: indexPath.row)
            }
            
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let vc = ViewController()
        vc.initGeoFire()
        if inSearchMode{
            let pokemon = filterPokemon[indexPath.row]
            let index = PokeAnnotation.pokemons.index(of: pokemon)
            vc.createSighting(forLocation: loc!, withPokemon: Int(index!) + 1)
        }else{
            vc.createSighting(forLocation: loc!, withPokemon: Int(indexPath.row + 1))
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            return filterPokemon.count

        }else{
            return PokeAnnotation.pokemons.count

        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        }else{
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filterPokemon = PokeAnnotation.pokemons.filter({$0.range(of: lower) != nil})
            
            collection.reloadData()
            
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
