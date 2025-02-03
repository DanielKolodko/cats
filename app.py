from flask import Flask, render_template, request, redirect, url_for, flash
from models import db, CatGif
from config import Config
import random
import logging

app = Flask(__name__)
app.config.from_object(Config)
db.init_app(app)

with app.app_context():
    db.create_all()  # Ensure tables exist

@app.route("/")
def random_gif():
    gifs = CatGif.query.all()
    logging.debug(f"GIFs fetched from database: {gifs}")
    if not gifs:
        return "No GIFs available. Please add some."
    gif = random.choice(gifs)  # Pick a random GIF
    return render_template("index.html", gif_url=gif.url)

@app.route("/upload", methods=["GET", "POST"])
def upload_gif():
    if request.method == "POST":
        gif_url = request.form["gif_url"]
        if gif_url:
            new_gif = CatGif(url=gif_url)
            db.session.add(new_gif)
            db.session.commit()
            flash("GIF added successfully!", "success")
            return redirect(url_for("random_gif"))
    return render_template("upload.html")

if __name__ == "__main__":
    app.run(debug=True)
