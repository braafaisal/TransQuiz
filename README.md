ranslateQuest - Educational Language Translation Game



![1](https://github.com/user-attachments/assets/eec5f80a-479f-4ca6-9bc6-ee416984fb87)



![2](https://github.com/user-attachments/assets/214cae0c-0b83-4f33-95c4-fa2ef21399d7)




![3](https://github.com/user-attachments/assets/2cc837c4-89ed-4bc5-9672-f0e152bb0ef8)



![4](https://github.com/user-attachments/assets/230bef5e-b4d9-4ce1-8abc-89f2fdb9acfd)




![5](https://github.com/user-attachments/assets/7c3d1c46-df7e-4ccf-b6ab-bec8f6752cda)


TranslateQuest is an interactive educational application designed to help users improve their language skills by translating words from Arabic to English. The game offers a structured approach to learning through engaging gameplay, progressively challenging levels, and instant feedback.
Features:

    Multi-Level Challenges:
        The game is divided into several levels, each with a set of predefined questions. Users advance through levels by correctly translating words from Arabic to English.
        Levels are designed to progressively increase in difficulty, ensuring a gradual learning curve.

    Text-to-Speech Functionality:
        Each English word is accompanied by a text-to-speech feature that reads the word aloud. This helps users with pronunciation and reinforces learning.

    Interactive Gameplay:
        Users are presented with Arabic words and must enter their English translations.
        The game provides immediate feedback on the correctness of the answers, allowing users to learn from their mistakes in real-time.

    Scoring and Leaderboards:
        Players earn scores based on the accuracy of their translations. Correct answers contribute to the overall score, while incorrect answers are recorded for review.
        A leaderboard tracks the top-performing users, encouraging friendly competition and motivation.

    Level Unlocking:
        Levels are unlocked based on the player’s performance. Users must achieve a minimum score (e.g., 90%) to unlock subsequent levels.
        Completing levels successfully can unlock new challenges and features within the app.

    Personalized Experience:
        Users can track their progress through scores and completed levels. The app saves game data and user preferences for a personalized learning experience.

    Visual and Audio Enhancements:
        The app features a user-friendly interface with visually appealing design elements, including vibrant colors and intuitive navigation.
        Audio feedback for correct and incorrect answers enhances the interactive experience.

Technical Implementation:

    Platform: Flutter for cross-platform development (iOS and Android).
    State Management: Utilizes Flutter’s StatefulWidget and setState for managing UI updates and game state.
    Data Persistence: Uses SharedPreferences for storing user progress, level status, and game scores.
    Text-to-Speech: Integrated using Flutter’s flutter_tts package to convert text to spoken word.
    Routing: Implemented with named routes and dynamic route arguments to handle navigation between different screens (e.g., Home, Game, Results).
    Local Data Storage: JSON is used for storing and retrieving questions and game data.
    UI Components: Utilizes Flutter’s ListView, ElevatedButton, TextField, and AlertDialog for interactive user interfaces.

Setup and Installation:

    Clone the Repository:

    bash

git clone https://github.com/your-repo/TransQuiz.git



Install Dependencies:

bash

cd TranslateQuest
flutter pub get

Run the App:

bash

    flutter run

Contributing:

    Contributions are welcome! Please fork the repository and submit pull requests for any enhancements, bug fixes, or new features.
    For detailed contribution guidelines, refer to the CONTRIBUTING.md file.

License:

    This project is licensed under the MIT License. See the LICENSE file for details.
