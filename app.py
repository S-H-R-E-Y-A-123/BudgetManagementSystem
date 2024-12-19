from flask import Flask, render_template, request, redirect, url_for, flash, jsonify, session
import mysql.connector
import os
from dotenv import load_dotenv
from flask_cors import CORS

# Initialize Flask app and CORS
app = Flask(__name__)
CORS(app)

# Load environment variables from .env
load_dotenv()

# Set secret key for session management
app.secret_key = os.getenv("SECRET_KEY")

# Database configuration from environment variables
db_config = {
    'host': os.getenv("DB_HOST", "localhost"),
    'user': os.getenv("DB_USER", "root"),
    'password': os.getenv("DB_PASSWORD", "heyheyhey2424!"),
    'database': os.getenv("DB_NAME", "project")
}

# Helper function to get a database connection
def get_db_connection():
    try:
        conn = mysql.connector.connect(**db_config)
        return conn
    except mysql.connector.Error as e:
        print(f"Error: {e}")
        flash(f"Database connection failed: {e}", "danger")
        return None

# Dashboard route (default page)
@app.route('/')
@app.route('/dashboard')
def dashboard():
    conn = get_db_connection()
    if not conn:
        flash("Database connection failed", "danger")
        return render_template("dashboard.html")

    try:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM income")
        income_records = cursor.fetchall()
        cursor.execute("SELECT * FROM goals")
        goal_records = cursor.fetchall()
        return render_template('dashboard.html', income=income_records, goals=goal_records)
    except mysql.connector.Error as e:
        flash(f"Error fetching data: {e}", "danger")
    finally:
        conn.close()

# Expenditures page
@app.route('/expenditures', methods=['GET', 'POST'])
def expenditures():
    conn = get_db_connection()
    if not conn:
        flash("Database connection failed", "danger")
        return render_template("expenditures.html")

    if request.method == 'POST':
        amount = request.form.get('amount')
        category = request.form.get('category')
        description = request.form.get('description')
        if not amount or not category or not description:
            flash("Please provide all fields: amount, category, and description", "warning")
            return redirect(url_for('expenditures'))
        
        try:
            cursor = conn.cursor()
            cursor.execute("INSERT INTO expenditures (amount, category, description) VALUES (%s, %s, %s)", 
                           (amount, category, description))
            conn.commit()
            flash("Expenditure added successfully", "success")
        except mysql.connector.Error as e:
            flash(f"Failed to add expenditure: {e}", "danger")
        finally:
            conn.close()

        return redirect(url_for('expenditures'))

    else:
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM expenditures")
            expenditure_records = cursor.fetchall()
            return render_template('expenditures.html', expenditures=expenditure_records)
        except mysql.connector.Error as e:
            flash(f"Error fetching expenditure records: {e}", "danger")
        finally:
            conn.close()

# Income page
@app.route('/income', methods=['GET', 'POST'])
def income():
    conn = get_db_connection()
    if not conn:
        flash("Database connection failed", "danger")
        return render_template("income.html")

    if request.method == 'POST':
        amount = request.form.get('amount')
        source = request.form.get('source')
        if not amount or not source:
            flash("Please provide both source and amount", "warning")
            return redirect(url_for('income'))

        try:
            cursor = conn.cursor()
            cursor.execute("INSERT INTO income (amount, source) VALUES (%s, %s)", (amount, source))
            conn.commit()
            flash("Income added successfully", "success")
        except mysql.connector.Error as e:
            flash(f"Failed to add income: {e}", "danger")
        finally:
            conn.close()

        return redirect(url_for('income'))

    else:
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM income")
            income_records = cursor.fetchall()
            return render_template('income.html', income=income_records)
        except mysql.connector.Error as e:
            flash(f"Error fetching income records: {e}", "danger")
        finally:
            conn.close()

# Goals page
@app.route('/goals', methods=['GET', 'POST'])
def goals():
    conn = get_db_connection()
    if not conn:
        flash("Database connection failed", "danger")
        return render_template("goals.html")

    if request.method == 'POST':
        target_amount = request.form.get('target_amount')
        current_amount = request.form.get('current_amount')
        start_date = request.form.get('start_date')
        due_date = request.form.get('due_date')
        if not (target_amount and current_amount and start_date and due_date):
            flash("All fields are required", "warning")
            return redirect(url_for('goals'))

        try:
            cursor = conn.cursor()
            cursor.execute(""" 
                INSERT INTO goals (target_amount, current_amount, start_date, due_date) 
                VALUES (%s, %s, %s, %s)
            """, (target_amount, current_amount, start_date, due_date))
            conn.commit()
            flash("Goal added successfully", "success")
        except mysql.connector.Error as e:
            flash(f"Failed to add goal: {e}", "danger")
        finally:
            conn.close()

        return redirect(url_for('goals'))

    else:
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM goals")
            goal_records = cursor.fetchall()
            return render_template('goals.html', goals=goal_records)
        except mysql.connector.Error as e:
            flash(f"Error fetching goals: {e}", "danger")
        finally:
            conn.close()

# Wishlist page
@app.route('/wishlist', methods=['GET', 'POST'])
def wishlist():
    conn = get_db_connection()
    if not conn:
        flash("Database connection failed", "danger")
        return render_template("wishlist.html")

    if request.method == 'POST':
        item_name = request.form.get('item_name')
        item_price = request.form.get('item_price')
        if not item_name or not item_price:
            flash("Please provide both item name and price", "warning")
            return redirect(url_for('wishlist'))

        try:
            cursor = conn.cursor()
            cursor.execute("INSERT INTO wishlist (item_name, item_price) VALUES (%s, %s)", (item_name, item_price))
            conn.commit()
            flash("Item added to wishlist", "success")
        except mysql.connector.Error as e:
            flash(f"Failed to add item to wishlist: {e}", "danger")
        finally:
            conn.close()

        return redirect(url_for('wishlist'))

    else:
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM wishlist")
            wishlist_items = cursor.fetchall()
            return render_template('wishlist.html', wishlist=wishlist_items)
        except mysql.connector.Error as e:
            flash(f"Error fetching wishlist items: {e}", "danger")
        finally:
            conn.close()

if __name__ == '__main__':
    app.run(debug=True)

