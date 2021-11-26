<br />

  <h3 align="center">Gerador de CRUD para stack web ASP .NET Core, Angular e MSSQL SERVER</h3>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Conteúdo</summary>
  <ol>
    <li>
      <a href="#sobre-o-projeto">Sobre o projeto</a>
    </li>
    <li>
      <a href="#Quais as vantagens/desvantagens de usar a DSL proposta?">Quais as vantagens/desvantagens de usar a DSL proposta?</a>
    </li>
    <li><a href="#Configurando o ambiente">Configurando o ambiente</a></li>
    <li><a href="#Exemplo prático de utilização">Exemplo prático de utilização</a></li>
    <li><a href="#Gramática">Gramática</a></li>
    <li><a href="#Validações da linguagem">Validações da linguagem</a></li>
    <li><a href="#Referências">Referências</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## Sobre o Projeto

Principalmente para novos desenvolvedores no TCE/RN, a simples implementação de um CRUD pode demorar mais que o esperado. Isso pode ocorrer devido à curva de aprendizado nas tecnologias utilizadas, assim como pela arquitetura específica do tribunal.

Para isso, essa DSL visa ser uma aplicação geradora de CRUDs, onde os arquivos (scripts SQL, classe C# da API e .ts do Angular) com operações básicas de CRUD (create, read, update e delete) serão automaticamente gerados com base nas entidades definidas na DSL.

Com essa linguagem específica de domínio, será possível aumentar a produtividade dos desenvolvedores  do TCE. Ao fazer com que o foco maior seja na implementação das regras de negócio, ao invés da repetição de criação de código “básico”, além de garantir uma maior padronização.

## Quais as vantagens/desvantagens de usar a DSL proposta?

### Vantagens
* Otimização do tempo de desenvolvimento.
* Diminuição de repetição de tarefas.
* Padronização de código.

### Desvantagens
* Para CRUDs mais complexos será necessário adaptar o código para atender a demanda.
* Estrutura rígida, ao invés de flexibilidade (DSL específica para a stack do TCE/RN com a arquitetura de lá).


<!-- GETTING STARTED -->
## Configurando o ambiente

Baixe e intale o eclipse com o Xtext [link](https://projects.eclipse.org/projects/modeling.tmf.xtext/downloads).


## Exemplo prático de utilização

A sintaxe da linguagem se assemelha muito a linguagens de programação como Java ou C#.

Nela, podem ser definidas entidades e seus atributos. Assim como suas relações de herança.

   ```java
    entity Pessoa {
        string nome;
        string cpf;
    }

    entity Aluno extends Pessoa {
        string matricula;
        string teste;
    }
   ```

Nesse exemplo de código acima, se não houver algum erro de sintaxe, os arquivos referentes a stack de desenvolvimento web, serão automaticamente gerados.

![alt text](/images/arquivos-gerados.png)

## Gramática

A gramática da linguagem está definida no arquivo [MyDsl.xtext](/src/org/xtext/example/mydsl/MyDsl.xtext).

Ela consiste de nenhum ou várias entidades:

   ```java
    Model: entities += Entity*;
   ```
Cada entidade deve ser definida iniciando com a palavra **entity** e um nome. Seguida, opcionalmente, de um definição de herança de outra entidade. E seus atributos (que também são opcionais) entre chaves **{}**

   ```java
    Entity:
        'entity' name = ID ('extends' superType=[Entity])? '{'
            attributes += Attribute*
        '}'
    ;
   ```

Cada atributo precisa ter um tipo e um nome seguido de **;**

   ```java
    Attribute:
	    type=AttributeType name=ID ';';
   ```

Cada tipo de atributo pode ser de tipos básicos ou outra entidade:

   ```java
    ElementType:
	    BasicType | EntityType;

    BasicType:
	    typeName=('string'|'int'|'boolean');

    EntityType:
	    entity=[Entity];
   ```


## Validações da linguagem

Existem algumas validações da sintaxe da linguagem. Entre elas estão:

* Não permitir referência cíclila

   ```java
    entity Aluno extends Pessoa {}
    entity Bacharel extends Aluno {}
    entity Pessoa extends Aluno {}
   ```

* Não permitir duplicação de entidades (entidades com mesmo nome)

   ```java
    entity Pessoa {}
    entity Pessoa {}    
   ```

## Referências

Esta linguagem foi fortemente baseada em uma descrita no livro [Implementing Domain Specific Languages with Xtext and Xtend](https://www.amazon.com.br/Implementing-Domain-Specific-Languages-Xtext-Xtend-ebook/dp/B01CSLI6HM).



