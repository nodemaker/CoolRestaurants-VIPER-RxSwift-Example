//
//  MKCoordinateRegion+Extensions.swift
//  CoolRestaurants
//
//  Created by Sumeru Chatterjee on 26/02/2019.
//  Copyright © 2019 Sumeru Chatterjee. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

public extension MKCoordinateRegion {
    
    @available(*, unavailable, renamed: "init(center:latitudinalMeters:longitudinalMeters:)")
    public init(center: CLLocationCoordinate2D, latitudalDistance: CLLocationDistance, longitudalDistance: CLLocationDistance) {
        self.init(center: center, latitudinalMeters: latitudalDistance, longitudinalMeters: longitudalDistance)
    }
    
    public init(north: CLLocationDegrees, east: CLLocationDegrees, south: CLLocationDegrees, west: CLLocationDegrees) {
        let span = MKCoordinateSpan(latitudeDelta: north - south, longitudeDelta: east - west)
        let center = CLLocationCoordinate2D(latitude: north - (span.latitudeDelta / 2), longitude: west + (span.longitudeDelta / 2))
        
        self.init(
            center: center,
            span: span
        )
    }
    
    public func contains(_ point: CLLocationCoordinate2D) -> Bool {
        guard (point.latitude - center.latitude) >= span.latitudeDelta else {
            return false
        }
        guard (point.longitude - center.longitude) >= span.longitudeDelta else {
            return false
        }
        
        return true
    }
    
    public func contains(_ region: MKCoordinateRegion) -> Bool {
        guard span.latitudeDelta - region.span.latitudeDelta - (center.latitude - region.center.latitude) >= 0 else {
            return false
        }
        guard span.longitudeDelta - region.span.longitudeDelta - (center.longitude - region.center.longitude) >= 0 else {
            return false
        }
        
        return true
    }
    
    public var east: CLLocationDegrees {
        return center.longitude + (span.longitudeDelta / 2)
    }
    
    public mutating func insetBy(latitudinally latitudeDelta: Double, longitudinally longitudeDelta: Double = 0) {
        self = insettedBy(latitudinally: latitudeDelta, longitudinally: longitudeDelta)
    }
    
    public mutating func insetBy(latitudinally longitudeDelta: Double) {
        insetBy(latitudinally: 0, longitudinally: longitudeDelta)
    }
    
    public func insettedBy(latitudinally latitudeDelta: Double, longitudinally longitudeDelta: Double = 0) -> MKCoordinateRegion {
        var region = self
        region.span.latitudeDelta += latitudeDelta
        region.span.longitudeDelta += longitudeDelta
        return region
    }
    
    public func insettedBy(longitudinally longitudeDelta: Double) -> MKCoordinateRegion {
        return insettedBy(latitudinally: 0, longitudinally: longitudeDelta)
    }
    
    public func intersectedWith(_ region: MKCoordinateRegion) -> MKCoordinateRegion? {
        guard intersects(region) else {
            return nil
        }
        
        return MKCoordinateRegion(
            north: min(self.north, region.north),
            east: min(self.east, region.east),
            south: max(self.south, region.south),
            west: max(self.west, region.west)
        )
    }
    
    public func intersects(_ region: MKCoordinateRegion) -> Bool {
        if region.north < south {
            return false
        }
        if north < region.south {
            return false
        }
        if east < region.west {
            return false
        }
        if region.east < west {
            return false
        }
        
        return true
    }
    
    public var north: CLLocationDegrees {
        return center.latitude + (span.latitudeDelta / 2)
    }
    
    public var northEast: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: north, longitude: east)
    }
    
    public var northWest: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: north, longitude: west)
    }
    
    public mutating func scaleBy(_ scale: Double) {
        scaleBy(latitudinally: scale, longitudinally: scale)
    }
    
    public mutating func scaleBy(latitudinally latitudalScale: Double, longitudinally longitudalScale: Double = 1) {
        self = scaledBy(latitudinally: latitudalScale, longitudinally: longitudalScale)
    }
    
    public mutating func scaleBy(longitudinally longitudalScale: Double) {
        scaleBy(latitudinally: 1, longitudinally: longitudalScale)
    }
    
    public func scaledBy(_ scale: Double) -> MKCoordinateRegion {
        return scaledBy(latitudinally: scale, longitudinally: scale)
    }
    
    public func scaledBy(latitudinally latitudalScale: Double, longitudinally longitudalScale: Double = 1) -> MKCoordinateRegion {
        return insettedBy(latitudinally: (span.latitudeDelta / 2) * latitudalScale, longitudinally: (span.longitudeDelta / 2) * longitudalScale)
    }
    
    public func scaledBy(longitudinally: Double) -> MKCoordinateRegion {
        return scaledBy(latitudinally: 1, longitudinally: longitudinally)
    }
    
    public var south: CLLocationDegrees {
        return center.latitude - (span.latitudeDelta / 2)
    }
    
    public var southEast: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: south, longitude: east)
    }
    
    public var southWest: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: south, longitude: west)
    }
    
    public var west: CLLocationDegrees {
        return center.longitude - (span.longitudeDelta / 2)
    }
    
    public static let world: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360))
}

extension MKCoordinateRegion: Equatable {
    
    public static func == (a: MKCoordinateRegion, b: MKCoordinateRegion) -> Bool {
        return a.center == b.center && a.span == b.span
    }
}

extension CLLocationCoordinate2D: Equatable {
    
    public static func == (a: CLLocationCoordinate2D, b: CLLocationCoordinate2D) -> Bool {
        return a.latitude == b.latitude && a.longitude == b.longitude
    }
}

extension MKCoordinateSpan: Equatable {
    
    public static func == (a: MKCoordinateSpan, b: MKCoordinateSpan) -> Bool {
        return a.latitudeDelta == b.latitudeDelta && a.longitudeDelta == b.longitudeDelta
    }
}
