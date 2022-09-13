//
//  ViewController.swift
//  BitCoinConverter
//
//  Created by Sanjeev4 Tiwari on 02/09/22.
//

import UIKit

var coinManager = CoinManager()

class ViewController: UIViewController{

    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
    }
    
    @IBAction func convertButton(_ sender: UIButton) {
        let currency = coinManager.currency_array[pickerView.selectedRow(inComponent: 0)]
        let coinName = coinManager.coin_name[pickerView.selectedRow(inComponent: 1)]
        let currencyArray = currency.components(separatedBy: "-")
        let coinNameArray = coinName.components(separatedBy: "-")
        coinManager.fetchCurrency(currency: currencyArray[0], name: coinNameArray[0])
    }
}

extension ViewController : CoinManagerDelegate{
    func updateCoinData(_ coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.displayLabel.text = String(format: "%.4f", coinModel.rate)
            self.currencyLabel.text = coinModel.currencyName
            self.imageLabel.image = UIImage(named: coinModel.coinImage)
        }
    }
    
    
    func whatsTheError(error: Error) {
        print(error)
    }
    
    
}

extension ViewController : UIPickerViewDataSource , UIPickerViewDelegate{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return coinManager.currency_array.count
        }
        else{
            return coinManager.coin_name.count
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return coinManager.currency_array[row]
        }
        else{
            return coinManager.coin_name[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 14)
            pickerLabel?.textAlignment = .center
        }
        if(component == 0){
            pickerLabel?.text = coinManager.currency_array[row]
        }
        else{
            pickerLabel?.text = coinManager.coin_name[row]
        }
        pickerLabel?.textColor = UIColor.black

        return pickerLabel!
    }
    
//    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        var currency = ""
//        var coinName = ""
//        if(component == 0){
//            currency = coinManager.currency_array[row]
//        }
//        if(component == 1){
//            coinName = coinManager.coin_name[row]
//        }
//    }
    
}

