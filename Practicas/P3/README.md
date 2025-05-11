# Práctica 3 - Materiales y luces  

- Autor: Sergio Hervás Cobo 
- Asignatura: Entornos Virtuales - Master Universitario en Ingeniería Informática en la Universidad de Granada

## Estructura del proyecto
- project.godot
- README.md y README.pdf: Documentacion
- santuario.tscn Escena principal
- /elements: Elementos y modelos 
- /blender: modelos de blender, ahora los modelos con la animación y el UV juntos correctamente para poder exportar y ponerles materiales con el modelo animado.
- /materiales: Materiales y shaders utilizados.
- /img: Imagenes de la memoria


## Materiales
De los modelos realizados en Blender, se han añadido los materiales sobre el cofre animado debido a que es el más complejo. Como ya tenemos el desenrollado de malla hecho de la práctica anterior, solamente nos ha hecho falta añadirles los materiales correspondientes.

En general, he utilizado texturas de 2K de resolución para los materiales del proyecto, ya que proporcionan un buen equilibrio entre calidad visual y rendimiento. Con esta resolución se tiene suficiente detalle para mantener un alto nivel de realismo sin consumir demasiados recursos. Aún así, para algunas partes más pequeñas que no necesitan tanto detalle, se justificará elegir la resolución mínima encontrada (1K).

Otra de las optimizaciones que se han realizado es en el albedo: en lugar de cargar la imagen de textura de un color liso, se ha modificado el color del parámetro de godot. Cargar una textura JPG que sea completamente de un solo color (por ejemplo, naranja) es innecesario y consume más recursos que simplemente asignar el color directamente en el parámetro de albedo del material en Godot.

Para mejorar el rendimiento también se han reutilizado algunos materiales en distintas partes del cofre (a continuación se verá). Esta estrategia ha permitido reducir la cantidad de texturas y materiales únicos, optimizando el uso de recursos sin sacrificar la calidad visual. Al reutilizar materiales como el metallic_gold en diferentes componentes del cofre, se ha logrado minimizar el impacto en el rendimiento.

Al importar las texturas se ha comprobado que estén VRAM Compress y Generate Mipmap activados de forma automática porque estas opciones optimizan el uso de memoria de la GPU y mejoran el rendimiento del renderizado, especialmente en escenas 3D. La compresión en VRAM reduce el tamaño de las texturas cargadas en la tarjeta gráfica, mientras que los mipmaps mejoran la eficiencia al renderizar objetos.

A continuación, explico los materiales utilizados en el cofre (el modelo más complejo):

- **Caja:** Metal gris (Metal041A), compuesto por Albedo (color base), Metalness, Roughness, NormalGL y Height (desplazamiento). El material está configurado con un valor de Metallic de 0.75, Specular en 0.65, Roughness a 0.80 y una intensidad de normales (Normal Scale) de 3, lo que permite un acabado metálico envejecido con gran realismo superficial. Estas texturas permiten simular con precisión el comportamiento de la luz en diferentes zonas del objeto sin añadir complejidad geométrica.
    - **Tornillos:** Acero anaranjado (CorrugatedSteel). Se utilizó una textura de acero ondulado de 1K de resolución, lo cual es suficiente dado el tamaño pequeño de los tornillos y su visibilidad limitada, ayudando a optimizar los recursos. Se añadió un toque anaranjado al albedo grisáceo para simular un acero oxidado o envejecido, añadiendo realismo. El valor metálico se estableció a 1 para reflejar correctamente las propiedades de un material metálico. Además, se aplicaron un mapa de normales con escala 16 para resaltar los relieves, un valor de roughness de 1 para simular una superficie rugosa, y una oclusión ambiental de 1 con una textura similar al mapa de normales. Finalmente, se utilizó un displacement con valor de 5 en Height para mejorar los detalles de la superficie.
    - **Adornos de flecha:** Chapa diamantada gris y naranja (DiamondPlate006C). El valor metálico se estableció en 1 para representar la naturaleza del material metálico. Se aplicó un mapa de normales con una escala de 6.5 para resaltar los relieves horizontales, características típicas de la chapa de metal. El valor de oclusión ambiental se ajustó a 0.75 para mejorar el sombreado de las superficies, mientras que el roughness se configuró en 0.8, dando una apariencia rugosa y mate al material. No se utilizó displacement para el height, ya que los detalles de los relieves se logran de forma efectiva con el mapa de normales y la textura, lo que ayuda a optimizar el rendimiento sin perder realismo. Además se activó el triplanar en el UV1 para mejorar la textura en los laterales (y por tanto no es compatible con la propiedad Height).
    - **Refuerzos:** Oro metálico (Metallic_gold). Se ha ajustado con un valor de Roughness de 0.65, lo que permite reflejos moderadamente difusos, y un Metallic de 0.6 para aportar un acabado metálico sin saturar los reflejos. Además, se ha configurado un Specular de 0.6 para equilibrar la intensidad del brillo especular en función del ángulo de visión. Este material no utiliza mapas adicionales, lo que reduce la carga de GPU y mejora la eficiencia.
    - **Cerradura:** Oro metálico (Metallic_gold)
    - **Marco:** Plástico gris (Plastic018B).  Este material tiene un acabado plástico, de tono grisáceo aplicado mediante una textura en el canal Albedo. Para optimizar el rendimiento, se ha decidido no utilizar un mapa de normales ni de desplazamiento en Height, ya que en las partes del cofre donde se emplea este elemento no se perciben detalles significativos que justifiquen su coste en GPU. Se ha empleado un valor alto de rugosidad (Roughness = 1), lo que reduce al mínimo los reflejos especulares, reforzando el acabado plástico mate.
- **Tapadera:** Metal gris (Metal041A).
    - **Adornos:** Se ha utilizado un metal dorado (Metal034) con un albedo naranja para simular un acabado metálico con un tono dorado. El valor de metallic se ha ajustado a 1 para reflejar las propiedades metálicas del material, mientras que el roughness se ha configurado a 1. No se ha utilizado Normal Map ni Displacement debido a que no se percibirían cambios significativos en los adornos y para optimizar el rendimiento. Aunque se podría haber reutilizado el material metallic_gold para mejorar el rendimiento, se prefirió crear un material específico para obtener un control más detallado sobre el acabado visual.
    - **Gancho:** (Plastic018B).
    - **Llavero:** Metal gris (Metal050A). Se utilizó una textura metálica de 1K de resolución, suficiente para objetos pequeños que no requieren detalles de alta resolución. El color de albedo es blanco con manchas leves para simular un desgaste sutil, lo que añade un toque de realismo. El valor metálico se estableció en 1 para reflejar correctamente las propiedades del metal, y el roughness se ajustó a 1, lo que da un acabado completamente rugoso y sin brillo, adecuado para este tipo de material. No se aplicaron mapas de normales ni displacement, ya que la escala del objeto no lo justifica y no se percibirían cambios significativos, lo que ayuda a reducir la complejidad y optimiza el rendimiento sin sacrificar la calidad visual.

*Nota*: He sacado los materiales de AmbientCG.

Para las normales de los materiales se ha utilizado la textura de NormalGL (en lugar de NormalDX), ya que Godot sigue la convención de OpenGL para las coordenadas normales, donde el eje Y está orientado hacia arriba. También se han evitado parámetros como transparencia o opciones GLES3, ya que incrementan significativamente el coste de renderizado.

También se le han añadido los materiales al resto de objetos de la escena (muchos reutilizados) como:
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
- **Runas:** Material con emisión de colores (azul y verde)
- **Ascensor:** Se ha usado la chapa diamantada de los adornos del cofre. En este caso se ha usado UV triplanar para que los laterales se mapeen correctamente.


## Luces
A continuación se explican las luces utilizadas:
- **Luz puntual (OmniLight):** 
    - Se han añadido dos de color verde sobre los objetos "plataforma", simulando que emiten esa luz desde el centro, con sombra porque se supone que la luz se emite desde el centro cóncavo, por lo que no debería producir luz por abajo. Se eligió OmniLight (luz puntual) porque simula con precisión un objeto que emite luz desde su centro, iluminando uniformemente en todas direcciones excepto hacia abajo (gracias a las sombras activadas).
    - También hay otra azul en la parte superior del hacha que sale del cofre, simulando una emisión de luz de dicha herramienta. El hacha es un objeto que emitiría luz desde su núcleo (como un mineral mágico), y OmniLight replica este efecto radial. También se le ha activado el sombreado para evitar que la luz traspase el cofre cuando está en su interior.
    - Se ha introducido otra luz verde en la habitación 2, justo al final de las escaleras donde hay un monumento con "dioses". Para darle más misticidad, se ha querido añadir esta luz que, para hacer que se emita fuera del propio monumento (y no solo dentro), no se han activado las sombras. Se busca un efecto de aura mística que envuelva el monumento, no solo iluminar su interior. OmniLight permite esta irradiación 360°.
    - Por último, este nodo también se ha utilizado para las runas que emitirán luz azul desde su extremo, que son las que dan color a la habitación dándole un toque más misterioso a las habitaciones. En este caso no se ha producido sombreado porque se pretende que parezca que el objeto entero es el que produce la luz en todas direcciones. Las runas son fuentes de energía mágica que emanan luz por sí mismas (no son reflectores). OmniLight captura esta esencia. Aunque más adelante se usa una runa parecida pero con SpotLight.

- **Luz direccional (DirectionalLight):**  
  Implementada para simular iluminación solar en la Habitación 1, aprovechando sus ventanas como fuente de entrada de luz natural. Para optimizar su comportamiento:  
  - Ubicada en la escena raíz del santuario, se ha pretendido que solo ilumine la habitación 1 con sombra a 0.5 de opacidad. Para lograr esto tenía dos dilemas:
    - Si lo ponía dentro de la escena de la habitación 1, el hueco superior para el pasillo iba a dejar pasar la luz. Probando varias formas (obstrudeLight, mesh con alpha 0...), no logré encontrar alguna que evitase que pasase esta luz.
    - Si lo ponía en la escena del santuario, la luz (con sombra a 0.5), afectaba también a la habitación 2, lo cual no tenía sentido porque no tenía ninguna ventana. 
    Para evitar que entrase luz solar, lo que hice fue que esta luz direccional afectase a todas las capas menos a la 5 (desmarcando la casilla 5 en su Light > Culling Mask). A continuación, apliqué un script a la habitación 2 que, al cargarse, asigna de forma automática la capa 5 a todos sus nodos visuales (como MeshInstance3D, CSGBox3D, etc.), incluso si están anidados dentro de otros Node3D. Esto permite mantener escenas reutilizables entre habitaciones sin modificar nodo por nodo, ya que se recorren todos los hijos recursivamente y solo se actualizan los que son renderizables. De esta forma, la habitación 2 queda completamente excluida del efecto de la luz solar, sin trucos visuales ni objetos opacos, y sin perder modularidad en la estructura de escenas. Es la única forma sencilla y reutilizable que encontré, **pero finalmente decididí dejar la sombra con opacidad 1 por simplicidad, afectando solo a los huecos de las ventanas de la habitación 1.**

    He usado esta luz para simular la luz solar, con un sombreado con opacidad 1 y una inclinación para que la luz ilumine sutilmente la habitación y entre por la ventana. El color que elegido es blanco verdoso (mezcla del azul de la niebla y el amarillo del sol).  

- **Luz focal (SpotLight):** 
    - De color amarillo. Sale del triángulo de zelda como si fuese un foco y se proyecta sobre el cofre. Se encuentra en la habitación 2. Apretando "l", se produce la animación de "titilar" donde la luz se apaga, se enciende varias veces y finalmente se atenua. Las sombras refuerzan el efecto dramático de la animación de "titilar" (al apagarse/encenderse, las sombras aparecerán/desaparecerán, añadiendo dinamismo). En este caso se decide utilizar la luz focal porque se quiere hacer que se resalte el cofre únicamente, por lo que este nodo nos permite justamente eso, enfocar la luz a un único ángulo.

    ![](/img/1.png)
    - De color verdoso. Sale de la runa en el techo de la habitación 1 para iluminar sutilmente la sala. Se ha utilizado luz focal debido a que es más fácil controlar su alcance y pretendemos que esta runa no ilumine el techo, sino desde la punta para abajo (como una lámpara). No se usa sombras porque se pretende que la iluminación de este nodo sea sutil, por lo que añadir sombras no cambiaría mucho la escena y empeoraría el rendimiento.

- **WorldEnvironment**: Se ha añadido un WorldEnviroment con un VolumetricFog azulado tenue para que las habitaciones tengan aún un efecto más misterioso y mágico. Esto se pretende mejorar en futuras entregas.


Con estas dos luces conseguimos dos efectos distintos en las habitaciones:
- Habitacion 1: Habitación con ventanas y con más fuentes de iluminación. Es la sala donde se realizará la prueba para pasar y obtener la recompensa en la habitación 2, por eso se busca más claridad sin perder el toque mágico y misterioso.
- Habitación 2: Habitación sin ventanas, con menos fuentes de luz y donde el usuario obtendrá la recompensa y podrá acabar la prueba. Se busca una experiencia más mágica y misteriosa, por eso es más oscura y tiene más sombras.