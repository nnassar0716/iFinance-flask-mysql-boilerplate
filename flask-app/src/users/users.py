from flask import Blueprint, request, jsonify, make_response
import json
from src import db

users = Blueprint('users', __name__)

# Simple GET route that gets all users currently registered
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

# adding a POST route to register a new user
@users.route('/registerUser', methods=['POST'])
def register_user():
    req_data = request.get_json()

    user_label = req_data['new_user_label']

    user_fname = req_data['fname']
    user_lname = req_data['lname']
    user_street = req_data['street_line']
    user_city = req_data['city']
    user_state = req_data['state']
    user_country = req_data['country']

    insert_stmt = 'INSERT INTO Users (fName, lName, address, city, state, country) VALUES ("'
    insert_stmt += user_fname + '", "' + user_lname + '", "' + user_street + '", "' + user_city + '", "' + user_state + '", "' + user_country + '")'


    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return "Success"

# Simple GET route that gets all users names currently registered
@users.route('/usernames', methods=['GET'])
def get_usernames():

    cursor = db.get_db().cursor()

    cursor.execute("SELECT CONCAT(fName, ' ', lName) AS label, user_id AS value FROM Users")

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Deletes an already existing user
@users.route('/deleteUser', methods=['DELETE'])
def delete_user():
    req_data = request.get_json()

    user_id = req_data['user_id']
    if user_id == '':
        user_id = 1

    delete_stmt = 'DELETE FROM Users where user_id ={0}'.format(user_id)

    cursor = db.get_db().cursor()

    cursor.execute(delete_stmt)

    db.get_db().commit()
    return "Success"

# Allows user to edit their address
@users.route('/editAddress', methods=['PUT'])
def change_address():
    req_data = request.get_json()

    ignore = req_data['text']
    user_id = req_data['user_id']
    user_street = req_data['street']
    user_city = req_data['c']
    user_state = req_data['state']
    user_country = req_data['country']

    if user_id == '':
        user_id = 1
    if user_street == '':
        user_street = 'street'
    if user_city == '':
        user_city = 'boston'
    if user_state == '':
        user_state = 'massachusetts'
    if user_country == '':
        user_country = 'USA'

    update_stmt = "UPDATE Users SET address = '" + user_street + "', city = '" + user_city + "', state = '"
    update_stmt += user_state + "', country = '" + user_country + "' WHERE user_id = {0}".format(user_id)

    cursor = db.get_db().cursor()
    cursor.execute(update_stmt)
    db.get_db().commit()
    return "Success"