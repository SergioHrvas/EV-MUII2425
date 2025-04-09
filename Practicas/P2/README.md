# Práctica 2 -  

- Autor: Sergio Hervás Cobo 
- Asignatura: Entornos Virtuales - Master Universitario en Ingeniería Informática en la Universidad ee Granada

## Estructura del proyecto

Dos modelos principales:
- **gancho.blender**: Modelo de un gancho. Este contiene tres operaciones de modelado:
    - Revolución (nodo BaseRev)
    - Solevado con los siguientes nodos:
        - Gancho: Curva sobre la que se hará el solevado.
        - GanchoForma: Círculo con la que se dibujará el solevado. En mi caso lo transformé en un hexágono tal y como está en el videojuego original.
    - Booleano de unión entre los dos nodos anteriores

- **cofre.blender**: Modelo del cofre. Tiene dos piezas separadas:
    - **Caja**: Parte inferior del cofre. Es un cubo que tiene varias operaciones booleanas asociadas:
        - **MarcoSup**: Cubo al que se le resta con un modificador booleano el nodo **MarcoSupSust** para dejar un hueco delante. También tiene extrusión de la cara superior. También tiene biselado para amoldar las esquinas.
        - **Refuerzos**: Son las esquinas del cofre. Tiene biselado para darle una forma más definida y dos modificadores de arrays para duplicarlo en cada esquina.
        - **Tornillos**: Son cilindros con tres modificadores arrays: uno para duplicarlo en x, otro en y y otro en z. Tanto para tornillos del frente como para los de los lados.
        - **Cerradura**: Cilindro común
        - **AdornoFlecha**: Adorno lateral realizado con solevado a partir de la curva AdornoFlechaForma. 
        - **CajaInt**: Se resta con modificador booleano para dejar hueco dentro.

    - **Tapadera**: Parte superior del cofre. Es un cilindro con las siguientes operaciones booleanas:
        - **InteriorTapa**: Cubo para eliminar la mitad inferior del cilindro mediante diferencia booleana 
        - **TapaderaSust**: Cilindro de menor tamaño para dejar un hueco en la tapadera
        - **Gancho**: Toroide con sombreado suave con la siguiente operación booleana:
            - **Llaveros**: Cilindro con modificador de curva que sigue el círculo **FormaLlavero**. También tiene un array de 3 para duplicarse
        - **CIlindroAdornoTapa**: Cilindro con modificador de curva que sigue el círculo **Circulo_BezierAdornoTapa**. También tiene un array para hacer la decoración completa de la tapadera.