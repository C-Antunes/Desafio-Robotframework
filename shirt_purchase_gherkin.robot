*** Settings ***
Documentation     Essa suite realiza um processo de compra no site http://automationpractice.com/index.php
Resource          shirt_purchase_resources.robot
Test Setup        Abrir Navegador
Test Teardown     Fechar Navegador

*** Test Cases ***
Cenário: Realizar uma compra com sucesso
    [Documentation]     Esse teste realiza a compra de uma camisa no site http://automationpractice.com/index.php 
    Dado que estou na home page da Automationpractice.com
    Quando acessar o menu "T-Shirts"
    E adicionar um produto ao carrinho
    E preencher os dados de cadastros com credenciais válidas 
    E confirmo os termos de frete e pagamento
    Então meu pedido deve estar homologado

