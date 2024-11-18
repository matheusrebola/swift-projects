import UIKit
import CoreData

class CadastroViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var txtNomeDoProjeto: UITextField! 
	@IBOutlet weak var txtTipoEnergia: UITextField! //Solar, Eólica, Hidrelétrica, Biomassa, Geotérmica, etc.
	@IBOutlet weak var txtLocalizacao: UITextField! //latitude e longitude
	@IBOutlet weak var txtEmpresaResponsavel: UITextField! 

	var greenDayVindoDaTable:NSManagedObject?=nil 

	override func viewDidLoad(){
		super.viewDidLoad()

		txtNomeDoProjeto.delegate = self
		txtTipoEnergia.delegate = self
		txtLocalizacao.delegate = self
		txtEmpresaResponsavel.delegate = self

	}

	@IBAction func salvar(_ sender: Any){
		txtNomeDoProjeto.resignFirstResponder()
		txtTipoEnergia.resignFirstResponder()
		txtLocalizacao.resignFirstResponder()
		txtEmpresaResponsavel.resignFirstResponder()
		if txtNomeDoProjeto.text!.isEmpty || txtTipoEnergia.text!.isEmpty || txtLocalizacao.text!.isEmpty || txtEmpresaResponsavel.text!.isEmpty{
			let alerta = UIAlertController(
				title: "Erro",
				message: "Preencha todos os campos",
				preferredStyle: UIAlertController.Style.alert)
			alerta.addAction(UIAlertAction(
				title: "OK",
				style: UIAlertAction.Style.cancel,
				handler: nil))
			present(alerta, animated: true, completion: nil)
			return
		}
		else {
			self.save(projeto: txtNomeDoProjeto.text!, energia: txtTipoEnergia.text!, local: txtLocalizacaol.text!, empresa: txtEmpresaResponsavel.text!)
			self.navigationController?.popViewController(animated: true)
		}
	}

	func save(projeto: String, energia: String, local: String, empresa: String){
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
		let managedContext = appDelegate.persistentContainer.viewContext
		let entidade = NSEntityDescription.entity(forEntityName: "GreenDay", in: managedContext)!

		let greenDay = NSManagedObject(entity: entidade, insertInto: managedContext)
			greenDay.setValue(projeto, forKeyPath: "nomeDoProjeto")
			greenDay.setValue(energia, forKeyPath: "tipoEnergia")
			greenDay.setValue(local, forKeyPath: "localizacao")
			greenDay.setValue(empresa, forKeyPath: "empresaResponsavel")

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("não foi possível salvar. \(error), \(error.userInfo)")
		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool{
		if textField == txtNomeDoProjeto{
			txtTipoEnergia.becomeFirstResponder() 
			return true 
		}else if textField == txtTipoEnergia{
			txtLocalizacao.becomeFirstResponder()
		}else if textField == txtLocalizacao{
			txtEmpresaResponsavel.becomeFirstResponder()
		}else if textField == txtEmpresaResponsavel{
			Salvar(textField)// na última caixa será executado o botão gravar
			return true
		}
		return false
	}


}