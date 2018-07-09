//
//  PersonListTVC.swift
//  PersonListExam
//
//  Created by JLCS on 09/07/2018.
//  Copyright © 2018 JLCS. All rights reserved.
//

import UIKit

class PersonListTVC: UITableViewController {
    
    
    // MARK: - Properties
    var arrayOfPerson: [Person] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchPersonList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Private Helpers
    func setupViews() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl!)
    }
    
    func fetchPersonList() {
        
        let personListCacheExist = try? CacheManager.shared.storage?.existsObject(ofType: [Person].self, forKey: "PersonList")
        if personListCacheExist == true {
            CacheManager.shared.storage?.async.object(ofType: [Person].self, forKey: "PersonList", completion: { [weak self] result in
                guard let weakSelf = self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .value(let persons):
                        weakSelf.arrayOfPerson.removeAll()
                        weakSelf.arrayOfPerson.append(contentsOf: persons)
                        return
                    case .error(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            })
        }
        
        
        GetPersonList.fetch { [weak self] (persons, error) in
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                if error == nil {
                    guard let persons = persons else { return }
                    weakSelf.arrayOfPerson.removeAll()
                    weakSelf.arrayOfPerson.append(contentsOf: persons)
                } else {
                    print("Error: \(error?.localizedDescription ?? "Something went wrong.")")
                }
            }
        }
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchPersonList()
        refreshControl.endRefreshing()
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPerson.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // configure cell
        cell.textLabel?.text = arrayOfPerson[indexPath.row].fullName
        cell.detailTextLabel?.text = arrayOfPerson[indexPath.row].address
        
        
        return cell
    }

    
    // MARK: - Tableview Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DetailPersonVC,
            let indexPath = tableView.indexPathForSelectedRow
        {
            destVC.person = arrayOfPerson[indexPath.row]
        }
    }

}
