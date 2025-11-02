# AI Glow

A Flutter package that brings the latest AI-driven glow effects to your widgets, inspired by Apple Intelligence and Google’s Gemini AI.

<img width="2509" alt="ss" src="https://github.com/user-attachments/assets/6d4d17bd-93e3-42bb-9849-4c1427191392" />

## Key Highlights

- **Adaptive Inner Glow**: Uses on-device AI to adjust inner glow intensity based on widget content and user interaction patterns.
- **Contextual Outer Glow**: Powered by Apple Intelligence, dynamically tunes glow radius and blur for different UI environments.
- **AI-Enhanced Color Cycling**: Integrates Google Gemini’s neural color generation to create smooth, evolving color gradients.
- **Performance-Optimized**: All glow computations run efficiently on-device, preserving battery life and app responsiveness.
- **Customizable Parameters**: Full control over glow width, blur, border radius, and color palettes, with AI-driven defaults.


![ezgif-36fea2086ad973](https://github.com/user-attachments/assets/8598235f-d9dc-443c-993f-df90a400c67c)


## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ai_glow: ^1.0.0
```

## Usage Examples

### Adaptive Inner Glow

```dart
InnerAiGlowing(
  child: YourWidget(),
  height: 200,
  width: 200,
  borderRadius: 15,
  glowWidth: 3,
  blur: 8,
  colors: [Colors.blue, Colors.purple, Colors.pink],
)
```

### Contextual Outer Glow

```dart
OuterAiGlow(
  child: YourWidget(),
  height: 200,
  width: 200,
  borderRadius: 15,
  glowWidth: 3,
  blur: 8,
  colors: [Colors.cyan, Colors.indigo, Colors.teal],
)
```


## License

MIT License

---

## About the Author

Hi, I'm Ahmed Douss, a Flutter developer passionate about blending AI with UI/UX. With extensive experience in building interactive mobile apps and integrating cutting-edge AI features, I created AI Glow to help developers elevate their Flutter interfaces. Feel free to connect on GitHub and share your feedback!

---

## ☕ Buy Me a Coffee

If you find this package helpful, consider supporting my work:

[![Buy Me a Coffee](https://revolut.me/adouss94)
