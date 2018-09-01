//
//  GamesTableViewController.swift
//  MyGames
//
//  Created by aluno on 21/07/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

import CoreData

class Games2TableViewController: UITableViewController {
    var fetchedResultController:NSFetchedResultsController<Game>!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGames()
    }
    func loadGames(){
        
        // Coredata criou na classe model uma funcao para recuperar o fetch request
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        
        // definindo criterio da ordenacao de como os dados serao entregues
        let gameTitleSortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [gameTitleSortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    
}

extension GamesTableViewController: NSFetchedResultsControllerDelegate {
    
    // sempre que algum objeto for modificado esse metodo sera notificado
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default:
            tableView.reloadData()
        }
    }
}
