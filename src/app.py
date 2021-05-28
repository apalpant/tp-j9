from flask import Flask, render_template, request, jsonify     
import hashlib

app = Flask(__name__)

@app.route("/md5", methods=['GET', 'POST'])
def get_md5():
    if request.method == 'POST':
        param = request.form['param']
        
        hash_object = hashlib.md5(param.encode())
        hex_dig = hash_object.hexdigest()

        return jsonify(
                hash="md5",
                cleartext=param,
                hashedtext=hex_dig
        )

    return render_template('index.html')
    
@app.route("/sha256", methods=[GET', 'POST'])
def get_sha256():
    if request.method == 'POST':
        param = request.form['param']

        hash_object = hashlib.sha256(param.encode())
        hex_dig = hash_object.hexdigest()

        return jsonify(
            hash="sha256",
            cleartext=param,
            hashedtext=hex_dig
        )
    return render_template('index.html')
    