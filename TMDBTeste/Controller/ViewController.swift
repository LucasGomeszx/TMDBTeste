//
//  ViewController.swift
//  TMDBTeste
//
//  Created by Lucas Gomesx on 23/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mTable: UITableView!
    
    var filmes = MoviesApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTable.delegate = self
        mTable.dataSource = self
        mTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Mostrando Primeiros 20 filmes populares.
        filmes.getData {
            DispatchQueue.main.async {
                self.mTable.reloadData()
            }
        }
    }
}

//MARK: -- UITableViewDelegate UITableViewDataSource
extension ViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmes.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("\(indexPath.row) of \(filmes.movieList.count)")
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellName , for: indexPath) as! TableViewCell
        
        // Mostrar mais 20 filmes.
        if indexPath.row == filmes.movieList.count - 1 && filmes.page < filmes.totalPage{
            filmes.getData {
                DispatchQueue.main.async {
                    self.mTable.reloadData()
                }
            }
        }
        cell.onBind(data: filmes, index: indexPath)
        return cell
    }
}
