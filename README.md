# Baddielands

> **"Another Dimension, Another Domension"** — *A puzzle co-op experience made for Game Jam 4.*

![Godot](https://img.shields.io/badge/Godot-4.5.1-478CBF?logo=godotengine&logoColor=white)
![License](https://img.shields.io/badge/License-Proprietary-red)
![Platform](https://img.shields.io/badge/Platform-Linux-FCC624?logo=linux&logoColor=black)
![Local Co-op](https://img.shields.io/badge/Mode-Local%20Co--op-blueviolet)
![Game Jam](https://img.shields.io/badge/Game%20Jam-4%20·%20IUT%20Reims-orange)

**Baddielands** is a split-screen local co-op game where communication is your only chance of winning. Cross dimensions, exchange items between worlds, and beat the clock.

<!-- Add screenshots here once available -->
<!-- ![Gameplay](screenshots/gameplay.png) -->

---

## The Concept

Two players, three dimensions, one single goal: the Pizza.

- **Player 1** is stuck in **Dimension A**.
- **Player 2** is stuck in **Dimension C**.
- **Dimension B** is the neutral meeting point.

**The Twist:** Keys found in Dimension A open chests in Dimension C (and vice versa). You cannot interact with objects that are not in your reality.

**The Loop:**

1. Find a key in your world.
2. Switch to **Dimension B** (middle ground).
3. Meet your partner and drop the key.
4. Your partner picks it up and takes it to their dimension to unlock their chest.

---

## Key Features

- **Multidimensional Puzzles:** Coordinate perfectly to transfer items across realities.
- **Dynamic Split-Screen:** Adapts in real-time to your positions.
- **Old Cinema Shader:** A unique visual effect and smooth transitions in the menu.
- **Speedrun Mode:** Integrated high score system with automatic saving of your best time.
- **Adaptive Music:** A soundtrack that remains seamless across dimension jumps.

---

## Controls (AZERTY Keyboard)

The game is played in local co-op — 2 players on the same keyboard.

| Action | Player 1 (Left) | Player 2 (Right) |
| :--- | :---: | :---: |
| Move | `Z` `Q` `S` `D` | `Arrow Keys` |
| Change dimension | `E` | `Right Shift` |
| Drop an item | `A` | `P` |
| Pause | `Esc` | `Esc` |
| Menu navigation | movement keys | movement keys |
| Menu confirm | change dimension keys | change dimension keys |
| Reset high score | `R` | `R` |

---

## Installation

### Linux

```bash
git clone https://github.com/IlanRigolio/Baddielands.git
cd Baddielands
chmod +x run.sh && ./run.sh
```

---

## Credits

| Role | Name |
| :--- | :--- |
| Development & Game Design | Ilan Rigolio & Charles Thorin |
| Art & Graphics | Lesliana Martin |
| Audio & Music | Julien Baetens |

---

*Developed in ~33 hours on [Godot 4.5.1](https://godotengine.org). All rights reserved — see [LICENSE](LICENSE).*
