from flask import Blueprint, request, jsonify, make_response
import json
from src import db

users = Blueprint('users', __name__)

# Simple GET route that gets given user's personal transactions
@users.route('/users', methods=['GET'])
def get_users():

    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM Users')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)