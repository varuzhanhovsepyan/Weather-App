# Weather App

A modern weather application built with Flutter that provides real-time weather information and 7-day forecasts for cities worldwide.

## Screenshots

The app features a clean interface with:
- Home screen displaying current weather with temperature, location, and weather description
- Search screen with city suggestions and search history
- Detailed 7-day forecast list

## Architecture

The project follows a clean architecture pattern with the following structure:

```
lib/
├── app/                    # App configuration
├── features/              # Feature modules
│   └── weather/          # Weather feature
│       ├── models/       # Data models
│       ├── weather_service.dart    # API service
│       └── weather_state.dart      # State management
├── pages/                # UI screens
│   ├── weather_home/    # Home screen
│   └── search_city/     # Search screen
└── shared/              # Shared resources
    ├── theme/           # Colors and theme
    └── ui/              # Reusable UI components
        └── molecules/   # Composite UI components
```

## Technologies Used

- **Flutter** - UI framework
- **Provider** - State management
- **HTTP** - API requests
- **Open-Meteo API** - Weather data source (free, no API key required)

## Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- iOS Simulator / Android Emulator / Physical Device

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd weather_app_new
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## API

This app uses the [Open-Meteo API](https://open-meteo.com/) for weather data:
- Geocoding API for city coordinates
- Weather Forecast API for current weather and forecasts
- No API key required
- Free and open source

## State Management

The app uses **Provider** for state management:
- `WeatherState` manages current weather data and forecast
- Search history is stored in memory
- Real-time updates when searching for new cities

## Testing

Run tests with:
```bash
flutter test
```

## Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Project Status

✅ Core features implemented
✅ Real-time weather data
✅ City search functionality
✅ 7-day forecast
✅ Clean code architecture

## Future Improvements

- Add unit tests and widget tests
- Implement local storage for search history
- Add more weather details (UV index, sunrise/sunset, etc.)
- Support for multiple languages
- Dark mode theme
- Weather alerts and notifications

## License

This project is a test/learning project for Flutter development.

## Contact

For questions or feedback, please open an issue in the repository.
