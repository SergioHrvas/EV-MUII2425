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
    - Dos meshes azul y verde con movimiento que simulan una especie de niebla o efecto sobre el techo (se pretende mejorar para la siguiente práctica). Este movimiento se ha realizado mediante shaders.
- **Escaleras:** Pavimento de piedra (PavingStones128)

## Luces
Se han añadido las siguientes luces:
- **Luz direccional:** De color verdoso. Sale de la parte superior de las dos habitaciones. Simula la iluminación que da el efecto de magia realizado en el techo. 
- **Luz focal (SpotLight):** De color amarillo. Sale del triángulo de zelda como si fuese un foco y se proyecta sobre el cofre. Se encuentra en la habitación 2. Apretando "l", se produce la animación de "titilar" donde la luz se apaga y se enciende varias veces y finalmente se atenua.
- **Luz puntual (OmniLight):** Se encuentran en la habitación 1. Hay dos de color naranja sobre los objetos "plataforma", simulando que emiten esa luz desde el centro. También hay otra azul en la parte superior del hacha que sale del cofre, simulando una emisión de luz de dicha herramienta.