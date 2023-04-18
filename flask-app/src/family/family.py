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

# adding a POST route to register a new user
@family.route('/registerFamilyTransaction', methods=['POST'])
def register_family_transaction():
    req_data = request.get_json()

    user_id = req_data['userID']
    amount = req_data['amount']
    description = req_data['description']
    cat_id = req_data['catID']
    debOrCred = req_data['debOrCred']
    medium_id = req_data['mediumID']
    dependent_id = req_data['dependentID']

    insert_stmt = 'INSERT INTO FamilyTransactions (user_id,amount,description,category_id,debOrCred,medium_id,dependent_id) VALUES ("'
    insert_stmt += str(user_id) + '", "' + str(amount) + '", ' + description + '", ' + str(cat_id) + '", ' + str(debOrCred) + '", ' + str(medium_id) + '", ' + str(dependent_id) + ')'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"

