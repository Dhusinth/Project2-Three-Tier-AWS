from flask import Flask
from flask_mysql_connector import MySQL
import os
from flask import jsonify

app = Flask(__name__)

app.config['MYSQL_PASSWORD'] = os.environ.get('MYSQL_PASSWORD')
app.config['MYSQL_USER'] = os.environ.get('MYSQL_USER')
app.config['MYSQL_HOST'] = os.environ.get('MYSQL_HOST')
app.config['MYSQL_DATABASE'] = os.environ.get('MYSQL_DATABASE')

@app.route('/')
def home():
    return 'Hello from Flask!'

@app.route('/health')
def health():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

