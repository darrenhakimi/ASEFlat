//
//  GuestDateViewController.swift
//  Flat
//
//  Created by Darren Hakimi on 11/16/17.
//  Copyright © 2017 Darren Hakimi. All rights reserved.
//

import UIKit

class GuestDateViewController: UIViewController
{
    @IBOutlet weak var checkInDateOutlet: UITextField!
    
    @IBOutlet weak var checkOutDateOutlet: UITextField!
    
    @IBOutlet weak var errorOutlet: UILabel!
    
    let checkInDatePicker = UIDatePicker()
    let checkOutDatePicker = UIDatePicker()
    
    @objc func checkInDonePressed()
    {
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        //place date in outlet
        checkInDateOutlet.text = dateFormatter.string(from: checkInDatePicker.date)
        self.view.endEditing(true)
    }
    
    func createCheckInDatePicker()
    {
        //format for picker
        checkInDatePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(checkInDonePressed))
        toolbar.setItems([doneButton], animated: false)
        
        //assign date picker to text field
        checkInDateOutlet.inputAccessoryView = toolbar
        checkInDateOutlet.inputView = checkInDatePicker
    }
    
    @objc func checkOutDonePressed()
    {
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        //place date in outlet
        checkOutDateOutlet.text = dateFormatter.string(from: checkOutDatePicker.date)
        self.view.endEditing(true)
    }
    
    func createCheckOutDatePicker()
    {
        //format for picker
        checkOutDatePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(checkOutDonePressed))
        toolbar.setItems([doneButton], animated: false)
        
        //assign date picker to text field
        checkOutDateOutlet.inputAccessoryView = toolbar
        checkOutDateOutlet.inputView = checkOutDatePicker
    }
    
    
    @objc func nextAction()
    {
        if checkInDateOutlet.text! == ""
        {
            self.errorOutlet.text = "Invalid check-in date."
            self.errorOutlet.isHidden = false
        }
        else if checkOutDateOutlet.text! == ""
        {
            self.errorOutlet.text = "Invalid check-out date."
            self.errorOutlet.isHidden = false
        }
        else
        {
            self.errorOutlet.isHidden = true
            self.performSegue(withIdentifier: "segueGuestDateToGuestLocation", sender: Any?.self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueGuestDateToGuestLocation"
        {
            //pass data out when database is ready
        }
    }

    @objc func cancelAction()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Select Dates"
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextAction))
        self.navigationItem.rightBarButtonItem = nextButton
        
        createCheckInDatePicker()
        createCheckOutDatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
