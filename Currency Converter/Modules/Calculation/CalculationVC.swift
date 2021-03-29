//
//  CalculationVc.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 27/03/2021.
//

import UIKit

class CalculationVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var conversionsTableView: UITableView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint?

    private var expanded: Bool = true
    private let currencyPicker = CustomPicker()
    private let viewModel = CalculationVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTopView()
        self.setupTextFields()
        self.setupTableView()
        self.setupToggleButton()
        self.updateTopViewHeightAndButton()
        self.setupEvents()
        
        self.viewModel.fetchData(initialFetch: true) { (success) in
            self.conversionsTableView.reloadData()
            self.currencyTextField.text = self.viewModel.currencies[0].uppercased()
        }
    }
    
    private func setupTopView() {
        self.topView.layer.cornerRadius = 12
        self.topView.layer.borderWidth = 1
        self.topView.layer.borderColor = UIColor.systemGray.cgColor
        self.calculateButton.setTitle(AppText.calculateButton.rawValue.uppercased(), for: .normal)
    }

    private func setupTextFields() {
        self.inputTextField.keyboardType = .numbersAndPunctuation
        self.inputTextField.placeholder = AppText.inputPlaceholder.rawValue
        self.inputTextField.clearButtonMode = .whileEditing
        self.inputTextField.delegate = self
        
        self.currencyPicker.dataSource = self
        self.currencyPicker.delegate = self
        self.currencyPicker.toolbarDelegate = self
        self.currencyPicker.reloadAllComponents()
        
        self.currencyTextField.inputView = self.currencyPicker
        self.currencyTextField.inputAccessoryView = self.currencyPicker.toolbar
        self.currencyTextField.textAlignment = .center
    }
    
    private func setupTableView() {
        self.conversionsTableView.delegate = self
        self.conversionsTableView.dataSource = self
        self.conversionsTableView.tableFooterView = UIView()
        self.conversionsTableView.separatorStyle = .none
    }

    private func setupToggleButton() {
        self.toggleButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.toggleButton.layer.cornerRadius = 20
    }

    private func setupEvents() {
        self.toggleButton.addTarget(self, action: #selector(self.toggleButtonTapped(_:)), for: .touchUpInside)
        self.calculateButton.addTarget(self, action: #selector(self.calculateButtonTapped(_:)), for: .touchUpInside)
        self.viewModel.status.observeNext { (status) in
            switch status {
            case .view: self.conversionsTableView.reloadData()
            case .loading(let message):
                print("loading... \(message)")
            case .error(let message, let reload, let reloadMessage):
                print("Error loading... \(message). Reload: \(reload) - \(reloadMessage)")
            }
        }.dispose(in: bag)
    }

    private func updateTopViewHeightAndButton() {
        self.topViewHeightConstraint?.constant = self.expanded ? 100 : 0
        self.topView.isHidden = !expanded
        self.topView.layoutIfNeeded()
        self.toggleButton.setTitle(self.expanded ? "-" : "+", for: .normal)
    }
    
    private func checkInputs() -> Bool {
        guard let inputText = self.inputTextField.text else { return false }
        guard let currency = self.currencyTextField.text else { return false }
        
        let replacedString = inputText.replacingOccurrences(of: ",", with: ".")
        guard let value = Double(replacedString) else { return false }
        
        return value != 0.00 && !currency.isEmpty && currency != "-"
    }
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: AppText.alertTitle.rawValue,
            message: AppText.alertMessage.rawValue,
            preferredStyle: .alert
        )
        let okButton = UIAlertAction(title: AppText.okButton.rawValue, style: .default)
        
        alertController.addAction(okButton)
        
        self.present(alertController, animated: true, completion: nil)
    }

    @objc private func toggleButtonTapped(_ sender: UIButton) {
        self.expanded.toggle()
        self.updateTopViewHeightAndButton()
    }
    
    @objc private func calculateButtonTapped(_ sender: UIButton) {
        if self.checkInputs() {
            self.viewModel.fetchData(initialFetch: false) { (success) in
                self.expanded.toggle()
                self.updateTopViewHeightAndButton()
            }
        } else {
            self.showAlert()
        }
    }
}

extension CalculationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.conversions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CalculationVC: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if string == "" { return true }
        
        if string.range(of: "[^0-9,]", options: .regularExpression) != nil { return false }
        
        if string == "," {
            let punctuationCount = (textField.text ?? "").filter { $0 == "," }.count
            return punctuationCount == 0
        }
        
        return true
    }
}

extension CalculationVC: UIPickerViewDelegate, UIPickerViewDataSource, PickerDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.viewModel.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.currencies[row].uppercased()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currencyTextField.text = self.viewModel.currencies[row].uppercased()
    }
    
    func cancelTapped() {
        self.currencyPicker.selectRow(0, inComponent: 0, animated: false)
        self.currencyTextField.text = self.viewModel.currencies[0].uppercased()
        self.currencyTextField.resignFirstResponder()
    }
    
    func doneTapped() {
        let row = self.currencyPicker.selectedRow(inComponent: 0)
        self.currencyPicker.selectRow(row, inComponent: 0, animated: false)
        self.currencyTextField.text = self.viewModel.currencies[row].uppercased()
        self.currencyTextField.resignFirstResponder()
    }
}
