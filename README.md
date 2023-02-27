
# PROJETO PARA TESTE API

Projeto desenvolvido com proposito de testar API MyStore


## PRÉ-REQUISITOS

Requisitos de software e hardware necessários para executar este projeto de automação.

*   Python-3.11.*
*   Robot Framework
* Libraries
  * HTTP RequestsLibrary (Python)

*   Visual Studio Code
*   Plugins do Visual Studio Code
        
        * Robot Framework Language Server
        * Python
    
## Testes escritos/escolhidos

- Retorna todos os itens    ```GET Products```
- Retorna um item   ```GET Products```
- Cria um item    ```POST Product```
- Deleta um item    ```  Delete Product ```
- Retorna todas as categorias   ``` Get Categories ```
- Retorna produto por categorias  ``` Get Products in Category ```
 
## Rodando os testes

Para rodar os testes, rode o seguinte comando:

```bash
  robot -d ./results tests/api_testing.robot
```


## Links

[Evidências de execução de testes](https://drive.google.com/drive/folders/13dWxFoqmVFFxmo0L20KlqLamHpACdsSZ?usp=sharing)

