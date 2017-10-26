//
//  NewList.swift
//  PS Give
//
//  Created by Isha Chirimar on 8/13/17.

import UIKit
import Moltin
import Alamofire

class NewList: UITableViewController {
    private var products: [Product] = []
    var category: ProductCategory!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        getProducts()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getProducts(){
        let query = MoltinQuery(offset: nil, limit: nil, sort: nil, filter: nil, include: [.files, .brands, .categories])
        Moltin.product.list(withQuery: query) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let list):
                self.products = list.products
                self.tableView?.reloadData()
            }
        }
        
    }
    
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductCell
        //this is not working! figure out why products not pulling from moltin!
        let product = products[indexPath.item]
        cell.productname.text = product.name
        print(product.name)
        //cell.productprice.text = product.displayPriceWithTax?.formatted
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
   
}




