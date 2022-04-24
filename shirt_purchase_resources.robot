*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary

*** Variables ***
${URL}        http://automationpractice.com/index.php
${BROWSER}    chrome

*** Keywords ***

Abrir Navegador
    Open Browser  browser=${BROWSER}  
    Maximize Browser Window

Fechar Navegador
    Close Browser

Abrir homepage
    Go to    url=${URL} 
    Wait Until Element Is Visible        xpath=//*[@id="block_top_menu"]/ul[1]/li[3]/a[1]

Entrar na aba T-shirts
    Click Element                        xpath=//*[@id="block_top_menu"]/ul[1]/li[3]/a[1]
    Wait Until Element Is Visible        xpath=//*[@id="center_column"]/div[1]/div[1]
    Scroll Element Into View             xpath=//*[@id="center_column"]/ul[1]/li[1]/div[1]/div[2]/span[1]/span[1]
    Sleep                                1

Adicionar o produto no carrinho
    Mouse Over                           xpath=//*[@id="center_column"]/ul[1]/li[1]/div[1]/div[1]/div[1]/a[1]/img[1]
    Wait Until Element Is Visible        xpath=//*[@id="center_column"]/ul[1]/li[1]/div[1]/div[2]/div[2]/a[1]/span[1]
    Click Element                        xpath=//*[@id="center_column"]/ul[1]/li[1]/div[1]/div[2]/div[2]/a[1]/span[1]
    Wait Until Element Is Visible        xpath=//*[@id="layer_cart"]/div[1]/div[2]/div[4]/a[1]/span[1]

Iniciar processo de compra
    ${EMAIL}      FakerLibrary.Email
    Click Element                        xpath=//*[@id="layer_cart"]/div[1]/div[2]/div[4]/a[1]/span[1]
    Scroll Element Into View             xpath=//*[@id="social_block"]/h4[1]  
    Click Element                        xpath=//*[@id="center_column"]/p[2]/a[1]/span[1]
    Input Text                           name=email_create          ${EMAIL}
    Click Element                        xpath=//*[@id="SubmitCreate"]/span[1]
    Wait Until Element Is Visible        xpath=//*[@id="account-creation_form"]/div[1]/h3[1]

Cadastro de Dados
    ${F_NAME}     FakerLibrary.First Name Female
    ${L_NAME}     FakerLibrary.Last Name Female
    ${PASSWORD}   FakerLibrary.Password    length=6
    ${COMPANY}    FakerLibrary.Company
    ${ADRESS}     FakerLibrary.Street Address
    ${CITY}       FakerLibrary.City
    ${STATE}      FakerLibrary.State
    ${COUNTRY}    FakerLibrary.Country
    ${CEP}        FakerLibrary.Zipcode
    ${PHONE}      FakerLibrary.Random Int     min=1000000000    max=9999999999
    ${PHONE_MOB}  FakerLibrary.Random Int     min=1000000000    max=9999999999
    ${random1}     FakerLibrary.Random Int    min=0   max=27 
    ${random2}     FakerLibrary.Random Int    min=1   max=11 
    ${random3}     FakerLibrary.Random Int    min=17   max=66
    ${random4}     FakerLibrary.Random Int    min=0   max=49 
    ${TEXT}       FakerLibrary.Text           max_nb_chars=200
    Select Radio Button                  id_gender             2
    Input Text                           name=customer_firstname    ${F_NAME}
    Input Text                           name=customer_lastname     ${L_NAME}
    Input Text                           name=passwd                ${PASSWORD}
    Select From List By Index            name=days                  ${random1}
    Select From List By Index            name=months                ${random2}
    Select From List By Index            name=years                 ${random3}
    Select Checkbox                      name=newsletter   
    Select Checkbox                      name=optin
    Input Text                           name=firstname             ${F_NAME}
    Input Text                           name=lastname              ${L_NAME}
    Input Text                           name=company               ${COMPANY}
    Input Text                           name=address1              ${ADRESS}
    Input Text                           name=address2              Building
    Input Text                           name=city                  ${CITY}
    Select From List By Index            name=id_state              ${random4}
    Input Text                           name=postcode              ${CEP}
    Select From List By Index            name=id_country            1
    Input Text                           name=other                 ${TEXT}
    Input Text                           name=phone                 ${PHONE}
    Input Text                           name=phone_mobile          ${PHONE_MOB}
    Input Text                           name=alias                 My Home
    Click Element                        xpath=//*[@id="submitAccount"]/span[1]
    Wait Until Element Is Visible        xpath=//*[@id="center_column"]/form[1]/p[1]/button[1]/span[1]

Detalhes de frete
    Click Element                        xpath=//*[@id="center_column"]/form[1]/p[1]/button[1]/span[1]
    Select Checkbox                      name=cgv
    Click Element                        xpath=//*[@id="form"]/p[1]/button[1]/span[1]
    Wait Until Element Is Visible        xpath=//*[@id="HOOK_PAYMENT"]/div[1]/div[1]/p[1]/a[1]/span[1]
    
Detalhes de pagamento
    Scroll Element Into View             xpath=//*[@id="newsletter_block_left"]/div[1]/form[1]/div[1]
    Click Element                        xpath=//*[@id="HOOK_PAYMENT"]/div[1]/div[1]/p[1]/a[1]/span[1]
    Wait Until Element Is Visible        xpath=//*[@id="cart_navigation"]/button[1]/span[1]

Finalização
       Click Element                     xpath=//*[@id="cart_navigation"]/button[1]/span[1]
       Wait Until Element Is Visible     xpath=//*[@id="center_column"]/p[1]/a[1]

Download do recibo
    Click Element                        xpath=//*[@id="center_column"]/p[1]/a[1]
    Wait Until Element Is Visible        xpath=//*[@id="order-list"]/tbody[1]/tr[1]/td[6]
    Click Element                        xpath=//*[@id="order-list"]/tbody[1]/tr[1]/td[6]
    Sleep                                10

#GHERKIN-STEPS

Dado que estou na home page da Automationpractice.com
    Abrir homepage

Quando acessar o menu "T-Shirts"
    Entrar na aba T-shirts

E adicionar um produto ao carrinho
    Adicionar o produto no carrinho
    Iniciar processo de compra

E preencher os dados de cadastros com credenciais válidas 
    Cadastro de Dados

E confirmo os termos de frete e pagamento
    Detalhes de frete
    Detalhes de pagamento

Então meu pedido deve estar homologado
    Finalização
    Download do recibo