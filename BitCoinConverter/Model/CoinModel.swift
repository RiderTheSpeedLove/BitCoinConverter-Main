//
//  CoinModel.swift
//  BitCoinConverter
//
//  Created by Sanjeev4 Tiwari on 05/09/22.
//

import Foundation

struct CoinModel{
    let rate : Double
    let currencyName : String
    let coinName : String
    
    var coinImage : String{
        switch coinName{
        case "ADA":
            return "ada"
            
        case "BNB":
            return "binance"
            
        case "BTC":
            return "bitcoin"
            
        case "DOGE":
            return "dogecoin"
            
        case "DOT":
            return "polkadot"
            
        case "ETH":
            return "ethereum"
            
        case "LTC":
            return "litecoin"
            
        case "LUNA":
            return "luna"
            
        case "SOL":
            return "solana"
            
        case "USDT":
            return "tether"
            
        case "XRP":
            return "xrp"
            
        default:
            return ""
        }
        
    }
    
    
}
