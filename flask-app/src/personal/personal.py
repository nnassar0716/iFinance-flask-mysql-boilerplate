from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

personal = Blueprint('personal', __name__)


# Registers a new card for a user 
@personal.route('/registerCategory', methods=['POST'])
def register_category():
    req_data = request.get_json()

    blank = req_data['Text1']

    cat_name = req_data['cat_name']

    insert_stmt = 'INSERT INTO Categories (name) VALUES (" '
    insert_stmt += cat_name + '")'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"

# Simple GET route that gets all registered categories
@personal.route('/categories', methods=['GET'])
def get_categories():

    cursor = db.get_db().cursor()

    cursor.execute('SELECT name AS label, category_id AS value FROM Categories')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Simple GET route that gets given user's personal transactions
@personal.route('/personal', methods=['GET'])
def get_personal_transactions():

    req_data = request.get_json()

    user_id = req_data['user_id']

    if user_id == '':
        user_id = 1

    query = 'SELECT * FROM PersonalTransactions WHERE user_id = {0}'.format(user_id)

    cursor = db.get_db().cursor()

    cursor.execute(query)

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Simple GET route that lists all personal transactions of given user in given category
@personal.route('/personalcat', methods=['GET'])
def get_personal_transactions_cat():

    req_data = request.get_json()

    user_id = req_data['user_id']
    cat_id = req_data['cat_id']

    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM PersonalTransactions WHERE user_id = {0}'.format(user_id) + ' AND category_id = {0}'.format(cat_id))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)

# Gets all the cards a user has registered
@personal.route('/getCards', methods=['GET'])
def get_cards():

    req_data = request.get_json()

    user_id = req_data['user_id']

    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM Cards WHERE user_id = {0}'.format(user_id))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)

# Registers a new card for a user 
@personal.route('/registerCard', methods=['POST'])
def register_card():
    req_data = request.get_json()

    ignor = req_data['label_ignor']
    userID = req_data['user_id']
    card_num = req_data['cardNum']
    sec_code = req_data['secCode']
    zip_num = req_data['zip']

    if userID == '':
        userID = str(1)
    if card_num == '':
        card_num = '3333'
    if sec_code == '':
        sec_code = str(4820)
    if zip_num == '':
        zip_num = str(0)

    insert_stmt = 'INSERT INTO Cards (user_id, cardNum, secCode, zip) VALUES (" '
    insert_stmt += '{0}'.format(userID) + '", "' + card_num + '", "' + sec_code + '", "' + zip_num + '")'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"


# POST route that lets users add new personal transactions 
@personal.route('/addPersonal', methods=['POST'])
def add_personal_transaction():
    req_data = request.get_json()

    ignore = req_data['register_personal_label']
    userID = req_data['user_id']
    transaction_amnt = req_data['amount']
    transaction_desc = req_data['description']
    transaction_cat = req_data['category']
    transaction_debcred = req_data['deb_cred']
    transaction_med = req_data['medium']

    if userID == '':
        userID = 1
    if transaction_cat == '':
        transaction_cat = 1
    if transaction_desc == '':
        transaction_desc = 'XXX'
    if transaction_debcred == '':
        transaction_debcred = True
    if transaction_med == '':
        transaction_med = 1

    insert_stmt = 'INSERT INTO PersonalTransactions (user_id, amount, description, category_id, debOrCred, medium_id) VALUES (' 
    insert_stmt += '{0}, {1}, "{2}", {3}, {4}, {5})'.format(userID, transaction_amnt, transaction_desc, transaction_cat, transaction_debcred, transaction_med)


    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"

# Gets all the mediums a user has registered
@personal.route('/getMediums', methods=['GET'])
def get_mediums():

    cursor = db.get_db().cursor()

    req_data = request.get_json()

    userID = req_data['user_id']

    if userID == '':
        userID = '1'

    cursor.execute('SELECT name AS label, medium_id AS value FROM Mediums WHERE user_id = {0}'.format(userID))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)


# Registers a new medium for a user 
@personal.route('/registerMedium', methods=['POST'])
def register_medium():
    req_data = request.get_json()

    userID = req_data['userID']
    blank = req_data['text1']
    medium_name = req_data['m_name']
    card_num = req_data['cardNum']

    if str(card_num) == '':
        card_num = str(0000)

    if str(userID) == '':
        insert_stmt = 'INSERT INTO Mediums (user_id, name, cardNum) VALUES ("'
        insert_stmt += str(1) + '", "' + medium_name + '", "' + str(card_num) + '")'
    else:
        insert_stmt = 'INSERT INTO Mediums (user_id, name, cardNum) VALUES ("'
        insert_stmt += str(userID) + '", "' + medium_name + '", "' + str(card_num) + '")'

    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"

# Deletes an already existing medium of payment
@personal.route('/deleteMedium', methods=['DELETE'])
def delete_medium():

    req_data = request.get_json()

    user_id = req_data['user_id']
    med_id = req_data['med_id']

    cursor = db.get_db().cursor()

    cursor.execute('DELETE FROM Mediums WHERE user_id = {0}'.format(user_id) + ' AND medium_id = {0}'.format(med_id))

    db.get_db().commit()
    return "Success"


@personal.route('/getCardNums', methods=['GET'])
def get_id():

    cursor = db.get_db().cursor()

    req_data = request.get_json()

    userID = req_data['userID']

    if userID == '':
        userID = str(1)

    cursor.execute('SELECT cardNum AS label, cardNum AS value FROM Cards WHERE user_id = {0}'.format(userID))

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)
