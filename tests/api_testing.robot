*** Settings ***
Resource    ../resources/api_testing.resource

*** Variables ***

*** Test Cases ***
Cenário 01: Cadastrar um novo produto com sucesso na MyStore
    Cadastrar novo produto    status_code_desejado=201
    Conferir se o novo produto foi cadastrado com sucesso

Cenário 02: Cadastrar um novo produto sem valor
    Cadastrar novo produto sem valor    status_code_desejado=400
    Verificar se a API não permitiu o cadastro com valor negativo    

Cenário 03: Consultar produto
    Cadastrar novo produto    status_code_desejado=201
    Consultar os dados do novo produto
    Conferir os dados retornados

Cenário 04: Consultar produto inexistente
    Consultar produto com ID invalido
    Validar mensagem de ID invalido

Cenário 05: Consultar lista de produtos
       Consultar lista de produtos 
       Validar lista

Cenário 06: Consultar lista de categorias
    Consultar lista de categorias
    Validar lista de categorias

Cenário 07: Consultar lista com categoria inexistente
    Consultar lista de categorias
    Validar categoria inexistente

Cenário 08: Validar produtos na categoria suplementos
    Efetuar busca por produtos na categoria suplementos utilizando o limite 2
    Validar itens da lista
    
Cenário 09: Deletar produto da MyStore
    Cadastrar novo produto    status_code_desejado=201
    Conferir se o novo produto foi cadastrado com sucesso
    Deletar produto

Cenário 10: Deletar produto inexistente da MyStore
    Deletar produto com ID invalido
    Validar mensagem informando ID invalido
