// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaCostaMarfil
 * @dev Registro de procesos de fermentacion de yuca y maduracion de frutos.
 * Serie: Sabores de Africa (13/54)
 */
contract CulturaCostaMarfil {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 nivelAcidez;      // Escala de fermentacion del Attieke (1-10)
        uint256 maduracionPlatano; // Nivel de azucar para Alloco (1-5)
        bool usaSalsaClair;       // Salsa tipica de pescado/vegetales
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Garba (Attieke con Pescado)
        registrarPlato(
            "Garba", 
            "Attieke (semola de yuca), atun frito, chiles, cebolla, aceite.",
            "Servir la semola de yuca fermentada con el pescado frito y abundante aceite de fritura.",
            7, 
            0, 
            false
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _acidez, 
        uint256 _maduracion,
        bool _salsa
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_acidez <= 10, "Escala acidez: 1 a 10");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            nivelAcidez: _acidez,
            maduracionPlatano: _maduracion,
            usaSalsaClair: _salsa,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 acidez,
        uint256 maduracion,
        bool salsa,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.nivelAcidez, p.maduracionPlatano, p.usaSalsaClair, p.likes);
    }
}
