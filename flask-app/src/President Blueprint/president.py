from flask import Blueprint, request, current_app
from src import db

club_president = Blueprint('club_president', __name__)

@club_president.route('/club_finances', methods=['GET'])
def get_club_finances():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM finances')
    finances = cursor.fetchall()
    return {'finances': finances}, 200

@club_president.route('/club_finances', methods=['PUT'])
def update_club_finances():
    total_club_budget = request.json.get('totalClubBudget')
    if total_club_budget is None:
        return 'Missing totalClubBudget', 400
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE finances SET totalClubBudget = %s WHERE clubID = %s',
                   (total_club_budget, request.json.get('clubID')))
    db.get_db().commit()
    return 'Success', 200

@club_president.route('/members', methods=['GET'])
def list_members():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM members')
    members = cursor.fetchall()
    return {'members': members}, 200

@club_president.route('/events', methods=['POST'])
def create_event():
    event_name = request.json.get('eventName')
    date = request.json.get('date')
    location = request.json.get('location')
    if not event_name or not date or not location:
        return 'Incomplete event details', 400
    cursor = db.get_db().cursor()
    cursor.execute('INSERT INTO events (eventName, date, location) VALUES (%s, %s, %s)',
                   (event_name, date, location))
    db.get_db().commit()
    return 'Success', 201

@club_president.route('/events', methods=['PUT'])
def update_event():
    event_id = request.json.get('eventID')
    if not event_id:
        return 'Missing eventID', 400
    event_name = request.json.get('eventName')
    date = request.json.get('date')
    location = request.json.get('location')
    cursor = db.get_db().cursor()
    cursor.execute('UPDATE events SET eventName = %s, date = %s, location = %s WHERE eventID = %s',
                   (event_name, date, location, event_id))
    db.get_db().commit()
    return 'Success', 200

@club_president.route('/events/<int:event_id>', methods=['DELETE'])
def delete_event(event_id):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM events WHERE eventID = %s', (event_id,))
    db.get_db().commit()
    return 'Success', 200

@club_president.route('/members/<int:member_id>', methods=['DELETE'])
def remove_member(member_id):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM members WHERE memberID = %s', (member_id,))
    db.get_db().commit()
    return 'Success', 200
