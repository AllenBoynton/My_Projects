//
//  Pokemon.swift
//  PokeMatch
//
//  Created by Allen Boynton on 5/23/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import UIKit

class Pokemon {
    
    // References pokemon image
    private var _pokedexId: Int!
    
    var pokedexId: Int {
        
        if _pokedexId == nil {
            
            _pokedexId = 0
        }
        return _pokedexId
    }
    
    init(pokedexId: Int) {
        self._pokedexId = pokedexId
    }
    
}
