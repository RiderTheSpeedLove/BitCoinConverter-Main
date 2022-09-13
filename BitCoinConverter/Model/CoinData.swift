//
//  CoinData.swift
//  BitCoinConverter
//
//  Created by Sanjeev4 Tiwari on 04/09/22.
//

import Foundation

struct CoinData : Codable{
    let rate : Double
    let asset_id_quote : String
    let asset_id_base : String
}
