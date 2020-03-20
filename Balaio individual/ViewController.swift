//
//  ViewController.swift
//  Balaio individual
//
//  Created by Luis Eduardo de Melo Corrêa Ramos on 03/03/20.
//  Copyright © 2020 Luis Eduardo de Melo Corrêa Ramos. All rights reserved.
//

import UIKit

// Adicionar botão ao teclado
extension UITextField{
    //Gerar função que adiciona o botão
    func addDoneButtonToKeyboard(myAction:Selector?){
        //determinar o espaço da barra do botão
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        //determinar o botão
        let done: UIBarButtonItem = UIBarButtonItem(title: "Retornar", style: UIBarButtonItem.Style.done, target: self, action: myAction)
        
        //gera variável com os itens no botão
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    // variáveis globais
    // posição da página
    var pagina = 0
    // array de produtos
    var infoProduto:[Produto] = []
    // posição de seleção do picker
    var selectRow:Int? = 0
    
    //Outlets
    @IBOutlet var viewResultado: UIView!
    @IBOutlet var labelTopo: UILabel!
    @IBOutlet var pickerProduto: UIPickerView!
    @IBOutlet var iconConsDiario: UIImageView!
    @IBOutlet var iconDespensa: UIImageView!
    @IBOutlet var labelPeriodoUm: UILabel!
    @IBOutlet var labelPeriodoDois: UILabel!
    @IBOutlet var labelDespensa: UILabel!
    @IBOutlet var labelConsDiario: UILabel!
    @IBOutlet var labelUniDespensa: UILabel!
    @IBOutlet var labelUniConsDiario: UILabel!
    @IBOutlet var labelBoatao: UILabel!
    @IBOutlet var textConsumoDiario: UITextField!
    @IBOutlet var textDespensa: UITextField!
    @IBOutlet var textPeriodo: UITextField!
    @IBOutlet var iconProduto: UIImageView!
    @IBOutlet var labelProduto: UILabel!
    @IBOutlet var labelConsumoFinal: UILabel!
    @IBOutlet var labelDespensaFinal: UILabel!
    @IBOutlet var labelDuracaoFinal: UILabel!
    @IBOutlet var labelQuantConsumo: UILabel!
    @IBOutlet var labelQuantDespensa: UILabel!
    @IBOutlet var labelQuantDuracao: UILabel!
    @IBOutlet var labelUniConsumoFinal: UILabel!
    @IBOutlet var labelUniDespensaFinal: UILabel!
    @IBOutlet var labelUniDuracaoFinal: UILabel!
    @IBOutlet var labelComprar: UILabel!
    @IBOutlet var labelQuantComprar: UILabel!
    @IBOutlet var labelUniComprar: UILabel!
    
    //Action do botão
    @IBAction func Botao() {
        //garantir que os textFields estão preenchidos
        if textConsumoDiario.text == "" || textPeriodo.text == "" || textDespensa.text == "" {
            //acionar alerta
            alertaPreenchimento()
        } else {
            escondecomponentes()
            exibeResultados()
            if pagina == 0 {
                //let unidades = String(calcularDuracao())
                //labelUniDespensa.text = unidades
                //labelUniConsDiario.text = unidades
                pagina = 1
            }
            else {
                apagarTextFields()
                pagina = 0
            }
        }
    }
    
    // Ação de toque na tela baixa o teclado
    @IBAction func tocarTela(_ sender: Any) {
        self.textConsumoDiario.resignFirstResponder()
        self.textDespensa.resignFirstResponder()
        self.textPeriodo.resignFirstResponder()
    }
    
    //Inicialização do string de produtos
    func inicializarString (){
        let nomesProdutos = ["Leite Integral", "Feijão Preto", "Ovo Branco", "Arroz Branco"]
        let unisCD = ["copos", "gramas", "unidades", "gramas"]
        let unisDes = ["litros", "quilos", "unidades", "quilos"]
        let taxasConv:[Double] = [0.2, 0.001, 1, 0.001]
        let fotinhas:[UIImage] = [UIImage(named: "leite")!, UIImage(named: "feijaopreto")!, UIImage(named: "ovobranco")!, UIImage(named: "arrozbranco")!]
        
        // Loop para apender os itens no array
        var i = 0
        while i <= nomesProdutos.count - 1 {
            let passaDados: Produto = Produto(nomeProduto: nomesProdutos[i], uniConsD: unisCD[i], uniDesp: unisDes[i], taxaConv: taxasConv[i], imgIcon: fotinhas[i])
            infoProduto.append(passaDados)
            i = i + 1
        }
    }
    
    // Número de colunas no picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Número de itens no picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.infoProduto.count
    }
    
    //Adicionando itens do array para os itens do picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return infoProduto[row].nomeProduto
    }
    
    //Garantindo a troca das labels de unidades na interface ao selecionar um item no picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectRow = row
        trocarUnidades()
    }
    
    //Função para a troca de unidades nas labels
    func trocarUnidades(){
        //Mudar labels de unidades de acordo com o o item no picker
        labelUniConsDiario.text = infoProduto[selectRow!].uniConsD
        labelUniDespensa.text = infoProduto[selectRow!].uniDesp
    }
    
    //Função para gerar o alerta de não preenchimento
    func alertaPreenchimento(){
        //gera mensagem de alerta
        let alerta = UIAlertController(title: "Atenção!", message: "Preencha todos os campos", preferredStyle: UIAlertController.Style.alert)
        //gera o botão pra tirar o alerta
        let botaoOk = UIAlertAction(title: "Confirmar", style: UIAlertAction.Style.default) {
            (UIAlertAction) in
        }
        alerta.addAction(botaoOk)
        
        self.present(alerta, animated: true, completion: nil)
    }
    
    // Cálculo para a duração dos produtos
    func calcularDuracao() -> Double{
        //Lê text field consumodiário
        let consumoDiario = textConsumoDiario.text!
        //lê text field despensa
        let despensa = textDespensa.text!
        //transformar o texto em Int
        let consumoDiarioDouble = Double(consumoDiario)!
        let despensaDouble = Double(despensa)!
        //culcular duracao = despensa / consumodiario
        let taxaDuracao = infoProduto[selectRow!].taxaConv
        let consumoDiarioLitro: Double = consumoDiarioDouble * taxaDuracao
        let duracao = despensaDouble / consumoDiarioLitro
        return duracao
    }
    
    //Cálculo para a quantidade de compra
    func calcularCompra() -> Double{
        //Lê text field consumodiario
        let consumoDiario = textConsumoDiario.text!
        //Lê text field despensa
        let despensa = textDespensa.text!
        //Lê text field distanciadias
        let dias = textPeriodo.text!
        //transformar o texto em Double
        let consumoDiarioDouble = Double(consumoDiario)!
        let despensaDouble = Double(despensa)!
        let diasDouble = Double(dias)!
        //calcular consumototal = consumo x dias
        let taxaCompra = infoProduto[selectRow!].taxaConv
        let consTotalml = consumoDiarioDouble * diasDouble
        let consTotalLitros = consTotalml * taxaCompra
        //calcular compra = consumototal - despensa
        var compra = consTotalLitros - despensaDouble
        compra = round(compra)
        if compra < 0 {
            compra = 0
        }
        return compra
    }
    
    // Esconder as view
    func escondecomponentes(){
        //Esconde todos os itens da página menos o botão calcular
        if pagina == 1 {
            //Exibe o ícone do produto
            //Exibe label com nome do produto
            //Exibe despensa, consumo, duração, distância entre compras e quantidade para comprar
            viewResultado.isHidden = true
        }
    }
    
    // Exibir as views e mostrar os resultados
    func exibeResultados(){
        if pagina == 0 {
            //Exibe o ícone do produto
            //Exibe label com nome do produto
            //Exibe despensa, consumo, duração, distância entre compras e quantidade para comprar
            viewResultado.isHidden = false
            //muda labels página final
            labelUniConsumoFinal.text = infoProduto[selectRow!].uniConsD
            labelUniDespensaFinal.text = infoProduto[selectRow!].uniDesp
            labelUniComprar.text = infoProduto[selectRow!].uniDesp
            labelProduto.text = infoProduto[selectRow!].nomeProduto
            labelQuantConsumo.text = textConsumoDiario.text!
            labelQuantDespensa.text = textDespensa.text!
            labelQuantDuracao.text = String(format:"%.1f",calcularDuracao())
            labelQuantComprar.text = String(format:"%.0f",calcularCompra())
            labelBoatao.text = "Retornar"
            iconProduto.image = infoProduto[selectRow!].imgIcon
        }
        else {
            labelBoatao.text = "Calcular"
        }
    }
    
    func apagarTextFields(){
        if pagina == 1 {
            self.textConsumoDiario.text = nil
            self.textDespensa.text = nil
            self.textPeriodo.text = nil        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inicializarString ()
        //textConsumoDiario.becomeFirstResponder()
        viewResultado.isHidden = true
        pickerProduto.delegate = self
        
        self.textConsumoDiario.delegate = self
        self.textDespensa.delegate = self
        self.textPeriodo.delegate = self
        textConsumoDiario.addDoneButtonToKeyboard(myAction:  #selector(self.textConsumoDiario.resignFirstResponder))
        textPeriodo.addDoneButtonToKeyboard(myAction:  #selector(self.textPeriodo.resignFirstResponder))
        textDespensa.addDoneButtonToKeyboard(myAction:  #selector(self.textDespensa.resignFirstResponder))
    }
}


//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }

//para definir mais de um toque de botão
//@IBOutlet var botaoMedio: UIButton!
//@IBOutlet var botaoGrande: UIButton!
//
//@IBAction func tocouBotao(_ sender: UIButton){
//  if sender == botaoMedio{
//      print("Tocou botão médio")_}
//  else if sender == botaoGrande {
//      print("Tocou no botao grande")}
//  else {
//      print("Tocou no botao pequeno")}

