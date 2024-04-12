from flask import Blueprint, request, jsonify, make_response, current_app
from src import db

faculty_advisor = Blueprint('faculty_advisor', __name__)

@faculty_advisor.route('/events', methods=['GET'])
def view_events():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT id, eventName, eventDate, location FROM events WHERE eventDate >= CURRENT_DATE()')
    events = cursor.fetchall()
    events_list = [dict(zip([x[0] for x in cursor.description], row)) for row in events]
    return jsonify(events_list)

@faculty_advisor.route('/event/<int:event_id>', methods=['GET'])
def get_event_details(event_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM events WHERE id = %s', (event_id,))
    event = cursor.fetchone()
    if event:
        return jsonify(dict(zip([x[0] for x in cursor.description], event)))
    else:
        return make_response(jsonify({'error': 'Event not found'}), 404)

@faculty_advisor.route('/presidents_notes/<int:club_id>', methods=['GET'])
def access_presidents_notes(club_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT id, noteContent, datePosted FROM presidents_notes WHERE clubID = %s', (club_id,))
    notes = cursor.fetchall()
    if notes:
        return jsonify([dict(zip([x[0] for x in cursor.description], row)) for row in notes])
    else:
        return make_response(jsonify({'error': 'No notes found for this club'}), 404)

@faculty_advisor.route('/update_notes', methods=['POST'])
def update_presidents_notes():
    note_data = request.json
    cursor = db.get_db().cursor()
    cursor.execute('INSERT INTO presidents_notes (clubID, noteContent, datePosted) VALUES (%s, %s, CURRENT_DATE())',
                   (note_data['clubID'], note_data['noteContent']))
    db.get_db().commit()
    return 'Note updated successfully'

@faculty_advisor.route('/compliance_status/<int:club_id>', methods=['GET'])
def check_compliance_status(club_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT clubID, isCompliant, lastChecked FROM compliance WHERE clubID = %s', (club_id,))
    compliance = cursor.fetchone()
    if compliance:
        return jsonify(dict(zip([x[0] for x in cursor.description], compliance)))
    else:
        return make_response(jsonify({'error': 'Compliance data not found for this club'}), 404)

@faculty_advisor.route('/club_reports/<int:club_id>', methods=['GET'])
def view_club_reports(club_id):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT reportID, reportDetails, dateGenerated FROM club_reports WHERE clubID = %s', (club_id,))
    reports = cursor.fetchall()
    if reports:
        return jsonify([dict(zip([x[0] for x in cursor.description], row)) for row in reports])
    else:
        return make_response(jsonify({'error': 'No reports found for this club'}), 404)
