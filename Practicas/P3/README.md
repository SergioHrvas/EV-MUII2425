# Práctica 3 - Materiales y luces  

- Autor: Sergio Hervás Cobo 
- Asignatura: Entornos Virtuales - Master Universitario en Ingeniería Informática en la Universidad de Granada

## Materiales
De los modelos realizados en Blender, se han añadido los materiales sobre el cofre animado debido a que es el más complejo. Como ya tenemos el desenrollado de malla hecho de la práctica anterior, solamente nos ha hecho falta añadirles los materiales correspondientes que son:

- **Caja:** Metal gris (Metal041A)
    - **Tornillos:** Acero anaranjado (CorrugatedSteel)
    - **Adornos de flecha:** Chapa diamantada gris y naranja (DiamondPlate006C)
    - **Refuerzos:** Oro metálico (Metallic_gold)
    - **Cerradura:** Oro metálico (Metallic_gold)
    - **Marco:** Plástico gris (Plastic018B)
- **Tapadera:** Metal gris (Metal041A)
    - **Adornos:** Metal dorado (Metal034)
    - **Gancho:** (Plastic018B)
    - **Llavero:** Metal gris (Metal050A)

*Nota*: He sacado los materiales de AmbientCG

También se le han añadido los materiales al resto de objetos de la escena como:
- **Bola:** Mármol + Plástico gris
- **Plataforma:** Mármol + Plástico gris
- **Gancho:** Mármol
- **Raíl de gancho:** Metal
- **Pared:** Plaster001 (con normales que simulan gotelé)
- **Suelo:** Tiles028 (baldosas)
- **Techo:** Se ha realizado un techo "mágico" con las siguientes capas:
    - Mesh con una imagen de estrechas en Albedo y un fichero exr en Emission.
    - Dos meshes azul y verde con movimiento que simulan una especie de niebla o efecto sobre el techo (se pretende mejorar para la siguiente práctica). Este movimiento se ha realizado mediante shaders. Este shader crea un efecto de niebla dinámica que fluye suavemente, como si fuese humo moviéndose en cámara lenta. Usa varias capas de ondas superpuestas (como si fuesen olas invisibles) que se mezclan para dar esa sensación de movimiento aleatorio. Se puede controlar su color, velocidad y densidad, ajustando qué tan espesa o transparente se ve la niebla y la suavidad de sus bordes. Me he basado en lo explicado en clase para el agua y en algunos tutoriales e implementaciones como https://godotshaders.com/shader/stylized-cloud-as-texture/
- **Escaleras:** Pavimento de piedra (PavingStones128)
- **Palanca:** Para el soporte se ha escogido el mármol y para el 
- **Silla:** Para el respaldo y asiento se ha usado un material rugoso llamado Carpet, mientras que para las patas y el esqueleto, se ha utilizado un material Rubber.


## Luces
A continuación se explican las luces utilizadas:
- **Luz puntual (OmniLight):** 
    - Se han añadido dos de color verde sobre los objetos "plataforma", simulando que emiten esa luz desde el centro, con sombra porque se supone que la luz se emite desde el centro cóncavo, por lo que no debería producir luz por abajo. Se eligió OmniLight (luz puntual) porque simula con precisión un objeto que emite luz desde su centro, iluminando uniformemente en todas direcciones excepto hacia abajo (gracias a las sombras activadas).
    - También hay otra azul en la parte superior del hacha que sale del cofre, simulando una emisión de luz de dicha herramienta. El hacha es un objeto que emitiría luz desde su núcleo (como un mineral mágico), y OmniLight replica este efecto radial. También se le ha activado el sombreado para evitar que la luz traspase el cofre cuando está en su interior.
    - Se ha introducido otra luz verde en la habitación 2, justo al final de las escaleras donde hay un monumento con "dioses". Para darle más misticidad, se ha querido añadir esta luz que, para hacer que se emita fuera del propio monumento (y no solo dentro), no se han activado las sombras. Se busca un efecto de aura mística que envuelva el monumento, no solo iluminar su interior. OmniLight permite esta irradiación 360°.
    - Por último, este nodo también se ha utilizado para las runas que emitirán luz azul desde su extremo, que son las que dan color a la habitación dándole un toque más misterioso a las habitaciones. En este caso no se ha producido sombreado porque se pretende que parezca que el objeto entero es el que produce la luz en todas direcciones. Las runas son fuentes de energía mágica que emanan luz por sí mismas (no son reflectores). OmniLight captura esta esencia. Aunque más adelante se usa una runa parecida pero con SpotLight.

- **Luz direccional (DirectionalLight):**  
  Implementada para simular iluminación solar en la Habitación 1, aprovechando sus ventanas como fuente de entrada de luz natural. Para optimizar su comportamiento:  
  - Ubicada en la escena raíz del santuario, se ha pretendido que solo ilumine la habitación 1. Para lograr esto tenía dos dilemas:
    - Si lo ponía dentro de la escena de la habitación 1, el hueco superior para el pasillo iba a dejar pasar la luz. Probando varias formas (obstrudeLight, mesh con alpha 0...), no logré encontrar alguna que evitase que pasase esta luz.
    - Si lo ponía en la escena del santuario, la luz (con sombra a 0.5), afectaba también a la habitación 2, lo cual no tenía sentido porque no tenía ninguna ventana. Para evitar que entrase luz solar, lo que hice fue que esta luz direccional afectase a todas las capas menos a la 5, y esta capa se la asigne a un MeshInstance invisible que es el padre de la habitación 2 entera, de esta forma, esa luz no puede entrar dentro. No sé si es lo más óptimo pero es lo que pude hacer para que la habitación 2 pudiese seguir teniendo esa luz "mágica" sin la direccional.

    He usado esta luz para simular la luz solar, con un sombreado con opacidad 0.5 y una inclinación para que la luz ilumine sutilmente la habitación y entre por la ventana. 
  - Color: Amarillo pálido (#FFF4D6, temperatura 4500K).  

- **Luz focal (SpotLight):** 
    - De color amarillo. Sale del triángulo de zelda como si fuese un foco y se proyecta sobre el cofre. Se encuentra en la habitación 2. Apretando "l", se produce la animación de "titilar" donde la luz se apaga, se enciende varias veces y finalmente se atenua. Las sombras reforzarán el efecto dramático de la animación de "titilar" (al apagarse/encenderse, las sombras aparecerán/desaparecerán, añadiendo dinamismo). En este caso se decide utilizar la luz focal porque se quiere hacer que se resalte el cofre únicamente, por lo que este nodo nos permite justamente eso, enfocar la luz a un único ángulo.
    - De color verdoso. Sale de la runa en el techo de la habitación 1 para iluminar sutilmente la sala. Se ha utilizado luz focal debido a que es más fácil controlar su alcance y pretendemos que esta runa no ilumine el techo, sino desde la punta para abajo (como una lámpara). No se usa sombras porque se pretende que la iluminación de este nodo sea sutil, por lo que añadir sombras no cambiaría mucho la escena y empeoraría el rendimiento.

- **WorldEnvironment**: Se ha añadido un WorldEnviroment con un VolumetricFog azulado tenue para que las habitaciones tengan aún un efecto más misterioso y mágico. Esto se pretende mejorar en futuras entregas.