//função save
func save(name: String, tele: String, emai: String){
	guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}

	let managedContext = appDelegate.persistentContainer.viewContext
	let entidade = NSEntityDescription.entity(forEntityName: "Pessoa", in: managedContext)!

	//update
	if (pessoaVindoDaTable == nil){
		let pessoa = NSManagedObject(entity: entidade, insertInto: managedContext)
		pessoa.setValue(name, forKeyPath: "nome")
		pessoa.setValue(tele, forKeyPath: "telefone")
		pessoa.setValue(emai, forKeyPath: "email")
	} else{
		let objectUpdate = pessoaVindoDaTable
		objectUpdate!.setValue(name, forKeyPath: "nome")
		objectUpdate!.setValue(tele, forKeyPath: "telefone")
		objectUpdate!.setValue(emai, forKeyPath: "email")
	}

	let pessoa = NSManagedObject(entity: entidade, insertInto: managedContext)
	pessoa.setValue(name, forKeyPath: "nome")
	pessoa.setValue(tele, forKeyPath: "telefone")
	pessoa.setValue(emai, forKeyPath: "email")

	do {
		try managedContext.save()
	} catch let error as NSError {
		print("não foi possível salvar. \(error), \(error.userInfo)")
	}
}

//botão salvar
@IBAction func salvar(_ sender: Any){
	self.save(name: txtNome.text!, tele: txtTelefone.text!, emai: txtEmail.text!)
	self.navigationController?.popViewController(animated: true)
}

//consulta
var pessoas: [NSManagedObject] = []

override func viewWillAppear(_ animated: Bool){
	guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
	let managedContext = appDelegate.persistentContainer.viewContext
	let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pessoa")
	fetchRequest.sortDescriptor = [NSSortDescriptor.init(key: "nome", ascending: true)]

	do {
		pessoas = try managedContext.fetch(fetchRequest)
	} catch let error as NSError {
		print("não foi possível buscar os dados \(error), \(error.userInfo)")
	}

	self.tableView.reloadData()
}

//populando a table view
override func numberOfSections(in tableView: UITableView) -> Int{
	return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
	return pessoas.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: indexPath) -> UITableViewCell {
	let cell = tableView.dequeueReusableCell(withIndetifier: "reuseIdentifier", for: indexPath)
	let pessoa = pessoas[indexPath.row]
	cell.textLabel?.text = pessoa.value(forKeyPath: "name") as? String
	cell.detailTextLabel?.text = pessoa.value(forKey: "email") as? String
	return cell
}

//deletando
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
	if editingStyle == .delete {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
		let managedContext = appDelegate.persistentContainer.viewContext
		managedContext.delete(pessoas[indexPath.row])
		do {
			try managedContext.save()
			pessoas.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		} catch let error as NSError{
			print("não foi possível excluir \(error), \(error.userInfo)")
		}
	} else if editingStyle == .insert  {

	}
}

//update
var pessoaVindoDaTable:NSManagedObject?=nil 
override fun viewDidLoad(){
	super.viewDidLoad()
	if pessoaVindoDaTable != nil {
		txtNome.text = pessoaVindoDaTable?.value(forKey: "nome") as? String
		txtTelefone.text = pessoaVindoDaTable?.value(forKey: "telefone") as? String
		txtEmail.text = pessoaVindoDaTable?.value(forKey: "email") as? String
	}
}

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	if segue.identifier == "tableParaAlterarSegue" {
		let vc = segue.destination as! ContatosViewController
		let pessoaSelecionada:NSManagedObject = pessoas[self.tableView.indexPathForSelectedRow!.item]
		vc.pessoaVindoDaTable = pessoaSelecionada
	}
}