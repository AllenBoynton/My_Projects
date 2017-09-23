//
//  HomeDatasource.swift
//  Flitter
//
//  Created by Allen Boynton on 9/10/17.
//  Copyright © 2017 Allen Boynton. All rights reserved.
//

import LBTAComponents

class HomeDatasource: Datasource {
    
    let names = ["Allen Boynton", "Donald Trump", "Ray Wenderlich"]
    
    let userNames = ["@ABoynton4Mobile", "@realDonaldTrump", "@rwenderlich"]
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return names[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return names.count
    }
}
