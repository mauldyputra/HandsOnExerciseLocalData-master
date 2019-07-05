//
//  CoreDataHelper.swift
//  HandsOnExerciseLocalData
//
//  Created by Indra Sumawi on 02/07/19.
//  Copyright © 2019 Indra Sumawi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper {
    init() {
        
    }
    
    //get app delegate
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    //parameters depends on the one that you want to save
    //can make it generic
    func save(schoolName: String, numStudents: Int16) {
        //get context
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let school = School(context: managedContext)
        school.name = schoolName
        school.numOfStudents = numStudents
        
        //commit
        do {
            try managedContext.save()
            print("Data Saved")
        }
        catch {
            print("Error")
        }
    }
    
    //return statement depends on what data to fetch
    //can make it generic
    func fetch()  -> [School] {
        var result: [School] = []
        
        //get context
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return result}

        let  request =  NSFetchRequest<NSFetchRequestResult>(entityName: "School")
    
        do {
            result = try managedContext.fetch(request) as! [School]
            print("success")
        }
        catch {
            result = []
            print("error")
        }
        return result
    }
}
