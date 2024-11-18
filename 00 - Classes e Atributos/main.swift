import Foundation

var atleta = Atleta()

atleta.nome="Matheus"
atleta.idade=26

print("Nome: \(atleta.nome)")
print("Idade: \(atleta.idade)")
print("Atleta \(atleta.nome) tem  \(atleta.idade) anos")

var atleta2 = Atleta(nome: "Bruna", idade: 28)

print("Atleta \(atleta2.nome) tem \(atleta2.idade) anos")

//criamos uma referência  que poderá "?" receber um atleta 

var atleta3:Atleta?
atleta3 = Atleta(nome:"Carlos", idade:26)
print("Atleta \(atleta3.nome) tem \(atleta3!.idade) anos")
atleta3 = nil

//enfermeira

var enfermeira = Enfermeira()

enfermeira.nome="Aline"
enfermeira.salario=5400.00
enfermeira.plantao=true
enfermeira.periodo=0

