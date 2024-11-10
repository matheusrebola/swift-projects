import UIKit

class AddEditViewController: UIViewController {
	//Variável que receberá o filme selecionado.
	var movie: Movie?
	@IBOutlet weak var ivMovie: UIImageView!
	@IBOutlet weak var tfTitle: UITextField!
	@IBOutlet weak var tfCategories: UITextField!
	@IBOutlet weak var tfDuration: UITextField!
	@IBOutlet weak var tfRating: UITextField!
	@IBOutlet weak var tvSummary: UITextView!
	@IBOutlet weak var btAddEdit: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		if let movie = movie {
			ivMovie.image = movie.image as? UIImage
			tfTitle.text = movie.title
			tfCategories.text = movie.categories
			tfDuration.text = movie.duration
			tfRating.text = "⭐ \(movie.rating)/10"
			tvSummary.text = movie.summary
		//Usamos o método setTitle para alertar o texto do botão para o seu estado normal.
		btAddEdit.setTitle("Alterar", for: .normal)
		}
	}
}