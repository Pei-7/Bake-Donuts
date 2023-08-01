//
//  IngredientViewController.swift
//  Bake Donuts
//
//  Created by 陳佩琪 on 2023/7/31.
//

import UIKit
import FoodTruckKit


class IngredientViewController: UIViewController {
    @IBOutlet var ingredientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        setTitle(labelX: 24, labelString: "Dough")
        setRows(array: Donut.Dough.all, rowX: 24)
        
        setTitle(labelX: 124, labelString: "Glaze")
        setRows(array: Donut.Glaze.all, rowX: 124)
        
        setTitle(labelX: 224, labelString: "Topping")
        setRows(array: Donut.Topping.all, rowX: 224)
        
        

        
    }
    
    func setTitle(labelX: Int, labelString: String) {
        let label = UILabel(frame: CGRect(x: labelX, y: 20, width: 80, height: 40))
        ingredientView.addSubview(label)
        label.text = labelString
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
    }
    
    
    func setRows(array: [any Ingredient], rowX: Int) {
        
        let height = 90 * array.count
        let scrollView = UIScrollView(frame: CGRect(x: rowX, y: 60, width: 100, height: 655))
        let backgroudView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: height))
        ingredientView.addSubview(scrollView)
        scrollView.addSubview(backgroudView)
        scrollView.contentSize = CGSize(width: 80, height: height)
        scrollView.isScrollEnabled = true
        
        for i in 0 ... array.count - 1{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 90 * i, width: 80, height: 80))
            let image = array[i].uiImage(thumbnail: false)
            imageView.image = image
            backgroudView.addSubview(imageView)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
