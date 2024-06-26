from flask import Blueprint, request, jsonify, current_app
import json
from src import db  # Replace with your actual database connection module

members = Blueprint('members', __name__)

@members.route('/members', methods=['GET'])
def list_members():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Club_Members')
    column_headers = [x[0] for x in cursor.description]
    members_data = cursor.fetchall()
    members_list = [dict(zip(column_headers, row)) for row in members_data]
    return jsonify(members_list)

# @members.route('/members/<int:member_id>', methods=['GET'])
# def view_profile(member_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('SELECT * FROM Club_Members WHERE id = %s', (member_id,))
#     column_headers = [x[0] for x in cursor.description]
#     member_data = cursor.fetchone()
#     if member_data:
#         return jsonify(dict(zip(column_headers, member_data)))
#     else:
#         return 'Member not found', 404

@members.route('/members/<int:member_id>', methods=['PUT'])
def update_profile(member_id):
    profile_data = request.json
    query = 'UPDATE Club_Members SET firstName = %s, lastName = %s, email = %s, major = %s WHERE id = %s'
    data = (profile_data['firstName'], profile_data['lastName'], profile_data['email'], profile_data['major'], member_id)
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'Profile updated successfully'

@members.route('/members', methods=['POST'])
def create_member():
    profile_data = request.json
    query = 'INSERT INTO Club_Members (email, clubID, position, phoneNumber, firstName, lastName, status, memberID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'
    data = (profile_data['email'], profile_data['clubID'], profile_data['position'], profile_data['phoneNumber'],
            profile_data['firstName'], profile_data['lastName'], profile_data['status'], profile_data['memberID'])
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    return 'Member created successfully', 201

@members.route('/members/<int:member_id>', methods=['DELETE'])
def remove_member(member_id):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE FROM Club_Members WHERE id = %s', (member_id,))
    db.get_db().commit()
    return 'Member removed successfully'

@members.route('/job_board', methods=['GET'])
def job_board_get():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Club_Network_Job_Board')
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
    cursor.execute('SELECT status FROM Club_Members WHERE memberID = %s', (member_id,))
    member_status = cursor.fetchone()
    if member_status and member_status[0] == 'alumni_member':
        query = 'INSERT INTO Club_Network_Job_Board (roleID, clubID, companyDescription, roleDescription, positionName, companyName) VALUES (%s, %s, %s, %s, %s, %s)'
        data = (job_data['roleID'], job_data['clubID'], job_data['companyDescription'], 
                job_data['roleDescription'], job_data['positionName'], job_data['companyName'])
        cursor.execute(query, data)
        db.get_db().commit()
        return 'Job posting created successfully', 201
    else:
        return 'Only alumni members can post jobs', 403


@members.route('/events', methods=['GET'])
def events():
    current_app.logger.info("/a/events route")
    cursor = db.get_db().cursor()
    cursor.execute('SELECT eventID, date, eventName FROM Events WHERE date <= CURRENT_DATE()')
    column_headers = [x[0] for x in cursor.description]
    event_data = cursor.fetchall()
    events_list = [dict(zip(column_headers, row)) for row in event_data]
    return jsonify(events_list)


@members.route('/club_finances', methods=['GET'])
def get_club_finances():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Budget')
    column_headers = [x[0] for x in cursor.description]
    club_finances_data = cursor.fetchall()
    club_finances_list = [dict(zip(column_headers, row)) for row in club_finances_data]
    return jsonify(club_finances_list)


@members.route('/faculty', methods=['GET'])
def list_faculty():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Faculty')
    column_headers = [x[0] for x in cursor.description]
    faculty_data = cursor.fetchall()
    faculty_list = [dict(zip(column_headers, row)) for row in faculty_data]
    return jsonify(faculty_list)


@members.route('/events/registration', methods=['POST'])
def register_event():
    registration_data = request.json
    email = registration_data.get('email')
    event_id = registration_data.get('eventID')
    if not email or not event_id:
        return 'Missing registration data', 400

    cursor = db.get_db().cursor()
    cursor.execute('SELECT status FROM Club_Members WHERE email = %s', (email,))
    member_status = cursor.fetchone()
    if email and member_status[0] == 'current_member':
        query = 'INSERT INTO event_registrations (memberID, eventID) VALUES (%s, %s)'
        data = (email, event_id)
        cursor.execute(query, data)
        db.get_db().commit()
        return 'Registration successful', 201
    else:
        return 'Only current members can register for events', 403
