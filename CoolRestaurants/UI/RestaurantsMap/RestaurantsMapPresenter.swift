//
//  RestaurantsMapPresenter.swift
//  CoolRestaurants
//
//  Created by Sumeru Chatterjee on 25/02/2019.
//  Copyright © 2019 Sumeru Chatterjee. All rights reserved.
//

import Foundation
import RxSwift

class RestaurantsMapPresenter: BasePresenter {
    
    private let router: RestaurantsMapRouter
    private var restaurantsMapView: RestaurantsMapView? { return view as? RestaurantsMapView }
    
    init(router: RestaurantsMapRouter) {
		self.router = router
    }
}

extension RestaurantsMapPresenter: RestaurantsMapUserActionsListener { }
