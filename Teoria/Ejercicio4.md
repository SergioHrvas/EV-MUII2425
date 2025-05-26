# 🎮 Lanzamiento de un Objeto desde Cámara en Primera Persona (FPV)
## 1. Fuerzas fundamentales a considerar

- **Masa del objeto (m):** Importante para la resistencia al aire.
- **Fuerza inicial (F):** Dirección y magnitud del impulso desde la posición de la cámara. Determina la velocidad inicial.
- **Dirección de lanzamiento:** Coincide con la dirección de visión de la cámara. Define el ángulo y la orientación del tiro.
- **Gravedad (g):** Aceleración constante hacia abajo (`Vector3(0, -9.8, 0)`). Provoca la caída y la curvatura de la trayectoria.
- **Resistencia del aire:** Fuerza que se opone al movimiento, proporcional a la velocidad. Reduce el alcance y modifica la curva de la trayectoria. 𝐹𝑑 = −𝑘 ⋅⃗ 𝑣