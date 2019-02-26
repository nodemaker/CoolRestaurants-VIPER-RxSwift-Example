//
//  RestaurantsDetailContracts.swift
//  CoolRestaurants
//
//  Created by Sumeru Chatterjee on 25/02/2019.
//  Copyright © 2019 Sumeru Chatterjee. All rights reserved.
//

protocol RestaurantsDetailView: View {
    
    func showTitle(title: String)
}

protocol RestaurantsDetailUserActionsListener: UserActionsListener { }

protocol RestaurantsDetailRouter { }
