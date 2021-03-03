//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by Şeyma Nur on 3.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var aedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRates(_ sender: Any) {
        //url almak - istek yollamak
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=dd61006a2b33607de805c7bf44c5b493")
        
        //birden fazla istekte bile her defasın da aynı obje üzerinden yollamak
        let session  = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            //verilen bilgi sonucunda geri dönen ne ?
            //eğer hata değil ise
            if error != nil{
                let alert  = UIAlertController(title: "Error", message: "Error!", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                //istek almak
                do{
                    //verileri almak
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String ,Any>
                    
                    DispatchQueue.main.async {
                        if let rates = jsonResponse["rates"] as? [String : Any]{
                            if let aed = rates["AED"] as? Double{
                                self.aedLabel.text = "AED : \(aed)"
                                
                            }
                            if let trys = rates["TRY"] as? Double{
                                self.tryLabel.text = "TRY : \(trys)"
                                
                            }
                            if let eur = rates["EUR"] as? Double{
                                self.eurLabel.text = "EUR : \(eur)"
                                
                            }
                            if let usd = rates["USD"] as? Double{
                                self.usdLabel.text = "USD : \(usd)"
                                
                            }

                        }
                        }
    
                }catch{
                   print("error")
                }
                }
        }
        task.resume()
    }
    
}

