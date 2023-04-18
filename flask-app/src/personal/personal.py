from flask import Blueprint, request, jsonify, make_response
import json
from src import db

personal = Blueprint('personal', __name__)

# Simple GET route that gets given user's personal transactions
@personal.route('/personal/<userID>', methods=['GET'])
def get_personal_transactions(userID):

    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM PersonalTransactions WHERE user_id = {0}'.format(userID))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)