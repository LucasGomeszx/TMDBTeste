//
//  TableViewCell.swift
//  TMDBTeste
//
//  Created by Lucas Gomesx on 23/02/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtDesc: UILabel!
    @IBOutlet weak var anoFilme: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //Carrega dados dos filmes populares na celula.
    func onBind (data: MoviesApi, index: IndexPath) {
        txtName.text = data.movieList[index.row].title
        txtDesc.text = data.movieList[index.row].overview
        anoFilme.text = data.movieList[index.row].releaseDate
        
        if let image = data.movieList[index.row].posterPath{
            URLSession.shared.dataTask(with: URLRequest(url: URL(string: "\(K.urlImage)\(image)")!)){
                (data,request,error) in
                do{
                    let datas = data
                    DispatchQueue.main.async {
                        self.imageMovie.image = UIImage(data: datas!)
                    }
                }
            }.resume()
        }
    }
    
    //Carrega dados da busca do usuario na celula.
    func onBind (data: [Result], index: IndexPath) {
        txtName.text = data[index.row].title
        txtDesc.text = data[index.row].overview
        anoFilme.text = data[index.row].releaseDate
        
        if let image = data[index.row].posterPath{
            URLSession.shared.dataTask(with: URLRequest(url: URL(string: "\(K.urlImage)\(image)")!)){
                (data,request,error) in
                do{
                    let datas = data
                    DispatchQueue.main.async {
                        self.imageMovie.image = UIImage(data: datas!)
                    }
                }
            }.resume()
        }
    }
    
}
