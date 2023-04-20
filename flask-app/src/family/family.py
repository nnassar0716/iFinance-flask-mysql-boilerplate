from flask import Blueprint, request, jsonify, make_response
import json
from src import db

family = Blueprint('family', __name__)

# Simple GET route that gets given user's family transactions
@family.route('/family', methods=['GET'])
def get_family_transactions():

    cursor = db.get_db().cursor()

    req_data = request.get_json()

    user_id = req_data['userID']

    cursor.execute('SELECT * FROM FamilyTransactions WHERE user_id = ' + str(user_id))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@family.route('/getDependents', methods=['GET'])
def get_dependents():
    cursor = db.get_db().cursor()
    req_data = request.get_json()

    user_id = req_data['userID']

    cursor.execute('SELECT * FROM Dependents WHERE user_id = ' + str(user_id))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# POST route that lets users register a dependent 
@family.route('/registerDependent', methods=['POST'])
def register_dependent():
    req_data = request.get_json()

    user_id = req_data['userID']
    dep_fname = req_data['fname']
    dep_lname = req_data['lname']
    dep_age = req_data['age']

    insert_stmt = 'INSERT INTO Dependents (user_id, fName, lName, age) VALUES (" '
    insert_stmt += str(user_id) + '", "' + dep_fname + '", "' + dep_lname + '", "' + str(dep_age) + '")'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"


# Simple GET route that gets given dependent's registered transactions
@family.route('/familyChild', methods=['GET'])
def get_family_transactions_w_dependent():

    cursor = db.get_db().cursor()

    req_data = request.get_json()

    user_id = req_data['userID']
    dep_id = req_data['depID']

    cursor.execute('SELECT * FROM FamilyTransactions WHERE dependent_id = ' + user_id + 'AND user_id = ' + str(dep_id))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# adding a POST route to register a new transaction
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

# Gets all the cards a user has registered
@family.route('/getCards', methods=['GET'])
def get_f_cards():

    cursor = db.get_db().cursor()

    req_data = request.get_json()

    user_id = req_data['userID']

    cursor.execute('SELECT * FROM Cards WHERE user_id = ' + str(user_id))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)

# Registers a new card for a user 
@family.route('/registerCard', methods=['POST'])
def register_f_card():
    req_data = request.get_json()

    user_id = req_data['userID']
    card_num = req_data['cardNum']
    sec_code = req_data['secCode']
    zip_num = req_data['zip']

    insert_stmt = 'INSERT INTO Cards (user_id, cardNum, secCode, zip) VALUES (" '
    insert_stmt += str(user_id) + '", "' + card_num + '", "' + sec_code + '", "' + zip_num + '")'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"

