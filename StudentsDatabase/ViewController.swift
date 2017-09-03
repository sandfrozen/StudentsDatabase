//
//  ViewController.swift
//  StudentsDatabase
//
//  Created by Tomek Buslowski on 03.09.2017.
//  Copyright © 2017 Tomek Buslowski. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let student: Student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: DatabaseController.getContext()) as!  Student
        student.firstName = "John"
        student.lastName = "Smith"
        student.age = 23
        
        let course: Course = NSEntityDescription.insertNewObject(forEntityName: "Course", into: DatabaseController.getContext()) as! Course
        course.courseName = "Computer Science 402"
        
        student.addToCourses(course)
        
        DatabaseController.saveContext()
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        
        do {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            print("Number of Student results: \(searchResults.count)")
            
            for result in searchResults as [Student] {
                print("\(result.firstName!) \(result.lastName!) is \(result.age) years old.")
                DatabaseController.getContext().delete(result)
            }
            DatabaseController.saveContext()
        } catch {
            print("Error: \(error)")
        }
        
        let fetchRequest2: NSFetchRequest<Course> = Course.fetchRequest()
        
        do {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest2)
            print("Number of Course results: \(searchResults.count)")
            
            for result in searchResults as [Course] {
                print("\(result.courseName!)")
                //DatabaseController.getContext().delete(result)
            }
            //DatabaseController.saveContext()
        } catch {
            print("Error: \(error)")
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

