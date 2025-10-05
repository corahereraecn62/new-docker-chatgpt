import os
from flask import Flask, render_template_string

app = Flask(__name__)

@app.route("/")
def index():
    # Simple redirect to noVNC
    html = """
    <html>
    <body>
        <h2>noVNC Desktop</h2>
        <p>Access the desktop below:</p>
        <iframe src="http://localhost:6080/vnc.html?host=localhost&port=6080" width="1024" height="768"></iframe>
    </body>
    </html>
    """
    return render_template_string(html)

if __name__ == "__main__":
    # Use Railway's dynamic port
    port = int(os.environ.get("PORT", 6080))
    app.run(host="0.0.0.0", port=port)
