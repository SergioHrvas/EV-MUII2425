# Práctica 2 -  

- Autor: Sergio Hervás Cobo 
- Asignatura: Entornos Virtuales - Master Universitario en Ingeniería Informática en la Universidad ee Granada

## Estructura del proyecto


## Modelaado

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


De esta forma se cubren todas las técnicas de modelado vistas en prácticas:
- Array
- Extrusión
- Solevado
- Curva
- Booleano
- Revolución
- Biselado


Estos modelos se han importado en godot, dejando también sus antiguos modelos simples realizados en godot.

*Nota*: Para poder realizar booleanos sobre solevados, he tenido que convertirlo en mesh. Aún así, he dejado la curva para que se vea el recorrido del solevado.
*Nota2*: Se dejan también el desenrollado UV en otros modelos a parte (por necesidad de aplicar ciertos modificadores). También he dejado los modelos "APLICADAS" en otra carpeta con el desenrollado y las transformaciones aplicadas, así como con sus animaciones.


## Animación
Se han realizado dos animaciones:
- Gancho recorriendo un círculo bezier en el que se le ha ido aumentando el desplazamiento por esta a lo largo del tiempo en cada keyframe. Para esta animaciónm también se ha construido un modelo simple de un raíl (con solevado) sobre el que circula el gancho. Acelera cuando baja y decelera cuando sube.

- Cofre y martillo: La tapadera del cofre se abre (se ha cambiado el eje de rotación previamente para que gire de esta forma), luego sale un martillo de él aumentando su tamaño. Cuando ha salido, gira con aceleración y deceleración y se cae al suelo. Finalmente, el cofre se cierra. Las dos animaciones (la del cofre y la del martillo, se han fusionado y se han exportado en 1 para que godot pueda reproducirlas a la vez). El modelo del martillo ha sido importado de una web de modelos (https://sketchfab.com/3d-models/zelda-botw-halo-gravity-hammer-ancient-axe-0aa37183d0ec4c4da518b93051807604#download)

Ambas animaciones se pueden ver en BLENDER/APLICADAS.

En Godot es posible reproducir estas animaciones en la escena "Santuario" (la escena principal)


*Nota 3*: Me he liado un poco con los arhivos de blender y godot por las distintas cosas que debía dejar o no de modificadores aplicados y de UV para la futura práctica, por lo que si faltase algo o hubiese algún problema, dígamelo y lo resuelvo lo antes posible