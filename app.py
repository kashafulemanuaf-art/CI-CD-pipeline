from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello Kashaf, Docker! Flask app is running."

if __name__ == "__main__":
    # 0.0.0.0 use karna zaroori hai taake container bahar se access ho sake
    app.run(host="0.0.0.0", port=8000, debug=True)
