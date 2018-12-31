import UIKit

import UPCarouselFlowLayout
import MBProgressHUD
struct ModelCollectionFlowLayout {
    let name:String
    let capital:String
}
class ViewController: UIViewController,ServiceManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
        @IBOutlet weak var titlesTableView: UICollectionView!
        var inputArray : NSMutableArray = NSMutableArray.init()
      override func viewDidLoad() {
            super.viewDidLoad()
            let spe = MBProgressHUD.showAdded(to: self.view, animated: true)
            spe.label.text = "Loading"
            spe.detailsLabel.text = "Please Wait"
            spe.contentColor = UIColor.blue
            
            spe.isUserInteractionEnabled = true
            spe.hide(animated: true, afterDelay: 5)
            let floawLayout = UPCarouselFlowLayout()
            floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: titlesTableView.frame.size.height)
            floawLayout.scrollDirection = .horizontal
            floawLayout.sideItemScale = 0.8
            floawLayout.sideItemAlpha = 1.0
            floawLayout.spacingMode = .fixed(spacing: 5.0)
            titlesTableView.collectionViewLayout = floawLayout
           // Do any additional setup after loading the view, typically from a nib.
            let serviceManger = ServiceManager.init()
            serviceManger.delegate = self
            serviceManger.initiateGETRequest()
             }
func showAlert()
             {
            let alertController = UIAlertController.init(title: "Successful", message: "Webservice call ended", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
             }
            // MARK:- Service call
func didReceiveResponseFromServer(booksArrray : NSMutableArray){
            print("service call successfull")
           // saving to database
           let dbManager = DatabaseManager.init()
          dbManager.saveBooksData(booksArrray)
          inputArray = dbManager.fetchBooks()
          self.titlesTableView.reloadData()
            
        /// showing alert
            
          self.showAlert()

            }
        // MARK:- TableView Data Source
 
public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
           {
          return inputArray.count
            }
public func collectionView(_ collectionView: UICollectionView, titleForHeaderInSection section: Int) ->             String? // fixed font style. use custom view (UILabel) if you want something different
            
        {
           return "Books"
       }
@available(iOS 2.0, *)
public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->  UICollectionViewCell{
         let dictionary : NSDictionary = inputArray[indexPath.row] as! NSDictionary
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionViewCell
        cell.title.text = dictionary.value(forKey: "title") as? String ?? ""
        let spe = MBProgressHUD.showAdded(to: self.view, animated: true)
        spe.hide(animated: true)
        return cell
       }
     // MARK:- TableView Delegate
        
public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
       let dictionary : NSDictionary = inputArray[indexPath.row] as! NSDictionary
       let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
       let informationViewcontroller = storyBoard.instantiateViewController(withIdentifier: "info") as! InformationViewController
      informationViewcontroller.dictionary = dictionary
      self.navigationController?.pushViewController(informationViewcontroller, animated: true)
        }
    
    }

