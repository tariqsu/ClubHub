from flask import Blueprint, request, jsonify
import json
from src import db

club_president = Blueprint('club_president', __name__)

@club_president.route('/club_finances', methods=['GET'])
def get_club_finances():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Budget')
    column_headers = [x[0] for x in cursor.description]
    club_finances_data = cursor.fetchall()
    club_finances_list = [dict(zip(column_headers, row)) for row in club_finances_data]
    return jsonify(club_finances_list)

@club_president.route('/club_finances', methods=['PUT'])
def update_club_finances():
    total_club_budget = request.json.get('totalClubBudget')
    if total_club_budget is None:
        return 'Missing totalClubBudget', 400
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE Budget SET totalClubBudget = %s WHERE accountNumber = %s',
                   (total_club_budget, request.json.get('accountNumber')))
    db.get_db().commit()
    return 'Success', 200

@club_president.route('/members', methods=['GET'])
def list_members():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Club_Members')
    column_headers = [x[0] for x in cursor.description]
    members_data = cursor.fetchall()
    members_list = [dict(zip(column_headers, row)) for row in members_data]
    return jsonify(members_list)

@club_president.route('/events', methods=['POST'])
def create_event():
    event_info = request.json
    
    date = event_info['date']
    event_id = event_info['eventID']
    eventName = event_info['eventName']

    query = 'INSERT INTO Events (date, eventID, eventName) values (%s, %s, %s)'
    data= (date, event_id, eventName)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'event inserted'


@club_president.route('/events', methods=['PUT'])
def update_event():
    event_info= request.json
    
    event_id = event_info['eventID']
    name = event_info['eventName']

    query = 'UPDATE Events SET eventName = %s where eventID = %s'
    data= (name, event_id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'event updated'


@club_president.route('/events/<int:event_id>', methods=['DELETE'])
def delete_event(event_id):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM Events WHERE eventID = %s', (event_id,))
    db.get_db().commit()
    return 'Success', 200

@club_president.route('/faculty/<string:email>', methods=['DELETE'])
def remove_faculty(email):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM Faculty WHERE email = %s', (email,))
    db.get_db().commit()
    return 'Success', 200

@club_president.route('/faculty', methods=['GET'])
def list_faculty():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Faculty')
    column_headers = [x[0] for x in cursor.description]
    faculty_data = cursor.fetchall()
    faculty_list = [dict(zip(column_headers, row)) for row in faculty_data]
    return jsonify(faculty_list)

@club_president.route('/faculty', methods=['PUT'])
def update_faculty():
    faculty_info= request.json

    club_id = faculty_info['clubID']
    email = faculty_info['email']

    query = 'UPDATE Faculty SET clubID = %s where email = %s'
    data= (club_id, email)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'faculty updated'

@club_president.route('/faculty', methods=['POST'])
def post_faculty():
    faculty_info = request.json

    club_id = faculty_info['clubID']
    first = faculty_info['firstName']
    last = faculty_info['lastName']
    email = faculty_info['email']

    query = 'INSERT INTO Faculty (firstName, lastName, clubID, email) values (%s, %s, %s, %s)'
    data= (first, last, club_id, email)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'faculty inserted'