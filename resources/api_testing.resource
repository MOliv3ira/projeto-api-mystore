*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections 
Library    OperatingSystem  

*** Keywords ***
Cadastrar novo produto
    [Arguments]    ${status_code_desejado}
    ${body}    Create Dictionary
    ...    name=Vitamina D
    ...    price=10
    ...    manufacturer=Teste
    ...    category=supplements
    ...    description=Teste Produto
    ...    tags=Teste tag
    Log   ${body}

    Criar Sessão na MyStore

    ${resposta}    POST On Session
    ...    alias=MyStore
    ...    url=/product
    ...    json=${body}
    ...    expected_status=${status_code_desejado}
        
    Log    ${resposta.json()}
    Set Test Variable    ${ID_PRODUTO}    ${resposta.json()["id"]}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}

Criar Sessão na MyStore

     ${headers}    Create Dictionary
    ...    content-type=application/json
    ...    X-RapidAPI-Key=3cc96f25d4msha7c28e70327f5a1p130d61jsnaef09068a426
    ...    X-RapidAPI-Host=my-store2.p.rapidapi.com
    Create Session
    ...    alias=MyStore
    ...    url=https://my-store2.p.rapidapi.com/catalog
    ...    headers=${headers}
  
Conferir se o novo produto foi cadastrado com sucesso
   Log    ${RESPOSTA}
   Dictionary Should Contain Key    ${RESPOSTA}    id

Cadastrar novo produto sem valor
   [Arguments]    ${status_code_desejado}
    ${body}    Create Dictionary
    ...    name=Vitamina D
    ...    price=
    ...    manufacturer=Teste
    ...    category=supplements
    ...    description=Teste Produto
    ...    tags=Teste tag
    Log   ${body}

    Criar Sessão na MyStore
   
   ${resposta}    POST On Session
    ...    alias=MyStore
    ...    url=/product
    ...    json=${body}
    ...    expected_status=${status_code_desejado}
        
    Log    ${resposta.json()}
    Set Test Variable    ${RESPOSTA}    ${resposta.json()}
    

Verificar se a API não permitiu o cadastro com valor negativo
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Unexpected token , in JSON at position 29  
   
Consultar os dados do novo produto
    ${resposta_consulta}    GET On Session    alias=MyStore    url=/product/${ID_PRODUTO}
    Set Test Variable    ${RESP_CONSULTA}    ${resposta_consulta.json()}

Conferir os dados retornados

    Log    ${RESP_CONSULTA} 
    Dictionary Should Contain Item    ${RESP_CONSULTA}    id              ${ID_PRODUTO}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    name            Vitamina D
    Dictionary Should Contain Item    ${RESP_CONSULTA}    description     Teste Produto
    Dictionary Should Contain Item    ${RESP_CONSULTA}    manufacturer    Teste
    Dictionary Should Contain Item    ${RESP_CONSULTA}    category        supplements
    Dictionary Should Contain Key     ${RESP_CONSULTA}    price           10
    Dictionary Should Contain Item    ${RESP_CONSULTA}    tags            Teste tag


Consultar produto com ID invalido
  ${resposta_invalida}   GET on Session     alias=MyStore    url=/product/0000    expected_status=404
  Set Test Variable    ${RESP_INVALIDA}    ${resposta_invalida.json()}

Validar mensagem de ID invalido
    Log    ${RESP_INVALIDA}
    Dictionary Should Contain Item    ${RESP_INVALIDA}   message    Product with ID 0000 not found

Consultar lista de produtos 
  ${get_response}    GET On Session
  ...    alias=MyStore
  ...    url=/products
  ...    expected_status=200
   Set Test Variable  ${get_all}     ${get_response.json()}

Validar lista
    Log    ${get_all}
    Dictionary Should Contain Key    ${get_all['products'][0]}    id    20773


Consultar lista de categorias
    ${get_categories}    GET On Session
  ...    alias=MyStore
  ...    url=/categories
  ...    expected_status=200
   Set Test Variable  ${get_all_categories}     ${get_categories.json()}
Validar lista de categorias
    Log    ${get_all_categories}     

Validar categoria inexistente 
    Log    ${get_all_categories}    
    Dictionary Should Not Contain Key    ${get_all_categories}    geleia da shakira

Efetuar busca por produtos na categoria suplementos utilizando o limite 2
      
    ${get_productsInCategory}    GET On Session
    ...    alias=MyStore
    ...    url=/category/supplements/products?skip=0&limit=2
    ...    expected_status=200

   Set Test Variable  ${get_all_productIncategory}     ${get_productsInCategory.json()}

Validar itens da lista
    Log    ${get_all_productIncategory}
    Dictionary Should Contain Key    ${get_all_productIncategory['products'][0]}   id      23647
    Dictionary Should Contain Key    ${get_all_productIncategory['products'][1]}   id      23654

Deletar produto
     ${delete_product}    DELETE On Session
    ...    alias=MyStore
    ...    url=/product/${ID_PRODUTO}
    ...    expected_status=200

   Set Test Variable  ${delete_prod}     ${delete_product.json()}

Deletar produto com ID invalido
    ${resposta_invalida}   DELETE on Session     alias=MyStore    url=/product/0000    expected_status=404
    Set Test Variable    ${RESP_INVALIDA}    ${resposta_invalida.json()}


Validar mensagem informando ID invalido
    Log    ${RESP_INVALIDA}
    Dictionary Should Contain Item    ${RESP_INVALIDA}   message    Product with ID 0000 does not exist