from flask import Blueprint, request, jsonify, make_response
import json
from src import db

family = Blueprint('family', __name__)

# Simple GET route that gets given user's family transactions
@family.route('/family/<userID>', methods=['GET'])
def get_family_transactions(userID):

    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM FamilyTransactions WHERE user_id = {0}'.format(userID))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

    return the_response

