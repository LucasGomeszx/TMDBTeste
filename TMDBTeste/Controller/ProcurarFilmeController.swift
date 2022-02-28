//
//  ProcurarFilmeController.swift
//  TMDBTeste
//
//  Created by Lucas Gomesx on 24/02/22.
//

import UIKit

class ProcurarFilmeController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buscasTable: UITableView!
    
    var filmesBusca = MoviesBusca()
    var listaDeFilmes = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        filmesBusca.delegate = self
        
        buscasTable.delegate = self
        buscasTable.dataSource = self
        buscasTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
}

//MARK: -- UITextFieldDelegate

extension ProcurarFilmeController: UITextFieldDelegate {
    
    //Pesquisando filme a cada letra digitada.
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let busca = textField.text
        filmesBusca.buscarFilme(buscaUsuario: busca!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


//MARK: -- UITableViewDelegate UITableViewDataSource

extension ProcurarFilmeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeFilmes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellName, for: indexPath) as! TableViewCell
        cell.onBind(data: listaDeFilmes, index: indexPath)
        return cell
    }
    
}

//MARK: -- BuscaFilmesDelegate

extension ProcurarFilmeController: BuscaFilmesDelegate{
    
    // Exibindo filmes da busca.
    func didUpdateFilmes(movieBusca: MoviesBusca, listafilmes: [Result]) {
        self.listaDeFilmes = listafilmes
        DispatchQueue.main.async {
            self.buscasTable.reloadData()
        }
    }
}
