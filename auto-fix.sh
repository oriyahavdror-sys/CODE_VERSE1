#!/bin/bash

# CODE VERSE - GitHub Pages Auto Fix Script
# סקריפט אוטומטי לתיקון GitHub Pages

echo "🎮 CODE VERSE - GitHub Pages Fix"
echo "=================================="
echo ""

# Check if we're in the right directory
if [ ! -d ".git" ]; then
    echo "❌ שגיאה: לא נמצא תיקיית .git"
    echo "   הרץ את הסקריפט מתוך תיקיית הפרויקט CODE_VERSE"
    exit 1
fi

echo "📁 בודק את המיקום הנוכחי..."
CURRENT_DIR=$(basename "$PWD")
echo "   תיקייה נוכחית: $CURRENT_DIR"
echo ""

# Ask for confirmation
echo "⚠️  הסקריפט ימחק את כל הקבצים הקיימים!"
echo "   האם להמשיך? (y/n)"
read -r CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "❌ בוטל על ידי המשתמש"
    exit 0
fi

echo ""
echo "🗑️  שלב 1: מוחק קבצים ישנים..."

# Remove all files except .git
find . -maxdepth 1 ! -name '.git' ! -name '.' ! -name '..' -exec rm -rf {} +

echo "   ✅ קבצים ישנים נמחקו"
echo ""

echo "📥 שלב 2: בודק אם יש index.html..."

# Check if index-simple.html exists in parent directory or current
if [ -f "../index-simple.html" ]; then
    echo "   ✅ נמצא index-simple.html"
    cp "../index-simple.html" "./index.html"
    echo "   ✅ הועתק בשם index.html"
elif [ -f "index-simple.html" ]; then
    echo "   ✅ נמצא index-simple.html"
    mv "index-simple.html" "index.html"
    echo "   ✅ שונה שם ל-index.html"
else
    echo "   ❌ לא נמצא index-simple.html"
    echo ""
    echo "📝 יוצר index.html חדש..."
    
    # Create index.html directly
    cat > index.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="he">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CODE VERSE - משחק למידה בסייבר</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-900 min-h-screen flex items-center justify-center p-4">
    <div class="max-w-2xl w-full">
        <div class="bg-slate-800 rounded-3xl p-8 shadow-2xl border-2 border-cyan-500/30">
            <div class="text-center mb-8">
                <div class="w-20 h-20 bg-gradient-to-br from-cyan-500 to-blue-600 rounded-2xl mx-auto mb-4 flex items-center justify-center text-4xl">
                    🛡️
                </div>
                <h1 class="text-4xl md:text-5xl font-black text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500 mb-2">
                    CODE VERSE
                </h1>
                <p class="text-slate-400 text-lg">משחק למידה אינטראקטיבי לאבטחת סייבר</p>
            </div>
            <div class="bg-green-500/10 border-2 border-green-500/30 rounded-xl p-6 text-center">
                <div class="text-4xl mb-3">✅</div>
                <h3 class="text-xl font-bold text-green-400 mb-2">האתר עובד!</h3>
                <p class="text-green-100/80">GitHub Pages פעיל ועובד כראוי</p>
            </div>
            <div class="text-center mt-6">
                <a href="https://github.com/oriyahavdror-sys/CODE_VERSE" 
                   target="_blank"
                   class="inline-block bg-gradient-to-r from-purple-500 to-pink-600 text-white font-bold py-4 px-8 rounded-xl">
                    ⭐ GitHub Repository
                </a>
            </div>
        </div>
    </div>
</body>
</html>
HTMLEOF
    
    echo "   ✅ נוצר index.html חדש"
fi

echo ""
echo "📦 שלב 3: מבצע commit..."

git add index.html
git commit -m "🎮 Fix GitHub Pages - Add working index.html"

echo "   ✅ Commit בוצע"
echo ""

echo "📤 שלב 4: דוחף ל-GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo "   ✅ Push הצליח!"
else
    echo "   ⚠️  Push נכשל, מנסה עם master..."
    git push origin master
    
    if [ $? -eq 0 ]; then
        echo "   ✅ Push הצליח!"
    else
        echo "   ❌ Push נכשל"
        echo ""
        echo "נסה ידנית:"
        echo "   git push origin main"
        echo "או:"
        echo "   git push origin master"
        exit 1
    fi
fi

echo ""
echo "✅ הכל הסתיים בהצלחה!"
echo ""
echo "📋 מה עכשיו?"
echo "   1. חכה 1-2 דקות"
echo "   2. לך ל-Settings → Pages ווודא שזה מוגדר"
echo "   3. בקר באתר:"
echo "      https://oriyahavdror-sys.github.io/CODE_VERSE/"
echo ""
echo "🎉 סיימנו!"
