Aqui está o texto formatado como um arquivo `README.md`:

```markdown
# Tela Core Data

Este projeto tem como objetivo criar um aplicativo para digitar e salvar **Nome**, **Telefone** e **E-mail**. Ele também é utilizado para aprender a manipular o teclado por meio de protocolos e, no futuro, será usado em aulas de persistência.

---

## Iniciando o Projeto

1. Clique em `File -> New Project -> iOS -> App -> Next`.

### Criando o projeto

- Preencha com os dados abaixo:
  - **Organization Identifier**: Use uma URL invertida.
  - **Language**: Swift.
  - **Interface**: Storyboard.
  - **Nome do projeto**: *Tela Core Data*.
- Marque o checkbox `Use Core Data`.
- **IMPORTANTE**: Para projetos Core Data, não utilize `-` no nome do arquivo.

---

## Configuração da Interface

### Adicionando Objetos

1. Inclua:
   - **1 Button** (Botão).
   - **3 Text Fields** (Caixas de texto).

2. Configure:
   - Altere o texto do botão para `Salvar`.
   - Nos atributos dos Text Fields (Placeholder):
     - Nome
     - Telefone
     - E-mail.

---

## Declarações no Código

### Criando Outlets

- Organize o ambiente para exibir o design e o código simultaneamente.
- Crie os **Outlets** no `ViewController.swift` para os Text Fields:
  - `txtNome`
  - `txtTelefone`
  - `txtEmail`

### Criando IBAction

- Arraste uma ligação do botão `Salvar` para o código, pressionando `Control`.
- Nomeie a `Action` como `Salvar`.

---

## Solução para o Teclado Ativo

### Resolvendo o foco

- Adicione o método `resignFirstResponder` para liberar o foco de todas as caixas de texto ao clicar no botão **Salvar**.

Exemplo no arquivo `ViewController.swift`:
```swift
@IBAction func salvar(_ sender: UIButton) {
    txtNome.resignFirstResponder()
    txtTelefone.resignFirstResponder()
    txtEmail.resignFirstResponder()
}
```

- Após executar, observe que ao preencher os campos e clicar em **Salvar**, o teclado desaparece.

---

## Alternativas para Fechar o Teclado

### Usando o Método `touchesBegan`

- Intercepte toques em qualquer lugar da tela com o método `touchesBegan`:
```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
}
```

### Modificando o Teclado Virtual

1. Altere o botão de retorno (`Return`) para `Next` ou `Done`:
   - No Text Field do **Nome**, altere para `Next`.
   - Para o **Telefone**, altere para `Next`.
   - Para o **E-mail**, altere para `Done`.

### Posicionar o Foco

- Use o protocolo `UITextFieldDelegate` para interceptar eventos e mover o foco entre as caixas de texto.

Exemplo no método `textFieldShouldReturn`:
```swift
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == txtNome {
        txtTelefone.becomeFirstResponder()
    } else if textField == txtTelefone {
        txtEmail.becomeFirstResponder()
    } else {
        textField.resignFirstResponder()
    }
    return true
}
```

---

## Protocolos e Delegates

Implemente o protocolo `UITextFieldDelegate` para gerenciar os eventos do teclado virtual.

Exemplo de configuração no método `viewDidLoad`:
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    txtNome.delegate = self
    txtTelefone.delegate = self
    txtEmail.delegate = self
}
```

### Métodos do Protocolo

- **textFieldDidEndEditing**: Chamado quando o campo perde o foco.
- **textFieldShouldEndEditing**: Indica se a edição pode ser finalizada.
- **textFieldDidBeginEditing**: Chamado quando o campo começa a ser editado.
- **textFieldShouldBeginEditing**: Verifica se o campo pode ser editado.

---

## Validação e Mensagens

### Testando o Preenchimento

- Utilize `UIAlertController` para verificar se todos os campos estão preenchidos antes de salvar.
- Exemplo de validação:
```swift
if txtNome.text?.isEmpty ?? true || 
   txtTelefone.text?.isEmpty ?? true || 
   txtEmail.text?.isEmpty ?? true {
    // Exibir alerta de erro
} else {
    // Concatenar e exibir mensagem
}
```

---

## Observações

- Este projeto ainda não grava os dados, apenas exibe mensagens como teste.
- Consulte a documentação do **Core Data** para adicionar persistência no futuro.
```