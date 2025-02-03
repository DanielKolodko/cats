from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

class CatGif(db.Model):
    __tablename__ = 'cat_gifs'
    id = db.Column(db.Integer, primary_key=True)
    url = db.Column(db.String(500), nullable=False, unique=True)
    uploaded_at = db.Column(db.DateTime, default=datetime.utcnow)