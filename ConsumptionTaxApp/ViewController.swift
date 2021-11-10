//
//  ViewController.swift
//  ConsumptionTaxApp
//
//  Created by 伴地慶介 on 2021/11/06.
//

import UIKit

class ViewController: UIViewController {

    var amounts: [String] = []
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountInputTextField: UITextField!
    @IBOutlet weak var taxSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        amountLabel.text = ""

        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "amounts") != nil) {
            amounts = userDefaults.object(forKey: "amounts") as! [String]
        }
    }

    @IBAction func tapTaxSegmentedControl(_ sender: Any) {
        if isNumber(inputText: amountInputTextField.text!) {
            let input = Double(amountInputTextField.text!) ?? 0.0
            switch (sender as AnyObject).selectedSegmentIndex {
            case 0:
                amountLabel.text = String(calcConsumptionTax(cost: input, tax: 0.1))
            case 1:
                amountLabel.text = String(calcConsumptionTax(cost: input, tax: 0.08))
            default:
                amountLabel.text = amountInputTextField.text
            }
        } else {
            showAlert(title: "Please Input Number", message: "you have to input number")
        }
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        if isNumber(inputText: amountInputTextField.text!) && amountLabel.text?.trimmingCharacters(in: .whitespaces) != "" {
            amounts.append(amountLabel.text!)
            let userDefaults = UserDefaults.standard
            userDefaults.set(amounts, forKey: "amounts")
            self.tableView.reloadData()
        } else {
            showAlert(title: "Please Input Number", message: "you have to input number")
        }
    }
    
    func isNumber(inputText: String) -> Bool {
        let pattern = "^[0-9]*$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: inputText, range: NSRange(location: 0, length: inputText.count))
        return matches.count == 1 ? true : false
    }
    
    func calcConsumptionTax(cost: Double, tax: Double) -> Double{
        return cost * (1.0 + tax)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = amounts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userDefaults = UserDefaults.standard
            amounts.remove(at: indexPath.row)
            userDefaults.set(amounts, forKey: "amounts")
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //
        }
    }
    
}
