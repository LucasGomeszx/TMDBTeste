//
//  MoviesBusca.swift
//  TMDBTeste
//
//  Created by Lucas Gomesx on 24/02/22.
//

import Foundation

protocol BuscaFilmesDelegate {
    func didUpdateFilmes(movieBusca: MoviesBusca, listafilmes: [Result])
}

class MoviesBusca {
    
    var delegate: BuscaFilmesDelegate?
    
    var url = K.urlBuscarFilmes
    var filmesDaBusca =  [Result]()
    var letrasDigitadas = [String]()
    
    func buscarFilme(buscaUsuario: String){
        
        // Tratando espaco digitado pelo usuario.
        self.letrasDigitadas = []
        for letra in buscaUsuario{
            if letra == " " {
                self.letrasDigitadas.append("%20")
            }else{
                self.letrasDigitadas.append("\(letra)")
            }
        }
        
        //Criando url da busca.
        let minhaUrl = "\(self.url)\(self.letrasDigitadas.joined())"
        print(minhaUrl)
        
        //Verificando se e uma URL valida.
        guard let url = URL(string: minhaUrl) else {
            print("Erro ao acessar url")
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            if let safaData = data {
                if let listaFilmes =  self.parseJson(safaData){
                    //Mandando o resultado da pesquisa para o controller 
                    self.delegate?.didUpdateFilmes(movieBusca: self, listafilmes: listaFilmes)
                }
            }
        }
        task.resume()
    }
    
    func parseJson(_ listaFilmes: Data) -> [Result]? {
        let decoder = JSONDecoder()
        do{
            let returned = try decoder.decode(MoviesModel.self, from: listaFilmes)
            self.filmesDaBusca = []
            self.filmesDaBusca += returned.results
            return self.filmesDaBusca
        }catch{
            return nil
        }
    }
}
