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

# Simple GET route that lists all personal transactions of given user in given category
@personal.route('/personal/<userID>/<catID>', methods=['GET'])
def get_personal_transactions_cat(userID, catID):

    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM PersonalTransactions WHERE user_id = {0}'.format(userID) + ' AND category_id = {0}'.format(catID))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)

# Gets all the cards a user has registered
@personal.route('/getCards/<userID>', methods=['GET'])
def get_cards(userID):

    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM Cards WHERE user_id = {0}'.format())

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)


# POST route that lets users add new personal transactions 
@personal.route('/addPersonal/<userID>', methods=['POST'])
def add_personal_transaction(userID):
    req_data = request.get_json()
    
    transaction_amnt = req_data['amount']
    transaction_desc = req_data['description']
    transaction_cat = req_data['category']
    transaction_debcred = req_data['deb_cred']
    transaction_med = req_data['medium']

    insert_stmt = 'INSERT INTO PersonalTransactions (amount, description, category_id, debOrCred, medium_id) VALUES (" '
    insert_stmt += transaction_amnt + '", "' + transaction_desc + '", "' + transaction_cat + '", "' + transaction_debcred + '", "' + transaction_med + ')'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"
