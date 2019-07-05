//
//  ViewController.swift
//  HandsOnExerciseLocalData
//
//  Created by Indra Sumawi on 02/07/19.
//  Copyright © 2019 Indra Sumawi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var numOfStudentsTextField: UITextField!
    
    //variables
    let coreDataHelper: CoreDataHelper = CoreDataHelper.init()
    var schoolArray = [School]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setup table view
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //load data from user default
        getName()
        //load data from core data
        schoolArray = coreDataHelper.fetch()
        tableView.reloadData()
    }
    
    func getName() {
        let name = UserDefaults.standard.string(forKey: "name")
        
        if name != nil {
            nameLabel.text = "Hi " + name!
        }
        else {
            nameLabel.text = ""
        }
    }


    @IBAction func saveButton(_ sender: Any) {
    UserDefaults.standard.set(nameTextField.text, forKey: "name")
        
        nameTextField.text  = ""
        getName()
    }
    
    @IBAction func addButton(_ sender: Any) {
        coreDataHelper.save(schoolName: schoolNameTextField.text!, numStudents: Int16(numOfStudentsTextField.text!)!)
        
        schoolArray = coreDataHelper.fetch()
        tableView.reloadData()
        
        schoolNameTextField.text = ""
        numOfStudentsTextField.text = ""
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath)
        
        let school = schoolArray[indexPath.row]
        
        cell.textLabel?.text = school.name! + " (\(school.numOfStudents))"
        
        return  cell
    }
}
