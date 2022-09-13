//
//  CoinManager.swift
//  BitCoinConverter
//
//  Created by Sanjeev4 Tiwari on 04/09/22.
//

import Foundation

protocol CoinManagerDelegate{
    func updateCoinData(_ coinModel : CoinModel)
    
    func whatsTheError(error : Error)
}

struct CoinManager{
    let currency_array = ["AUD-Australian Dollar", "BRL-Brazilian Real","CAD-Canadian Dollars","CNY-Chinese Yuan","EUR-Euro","GBP-British Pound","HKD-Honkong Dong","IDR-Indonesian Rupiah","ILS-Israeli Shekel","INR-Indian Ruppee","JPY-Japanese Yen","MXN-Mexican Peso","NOK-Norwegian Krone","NZD-NewZeland Dollar","PLN-Poland złoty","RON-Romanian Leu","RUB-Russian Ruble","SEK-Swedish Krona","SGD-Singapore Dollar","USD-US Dollar","ZAR-South African Rand"]
    
    let coin_name = ["ADA-Cardano" , "BNB-Binance" , "BTC-BitCoin" , "DOGE-DogeCoin" , "DOT-PolkaDot" , "ETH-Ethereum" , "LTC-LiteCoin" , "LUNA-Terra" , "SOL-Solana" , "USDT-Tether" , "XRP-Ripple"]
    
    let currency_url = "https://rest.coinapi.io/v1/exchangerate"
    
    var delegate : CoinManagerDelegate?
    
    func fetchCurrency(currency : String , name : String){
        let url = "\(currency_url)/\(name)/\(currency)?apikey=A0CF93A5-0056-43E8-8FB3-32A34E986A2A"
        performRequest(url)
    }
    
    
    func performRequest(_ urlString : String){
        //1.Create a Url
        let url = URL(string: urlString)!
        //2.Create a Url Session
        let session = URLSession(configuration: .default)
        //3.Give the session a task
        let task = session.dataTask(with: url, completionHandler: { Data , URLResponse , Error in
            if(Error != nil){
                print(Error!)
            }
            if let safedata = Data{
                if let coinmodel = parseJson(safedata){
                    self.delegate?.updateCoinData(coinmodel)
                }
            }
            
        })
        //4. Start a task
        task.resume()
    }
    
    func parseJson(_ coinData : Data) -> CoinModel?{
        let decode = JSONDecoder()
        do{
            let decodedData = try decode.decode(CoinData.self, from: coinData)
            
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            let coinName = decodedData.asset_id_base
            
            let coinModel = CoinModel(rate: rate, currencyName: currency, coinName: coinName)
            return coinModel
        }
        catch{
            print(error)
            return nil
        }
        
    }
    
}
