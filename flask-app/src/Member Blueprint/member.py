from flask import Blueprint, request, jsonify, make_response, abort
from src import db  # Replace with your actual database connection module

members = Blueprint('members', __name__)

@members.route('/members', methods=['GET'])
def list_members():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT id, firstName, lastName, status FROM members')
    column_headers = [x[0] for x in cursor.description]
    members_data = cursor.fetchall()
    members_list = [dict(zip(column_headers, row)) for row in members_data]
    return jsonify(members_list)

@members.route('/members/<int:member_id>', methods=['GET'])
def view_profile(member_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT id, firstName, lastName, email, major FROM members WHERE id = %s', (member_id,))
    column_headers = [x[0] for x in cursor.description]
    member_data = cursor.fetchone()
    if member_data:
        return jsonify(dict(zip(column_headers, member_data)))
    else:
        return 'Member not found', 404

@members.route('/members/<int:member_id>', methods=['PUT'])
def update_profile(member_id):
    profile_data = request.json
    query = 'UPDATE members SET firstName = %s, lastName = %s, email = %s, major = %s WHERE id = %s'
    data = (profile_data['firstName'], profile_data['lastName'], profile_data['email'], profile_data['major'], member_id)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'Profile updated successfully'

@members.route('/members', methods=['POST'])
def create_profile():
    profile_data = request.json
    query = 'INSERT INTO members (firstName, lastName, email, major) VALUES (%s, %s, %s, %s)'
    data = (profile_data['firstName'], profile_data['lastName'], profile_data['email'], profile_data['major'])
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'Profile created successfully', 201

@members.route('/members/<int:member_id>', methods=['DELETE'])
def remove_member(member_id):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM members WHERE id = %s', (member_id,))
    db.get_db().commit()
    return 'Member removed successfully'

@members.route('/job_board', methods=['GET'])
def job_board_get():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM job_board')
    column_headers = [x[0] for x in cursor.description]
    job_data = cursor.fetchall()
    jobs_list = [dict(zip(column_headers, row)) for row in job_data]
    return jsonify(jobs_list)

@members.route('/job_board', methods=['POST'])
def job_board_post():
    job_data = request.json
    member_id = job_data.get('memberID')
    if not member_id:
        return 'Missing member ID', 400
    
    cursor = db.get_db().cursor()
    cursor.execute('SELECT status FROM members WHERE id = %s', (member_id,))
    member_status = cursor.fetchone()
    if member_status and member_status[0] == 'alumni_member':
        query = 'INSERT INTO job_board (title, description, company, memberID) VALUES (%s, %s, %s, %s)'
        data = (job_data['title'], job_data['description'], job_data['company'], member_id)
        cursor.execute(query, data)
        db.get_db().commit()
        return 'Job posting created successfully', 201
    else:
        return 'Only alumni members can post jobs', 403

@members.route('/events', methods=['GET'])
def events():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM events WHERE date >= CURRENT_DATE()')
    column_headers = [x[0] for x in cursor.description]
    event_data = cursor.fetchall()
    events_list = [dict(zip(column_headers, row)) for row in event_data]
    return jsonify(events_list)

@members.route('/events/registration', methods=['POST'])
def register_event():
    registration_data = request.json
    member_id = registration_data.get('memberID')
    event_id = registration_data.get('eventID')
    if not member_id or not event_id:
        return 'Missing registration data', 400

    cursor = db.get_db().cursor()
    cursor.execute('SELECT status FROM members WHERE id = %s', (member_id,))
    member_status = cursor.fetchone()
    if member_status and member_status[0] == 'current_member':
        query = 'INSERT INTO event_registrations (memberID, eventID) VALUES (%s, %s)'
        data = (member_id, event_id)
        cursor.execute(query, data)
        db.get_db().commit()
        return 'Registration successful', 201
    else:
        return 'Only current members can register for events', 403
