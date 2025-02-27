from flask import Blueprint, Flask, request, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from flask_cors import CORS
import jwt
import datetime

app = Flask(__name__)
CORS(app)  # CORS desteği eklendi
app.config['SECRET_KEY'] = 'melahat_basar'

users = {
    "user@example.com": {
        "password": generate_password_hash("password123"),
        "firstName": "John",
        "lastName" : "Doe",
    }
}


@app.route('/ping', methods=['GET'])
def ping():
    return jsonify({"message": "pong"}), 200


@app.route('/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({"success": "false", "message": "Email ve şifre gerekli!"}), 400

    user = users.get(email)
    if not user or not check_password_hash(user['password'], password):
        return jsonify({"success": "false", "message": "Geçersiz email veya şifre!"}), 401

    # Kullanıcı doğrulandı, JWT oluştur
    token = jwt.encode(
        {
        'email': email,
        'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=1)  # 1 saat geçerli
        }, 
        app.config['SECRET_KEY'],
          algorithm='HS256'
    )

    return jsonify({"success": "true", "token": token})



@app.route('/getUserInfo', methods=['GET'])
def get_user_info():
    token = request.headers.get('Authorization')

    if not token:
        return jsonify({"success": "false", "message": "Token gerekli!"}), 401

    try:
        data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        email = data.get('email')

        user = users.get(email)
        if not user:
            return jsonify({"success": "false", "message": "Kullanici bulunamadi!"}), 404

        return jsonify({
            "success": "true",
            "data": {
                "email": email,
                "firstName": user['firstName'],
                "lastName": user['lastName']
            }
        })
    except jwt.ExpiredSignatureError:
        return jsonify({"success": "false", "message": "Token süresi dolmuş!"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"success": "false", "message": "Geçersiz token!"}), 401


@app.route('/register', methods=['POST'])
def register():
    data = request.json
    firstName = data.get('firstName')
    lastName = data.get('lastName')
    email = data.get('email')
    password = data.get('password')

    if not email or not password or not firstName or not lastName:
    
        return jsonify({"success": "false", "message": "Email ve şifre gerekli!"}), 400
        
    if email in users:
      
        return jsonify({"success": "false", "message": "Bu email zaten kayıtlı."}), 400
        
    else:
        users[email] = {
                "password": generate_password_hash(password),
                "firstName": firstName,
                "lastName": lastName,
            }
        
    
    return jsonify({"success": "true", "message": "Register completed."}), 200



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
