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

    cursor.execute("SELECT CONCAT(fName, ' ', lName) AS label, CONCAT(fName, ' ', lName) AS value FROM Users")

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Deletes an already existing user
@users.route('deleteUser/<userID>', methods=['DELETE'])
def delete_user(userID):
    cursor = db.get_db().cursor()

    cursor.execute('DELETE FROM Users WHERE user_id = {0}'.format(userID))

    db.get_db().commit()
    return "Success"