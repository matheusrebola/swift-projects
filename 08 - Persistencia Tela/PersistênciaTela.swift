
	override func viewDidLoad(){
		super.viewDidLoad()

		txtNome.delegate = self
		txtTelefone.delegate = self
		txtEmail.delegate = self
	}

	//liberar foco
	@IBAction func Salvar(_ sender: Any){
		txtNome.resignFirstResponder()
		txtTelefone.resignFirstResponder()
		txtEmail.resignFirstResponder()
		if txtNome.text!.isEmpty || txtTelefone.text!.isEmpty || txtEmail.text!.isEmpty{
			let alertaCamposNaoPreenchidos = UIAlertController(
				title: "Erro",
				message: "Preencha todos os campos",
				preferredStyle: UIAlertController.Style.alert)
			alertaCamposNaoPreenchidos.addAction(UIAlertAction(
				title: "OK",
				style: UIAlertAction.Style.cancel,
				handler: nil))
			present(alertaCamposNaoPreenchidos, animated: true, completion: nil)
			return
		}

	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool{
		if textField == txtNome{
			txtTelefone.becomeFirstResponder() //manda o foco para o telefone
			return true 
		}else if textField == txtTelefone{
			txtEmail.becomeFirstResponder() //manda o foco para o email
		}else if textField == txtEmail{
			Salvar(textField)// na última caixa será executado o botão gravar
			return true
		}
		return false
	}

