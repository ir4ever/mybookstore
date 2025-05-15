Regras da aplicação:
O MyBookStore é um app para o controle de catálogo de livros disponíveis em uma determinada livraria.

Haverão dois perfis de usuários com acesso ao aplicativo: ADMIN e EMPLOYEE.

ADMIN: Será o responsável por criar a loja, cadastrar e editar os livros disponíveis. Assim como também criar e editar novos usuários que serão os funcionários de sua loja. O admin poderá fazer tudo que um employee também pode.
EMPLOYEE: Como funcionário, poderá logar na aplicação e visualizar o catálogo de livros disponíveis, através dos filtros. Também poderá alterar o status de um livro entre "EM ESTOQUE" e "SEM ESTOQUE".
Tela de Login:
Tela inicial da aplicação. A senha de usuário deve seguir as regras:

Mais de 6 caracteres
Menos de 10 caracteres
Pelo menos 1 letra maiúscula
Pelo menos um caracter especial
Home:
Contém a listagem de todos os livros disponíveis na loja do usuário, podendo buscar/filtrar os livros.

Tela do livro:
Ao clicar em um livro, o usuário é levado para a tela de detalhes daquele livro.

ADMIN: Pode editar o livro EMPLOYEE: Pode apenas alterar entre "EM ESTOQUE" e "SEM ESTOQUE"

Cada acesso ao livro deve ser registrado como um evento no analytics do firebase, contendo os dados:

nome: click_book
parametros:
id:${id_livro}
title:${titulo_livro}

Cadastro do livro:
Usuários ADMIN terão acesso ao menu "Livros", onde é possível fazer o cadastro de novos livros para a loja.

Cadastro funcionários:
Usuários ADMIN terão acesso ao menu "Funcionários", onde ele pode visualizar, cadastrar ou editar funcionários de sua loja. Esses funcionários poderão acessar o app como EMPLOYEE.

Tela meu perfil:
Tela que mostrará os dados do usuário logado e também os dados da loja desse usuário, incluindo o banner previamente cadastrado. Usuários ADMIN podem editar seus dados e os dados da loja, enquanto EMPLOYEE apenas visualizam as informações.

API:
Todos os Endpoints, com exceção do POST: v1/store e POST: v1/auth são protegidos. É necessário informar no header o token:

Authorization: Bearer {token}
POST v1/store:
Campos:

{
"name": "Minha Lojinha",
"slogan": "A melhor lojinha do sul do mundo!",
"banner": "imageBase64",
"admin": {
"name": "Julio Bitencourt",
"photo": "imageBase64",
"username": "julio.bitencourt",
"password": "8ec4sJ7dx!*d"
}
}
Retorno

{
"refreshToken": "eyJ0eXAiOiJKV1QiL..",
"store": {
"banner": "imageBase64",
"id": 1,
"name": "Minha Lojinha",
"slogan": "A melhor lojinha do sul do mundo!"
},
"token": "eyJ0eXAiOiJKV1...",
"user": {
"id": 1,
"name": "Julio Bitencourt",
"photo": "imageBase64",
"role": "Admin"
}
}
POST v1/auth:
Campos

{
"user": "julio.bitencourt",
"password": "8ec4sJ7dx!*d"
}
Retorno

{
"refreshToken": "eyJ0eXAiOiJKV1QiL..",
"store": {
"banner": "imageBase64",
"id": 1,
"name": "Minha Lojinha",
"slogan": "A melhor lojinha do sul do mundo!"
},
"token": "eyJ0eXAiOiJKV1...",
"user": {
"id": 1,
"name": "Julio Bitencourt",
"photo": "imageBase64",
"role": "Admin"
}
}
POST v1/auth/validateToken:
Campos

{
"refreshToken": "eyJ0eXAiOiJ..."
}
Retorno

{
"refreshToken": "eyJ0eXAiOiJK...",
"token": "eyJ0eXAiOiJKV1..."
}
GET /v1/store/1:
Retorno

{
"banner": "imageBase64",
"idStore": 1,
"name": "Minha Lojinha",
"slogan": "A melhor lojinha do sul do mundo!"
}
PUT /v1/store/1:
Campos

{
"name": "Minha Lojinha Massaaa",
"slogan": "A melhor lojinha do sul do mundo! E do país",
"banner": "imageBase64444"
}
POST /v1/store/1/employee:
Campos

{
"name": "Fulaninho",
"photo": "imageBase64",
"username": "ful.aninho",
"password": "8ec4sJ7dx!*d"
}
GET /v1/store/1/employee:
Retorno:

[
{
"id": 2,
"name": "Fulaninho",
"photo": "imageBase64",
"username": "ful.aninho"
},
{
"id": 3,
"name": "Ciclaninho",
"photo": "imageBase64",
"username": "cic.laninho"
}
]
PUT /v1/store/1/employee/4: Campos
{
"name": "Ciclaninho",
"photo": "imageBase64",
"username": "cic.laninho",
"password": "8ec4sJ7dx!*d"
}
DELETE /v1/store/1/employee/4:

POST /v1/store/1/book

Campos:

{
"cover": "imageBase64",
"title": "O guia de Dart",
"author": "Julio Henrique Bitencourt",
"synopsis": "...",
"year": 2022,
"rating": 5,
"available": false
}
PUT /v1/store/1/book/1
Campos:

{
"cover": "imageBase64",
"title": "O guia de Dart",
"author": "Julio Henrique Bitencourt",
"synopsis": "O MELHOR LIVRO DE DART",
"year": 2022,
"rating": 5,
"available": false
}
GET /v1/store/1/book/1

DELETE /v1/store/1/book/1

SEARCH v1/store/1/book?limit=20&offset=0&author=Julio%20Bitencourt&title=O%20guia&year-start=2020&year-finish=2023&rating=5&available=true

Filtros:

limit
offset
author
title
year-start
year-finish
rating
available