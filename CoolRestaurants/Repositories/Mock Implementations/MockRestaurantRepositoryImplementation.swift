//
//  RestaurantRepositoryImplementation.swift
//  CoolRestaurants
//
//  Created by Sumeru Chatterjee on 25/02/2019.
//  Copyright © 2019 Sumeru Chatterjee. All rights reserved.
//

import RxSwift
import MapKit

class MockRestaurantRepositoryImplementation: RestaurantRepository {

    static let instance = MockRestaurantRepositoryImplementation()
    let mockDelay = 2 // seconds
    static let mockBaseLatitude = 52.370216
    static let mockBaseLongitude = 4.895168

    func getRestaurants() -> Single<[Restaurant]> {
        return Single.create(subscribe: { [weak self] observer in
            guard let `self` = self else { return Disposables.create() }
            DispatchQueue.global(qos: .background).async {
                let restaurants = self.createMockRestaurants()
                let futureTime: DispatchTime = .now() + .seconds(Int(self.mockDelay))
                DispatchQueue.main.asyncAfter(deadline: futureTime) {
                    observer(.success(restaurants))
                }
            }
            return Disposables.create()
        })
    }

    private func createMockRestaurants() -> [Restaurant] {
        var mockRestaurants = [Restaurant]()
        for index in 0...10 {
            let mockRestaurant = Restaurant(identifier: "MockIdentifier\(index)",
                name: "MockRestaurant\(index)",
                description: "MockRestaurantDescription\(index)",
                coordinate: MockRestaurantRepositoryImplementation.randomCoordinate())
            mockRestaurants.append(mockRestaurant)
        }
        return mockRestaurants
    }
    
    private static func randomCoordinate() -> CLLocationCoordinate2D {
        let randomLat = mockBaseLatitude + randomCoordinate()
        let randomLong = mockBaseLongitude + randomCoordinate()
        return CLLocationCoordinate2D(latitude: randomLat, longitude: randomLong)
    }
    
    private static func randomCoordinate() -> Double {
        return Double(arc4random_uniform(140)) * 0.0001
    }

}
