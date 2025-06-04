# Práctica 5 - Colisiones + Interacciones | Proyecto final
- Autor: Sergio Hervás Cobo 
- Asignatura: Entornos Virtuales - Master Universitario en Ingeniería Informática en la Universidad de Granada


## Colisiones
Se han añadido colisiones en todos los objetos del santuario:
- Las habitaciones son StaticBody
- Las bolas, el gancho y silla son RigidBody, que se podrán mover empujándolas con el Avatar.
- 
- 
- 

## Carga de habitaciones

## Flujo del juego
El jugador debe coger las dos bolas (E) y lanzarlas sobre la plataforma (E). También cogerá el gancho (E) y lo lanzará (E) sobre el soporte de la pared trasera para que quede encajado. Una vez hecho esto, podrá ponerse sobre el ascensor y accionará la palanca (E). Cuando esta palanca suba, si espera 5 segundos, volverá a bajar a la habitación. Pero si continua, pasará a la segunda habitación, donde podrá coger el objeto del cofre pulsando E y finalizar la prueba del santuario pulsando E sobre el monumento al final de las escaleras. Deberá terminar el puzzle 2D clickando los dos botones azules para dejar los cuatro de color verde y acabará en la pantalla final.

## Extras
A continuación se especifican los añadidos extra que se han realizado para el santuario:
- **Sonidos:** Se han añadido sonidos para mejorar la inmersión en el juego.
    - **Inicio:** Al iniciar aparecen unas letras del título del santuario "MUIIEV" y un "Resuelve el puzzle" junto con un sonido.
    - **Palanca:** Al darle a la palanca, suena un sonido que puede ser:
        - **Error:** Si no están todas las piezas del puzzle
        - **Acierto:** Si están todas las piezas del puzzle, antes de que el ascensor ascienda por el pasillo.
    - **Cofre:** Al abrirlo, suena un sonido de obtención del objeto.

- **HUD e interfaces:** Se han añadido algunas interfaces para mejorar la interacción con el juego.
    - **HUD:** Interfaz que tiene el inventario, el cursor en el centro de la pantalla y los controles en la esquina superior izquierda.
    - **Start:** Letras con el título del santuario "MUIIEV" y un texto de "Resuelve el puzzle". Aparecen al inicio con un fade-in y se desvanecen con un fade-out a los pocos segundos.
    - **End:** Interfaz con el puzzle final que aparece al interactuar (E) con el monumento del santuario. Hay que presionar los dos botones azules para que se conviertan en verde y se pueda desbloquear el santuario. Cuando se realice, pasará a la pantalla final donde se puede abandonar el juego o reiniciarse.


- **Reinicio de juego:** El juego se puede reiniciar al finalizarse.
- **Salto del usuario:** El usuario puede saltar presionando espacio.
- **VR:** Se ha realizado la escena CameraXR para el uso en las gafas de realidad virtual siguiendo el tutorial que se dejó, pero por falta de medios y de tiempo no he podido comprobarlo. 