//
//  ReceiptModel.swift
//  topping app
//
//  Created by Hamidreza Zebardast on 12/14/24.
//

import Foundation
import CoreLocation

struct ReceiptModel {
    var shipFrom: ShipFromModel?
    var shipTo: ShipToModel?
    var address: AddressModel?
    var priceText: String?
    
    init(
        shipFrom: ShipFromModel? = nil,
        shipTo: ShipToModel? = nil,
        address: AddressModel? = nil
    ) {
        self.shipFrom = shipFrom
        self.shipTo = shipTo
        self.address = address
    }
}

struct ShipToModel {
    let height: String
    let width: String
    let length: String
    let weight: String
    let postalCode: String
    let phone: String
    let email: String
    let contact: String
    let name: String
}

struct ShipFromModel {
    let contact: String
    let name: String
    let email: String
    let phone: String
}

struct AddressModel {
    let shipFromAddress: String
    let shipFromCoordinates: CLLocationCoordinate2D
    var shipToAddress: String
    var shipToCoordinates: CLLocationCoordinate2D
}
