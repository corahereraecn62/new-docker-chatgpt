import os
import random
import string
from flask import Flask, send_from_directory
import subprocess

app = Flask(__name__, static_folder="/usr/share/novnc")

# Generate random VNC password if not set
VNC_PASS = os.environ.get("VNC_PASSWORD")
if not VNC_PASS:
    VNC_PASS = ''.join(random.choices(string.ascii_letters + string.digits, k=8))
    os.environ["VNC_PASSWORD"] = VNC_PASS

# Write password to x11vnc passwd file
subprocess.run(f"x11vnc -storepasswd {VNC_PASS} {os.environ['PASSWORD_FILE']}", shell=True)

@app.route("/")
def index():
    # Serve noVNC client
    return send_from_directory(app.static_folder, "vnc.html")

@app.route("/<path:path>")
def static_proxy(path):
    return send_from_directory(app.static_folder, path)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 6080))  # Railway dynamic port
    app.run(host="0.0.0.0", port=port)
