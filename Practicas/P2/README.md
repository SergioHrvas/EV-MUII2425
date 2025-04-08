# Práctica 2 -  

- Autor: Sergio Hervás Cobo 
- Asignatura: Entornos Virtuales - Master Universitario en Ingeniería Informática en la Universidad ee Granada

## Estructura del proyecto
Dos escenas principales:


Dos modelos principales:
- **gancho.blender**: Modelo de un gancho. Este contiene tres operaciones de modelado:
    - Revolución (nodo BaseRev)
    - Solevado con los siguientes nodos:
        - Gancho: Curva sobre la que se hará el solevado.
        - GanchoForma: Círculo con la que se dibujará el solevado. En mi caso lo transformé en un hexágono tal y como está en el videojuego original.
    - Booleano de unión entre los dos nodos anteriores

- **santuario(c).tscn**: Escena del ejercicio C. Se trata de dos habitaciones y un pasillo. Contiene las siguientes escenas:
    - habitacion1.tscn
        - gancho.tscn
        - bola.tscn
        - silla.tscn
        - plataforma.tscn
        - palanca.tscn
    - habitacion2.tscn
        - escalera.tscn
        - cofre.tscn

