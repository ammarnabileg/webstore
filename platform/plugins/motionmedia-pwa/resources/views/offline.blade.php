<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>You're Offline</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            padding: 20px;
        }
        .offline-container {
            max-width: 500px;
            animation: fadeIn 0.5s ease-in;
        }
        .icon {
            font-size: 5em;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        h1 {
            font-size: 2.5em;
            margin-bottom: 0.5em;
            font-weight: 700;
        }
        p {
            font-size: 1.2em;
            opacity: 0.9;
            line-height: 1.6;
            margin-bottom: 2em;
        }
        .retry-btn {
            background: white;
            color: #667eea;
            border: none;
            padding: 15px 40px;
            font-size: 1.1em;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .retry-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        }
        .retry-btn:active {
            transform: translateY(0);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }
        .features {
            margin-top: 3em;
            text-align: left;
            background: rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 10px;
        }
        .features h3 {
            margin-bottom: 15px;
            font-size: 1.2em;
        }
        .features ul {
            list-style: none;
            padding-left: 0;
        }
        .features li {
            padding: 8px 0;
            opacity: 0.9;
        }
        .features li:before {
            content: "✓ ";
            font-weight: bold;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="offline-container">
        <div class="icon">📱</div>
        <h1>You're Offline</h1>
        <p>It looks like you've lost your internet connection. Don't worry, some features may still be available from your cache.</p>
        
        <button class="retry-btn" onclick="window.location.reload()">
            Try Again
        </button>

        <div class="features">
            <h3>PWA Features Active:</h3>
            <ul>
                <li>Cached pages remain accessible</li>
                <li>App works offline after first visit</li>
                <li>Installable on your device</li>
                <li>Fast loading from cache</li>
            </ul>
        </div>
    </div>

    <script>
        // Auto-retry when connection is restored
        window.addEventListener('online', () => {
            window.location.reload();
        });
    </script>
</body>
</html>