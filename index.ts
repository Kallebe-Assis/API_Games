import express from 'express';
import cors from 'cors';
import { Request, Response } from 'express';
import { jogos } from './jogos';
import { categorias } from './categorias';
import * as dotenv from 'dotenv';
import mysql from 'mysql2';
import fs from 'fs';

const sqlScript = fs.readFileSync('./src/database/APIJogoTrabalhoBack.sql', 'utf8');

dotenv.config(); //Configuração do .env

//Comecin do express  (linhas magicas);
const app = express();
app.use(express.json());
app.use(cors());

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'seu_usuario',
    password: 'sua_senha',
    database: 'seu_banco_de_dados',
  });

const port = process.env.PORT || 3003;
//Dados de jogos pra testar
// const jogos = [
//     { nome: 'The Witcher 3', anoLancamento: 2015, descricao: 'Um RPG com missão secundária pra krl', idadeMinima: '25' },
//     { nome: 'Elden Ring', anoLancamento: 2022, descricao: 'Um RPG melhor q o de cima', idadeMinima: '1' },
//   ]; 


//-------------------------------------Endpoints GET:
// app.get('/', (req, res) => {
//     res.send('Hello World!')
// })

app.get('/categoria/:id', (req: Request, res: Response) => {
    try{
        const idCategoriaBuscado = req.params.id;
        
        if(idCategoriaBuscado && typeof idCategoriaBuscado === 'number' && idCategoriaBuscado >= 1){
            const buscaCategoria = categorias.filter (categoria => categoria.id === idCategoriaBuscado);
            res.send(buscaCategoria)
        }else{
            res.send("O ID passado não é válido")
        }

        if(!idCategoriaBuscado){
            res.status(401);
            throw new Error("Campo")
        }
    }catch(error:any){
        const message= error.sqlMessage || error.message
        res.send(message)
    }

})

// GET que busca o categoria com possibilidade de filtro por QUERY
app.get('/categoria', (req, res) => {
    const { nome, pag = 1, limite = 3} = req.query

    const pagNumber = Number(pag);
    const limiteNumber = Number(limite);

    let categoriaFiltrados = categorias;

    if (nome) { //Caso for passado um nome por QUERY
        categoriaFiltrados = categoriaFiltrados.filter(categoria =>
            categoria.nome.toLowerCase().includes((nome as string).toLowerCase())
        );
    }

    const startIndex = (pagNumber - 1) * limiteNumber;
    const endIndex = startIndex + limiteNumber;
    const categoriaPaginados = categoriaFiltrados.slice(startIndex, endIndex);

    res.json({
        total: categoriaFiltrados.length,
        pagina: pagNumber,
        limite: limiteNumber,
        categorias: categoriaPaginados
    });

})


// GET que busca o jogos com possibilidade de filtro por QUERY
app.get('/jogos', (req, res) => {
    const { nome, anoLancamento, idadeMinima, pag = 1, limite = 3} = req.query

    const pagNumber = Number(pag);
    const limiteNumber = Number(limite);

    let jogosFiltrados = jogos;

    if (nome) { //Caso for passado um nome por QUERY
        jogosFiltrados = jogosFiltrados.filter(jogo =>
            jogo.nome.toLowerCase().includes((nome as string).toLowerCase())
        );
    }

    if (anoLancamento) { //Caso for passado um ano_lancamento por QUERY
        jogosFiltrados = jogosFiltrados.filter(jogo =>
            jogo.anoLancamento === Number(anoLancamento)
        );
    }

    if (idadeMinima) { //Caso for passado uma idade por QUERY
        jogosFiltrados = jogosFiltrados.filter(jogo =>
            jogo.idadeMinima === Number(idadeMinima)
        );
    }

    const startIndex = (pagNumber - 1) * limiteNumber;
    const endIndex = startIndex + limiteNumber;
    const jogosPaginados = jogosFiltrados.slice(startIndex, endIndex);

    res.json({
        total: jogosFiltrados.length,
        pagina: pagNumber,
        limite: limiteNumber,
        jogos: jogosPaginados
    });

})

app.get('/jogos/:id', (req: Request, res: Response) => {
    const idJogoBuscado = Number(req.params.id);
    const buscaJogo = jogos.filter (jogo => jogo.id === idJogoBuscado);

    res.send(buscaJogo)

    console.log(`idJogoBuscado = ${idJogoBuscado}`);
});



//-------------------------------------Endpoints POST:

// Criando um novo jogo
app.post('/jogo', (req: Request, res: Response) => {
    const novoJogo = req.body;

    // Verificação se foi passado todos os dados
    if (!novoJogo.nome || !novoJogo.anoLancamento || !novoJogo.descricao || !novoJogo.idadeMinima) {
        res.status(400).json({ message: "Neccessário informar todos os dados para adicionar um novo jogo" });
    } else {
        jogos.push(novoJogo)

        res.status(201).json({
            message: "Jogo Adicionado com Sucesso",
            jogo: novoJogo
        });
    }
});



//Executando o Server
app.listen(port, () => {
    console.log(`Server is running in http://localhost:${port}`);
})


