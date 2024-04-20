from flask import Blueprint, request, jsonify, make_response
import json
from src import db

faculty_advisor = Blueprint('faculty_advisor', __name__)


# @faculty_advisor.route('/compliance_status/<int:club_id>', methods=['GET'])
# def check_compliance_status(club_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('SELECT complianceStatus FROM Club WHERE clubID = %s', (club_id,))
#     compliance = cursor.fetchone()
#     if compliance:
#         return jsonify(dict(zip([x[0] for x in cursor.description], compliance)))
#     else:
#         return make_response(jsonify({'error': 'Compliance data not found for this club'}), 404)



@faculty_advisor.route('/compliance_status', methods=['GET'])
def get_compliance_status():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT clubID, clubName, complianceStatus FROM Club')
    column_headers = [x[0] for x in cursor.description]
    compliance_data = cursor.fetchall()
    compliance_list = [dict(zip(column_headers, row)) for row in compliance_data]
    return jsonify(compliance_list)

# @faculty_advisor.route('/compliance_status/<int:club_id>', methods=['PUT'])
# def update_compliance_status(club_id):
#     compliance_data = request.json
#     if 'complianceStatus' not in compliance_data:
#         return make_response(jsonify({'error': 'Compliance status is required'}), 400)
#     cursor = db.get_db().cursor()
#     cursor.execute('UPDATE Club SET complianceStatus = %s WHERE clubID = %s',
#                    (compliance_data['complianceStatus'], club_id))
#     db.get_db().commit()
#     return 'Compliance status updated successfully'


@faculty_advisor.route('/compliance_status', methods=['PUT'])
def update_compliance():
    compliance_info = request.json

    club_id = compliance_info['clubID']
    compliance_status = compliance_info['complianceStatus']

    query = 'UPDATE Club SET complianceStatus = %s where clubID = %s'
    data = (compliance_status, club_id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'compliance updated'

@faculty_advisor.route('/compliance_status', methods=['POST'])
def insert_compliance_status():
    compliance_data = request.json
    if 'clubID' not in compliance_data or 'complianceStatus' not in compliance_data:
        return make_response(jsonify({'error': 'clubID and complianceStatus are required'}), 400)
    cursor = db.get_db().cursor()
    cursor.execute('INSERT INTO Club (clubID, complianceStatus) VALUES (%s, %s)',
                   (compliance_data['clubID'], compliance_data['complianceStatus']))
    db.get_db().commit()
    return 'Compliance status inserted successfully'

@faculty_advisor.route('/events', methods=['GET'])
def view_events():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Events WHERE date < CURRENT_DATE()')
    column_headers = [x[0] for x in cursor.description]
    events = cursor.fetchall()
    events_list = [dict(zip([x[0] for x in cursor.description], row)) for row in events]
    return jsonify(events_list)


# @faculty_advisor.route('/event/<int:event_id>', methods=['GET'])
# def get_event_details(event_id):
#     cursor = db.get_db().cursor()
#     cursor.execute('SELECT * FROM Events WHERE eventID = %s', (event_id,))
#     event = cursor.fetchone()
#     if event:
#         return jsonify(dict(zip([x[0] for x in cursor.description], event)))
#     else:
#         return make_response(jsonify({'error': 'Event not found'}), 404)

    
@faculty_advisor.route('/documents', methods=['GET'])
def list_documents():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Documents')
    column_headers = [x[0] for x in cursor.description]
    doc_data = cursor.fetchall()
    doc_list = [dict(zip(column_headers, row)) for row in doc_data]
    return jsonify(doc_list)


@faculty_advisor.route('/members', methods=['GET'])
def list_members():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Club_Members')
    column_headers = [x[0] for x in cursor.description]
    members_data = cursor.fetchall()
    members_list = [dict(zip(column_headers, row)) for row in members_data]
    return jsonify(members_list)



@faculty_advisor.route('/club_finances', methods=['GET'])
def get_club_finances():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Budget')
    column_headers = [x[0] for x in cursor.description]
    club_finances_data = cursor.fetchall()
    club_finances_list = [dict(zip(column_headers, row)) for row in club_finances_data]
    return jsonify(club_finances_list)

@faculty_advisor.route('/members', methods=['GET'])
def list_presidents():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Club_President')
    column_headers = [x[0] for x in cursor.description]
    president_data = cursor.fetchall()
    president_list = [dict(zip(column_headers, row)) for row in president_data]
    return jsonify(president_list)



@faculty_advisor.route('/update_notes', methods=['POST'])
def update_presidents_notes():
   note_data = request.json
   cursor = db.get_db().cursor()
   cursor.execute('INSERT INTO Documents (documnetTitle, dateCreated, datePosted) VALUES (%s, %s, CURRENT_DATE())',
                  (note_data['clubID'], note_data['noteContent']))
   db.get_db().commit()
   return 'Note updated successfully'