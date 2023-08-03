//
//  CoreDataManager.swift
//  CoreData_Basic
//
//  Created by PHN MAC 1 on 07/07/23.
//

import UIKit
import CoreData

final class CoreDataManager{
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
// MARK: - Save Student Data
    func saveStudent(_ student: StudentModel){
        let studentEntity = Student(context: context)
        studentEntity.firstName = student.firstName
        studentEntity.lastName = student.lastName
        studentEntity.email = student.email
        studentEntity.mobileNumber = student.mobileNumber
        
        //save data
        self.saveContext()
    }
    
// MARK: - Fetch Students data
    func fetchStudent() -> [Student]{
        var students: [Student] = []
        do{
            students = try context.fetch(Student.fetchRequest())
        }
        catch let error{
            print("Student Fetching data Error:-",error)
        }
        return students
    }
    
// MARK: - Delete Students Data
    func deleteStudent(student: Student){
        context.delete(student)
        //save data
        self.saveContext()
    }
    
// MARK: - Update Students Data
    func updateStudent(newStudent: StudentModel, oldStudent: Student){
        oldStudent.firstName = newStudent.firstName
        oldStudent.lastName = newStudent.lastName
        oldStudent.email = newStudent.email
        oldStudent.mobileNumber = newStudent.mobileNumber
        
        //save data
        self.saveContext()
    }
    
// MARK: - other common  functions
    private func saveContext(){
        do{
            try context.save()
        }
        catch let error{
            print("Save time Error:- ", error)
        }
    }
}
