from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector

app = Flask(__name__)
app.secret_key = 'Azka123'

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'db_sekolah_mazkasn'
}

def get_db_connection():
    return mysql.connector.connect(**db_config)


@app.route('/')
def index():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT s.NIS, s.nama, s.alamat, s.Jenis_Kelamin, k.nama_kelas
            FROM tbl_siswa_azka s
            INNER JOIN tbl_kelas_azka k ON s.id_kelas = k.id_kelas
        """)
        siswa = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('index.html', siswa=siswa)
    except Exception as e:
        return f"<h3 style='color:red'>Gagal koneksi ke database: {e}</h3>"


@app.route('/data_nilai')
def data_nilai():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT s.nama, m.nama_mapel, n.nilai_harian, n.nilai_uts, n.nilai_uas,
                   ((n.nilai_harian + n.nilai_uts + n.nilai_uas)/3) AS nilai_akhir
            FROM tbl_nilai_azka n
            INNER JOIN tbl_siswa_azka s ON n.NIS = s.NIS
            INNER JOIN tbl_mapel_azka m ON n.id_mapel = m.id_mapel
        """)
        siswa = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('data_nilai.html', siswa=siswa)
    except Exception as e:
        return f"<h3 style='color:red'>Gagal koneksi ke database: {e}</h3>"

@app.route('/Guru')
def Guru():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
           SELECT s.nama_guru, s.alamat, k.nama_kelas
            FROM tbl_guru_Azka s
            INNER JOIN tbl_kelas_azka k ON k.nama_kelas = k.nama_kelas
        """)
        siswa = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('Guru.html', siswa=siswa)
    except Exception as e:
        return f"<h3 style='color:red'>Gagal koneksi ke database: {e}</h3>"


@app.route('/kelas')
def kelas():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT s.nama_kelas, s.wali_kelas, s.jurusan, s.jumlah_siswa, k.nama_guru
            FROM tbl_kelas_azka s
            INNER JOIN tbl_guru_azka k ON k.nama_guru = k.nama_guru
        """)
        siswa = cursor.fetchall()

        cursor.execute("SELECT * FROM tbl_guru_azka")
        guru = cursor.fetchall()

        cursor.close()
        conn.close()
        return render_template('kelas.html', siswa=siswa, guru=guru)
    except Exception as e:
        return f"<h3 style='color:red'>Gagal koneksi ke database: {e}</h3>"


@app.route('/proses', methods=['POST'])
def proses():
    AzkaNis = request.form['AzkaNis']
    AzkaKelas = request.form['AzkaKelas']
    Azkanama = request.form['Azkanama']
    Azkaalamat = request.form['Azkaalamat']
    AzkaJenis_Kelamin = request.form['AzkaJenis_Kelamin']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM tbl_siswa_azka WHERE NIS = %s", (AzkaNis,))
    cek = cursor.fetchone()

    if cek:
        flash(f'NIS {AzkaNis} sudah terdaftar!', 'error')
        cursor.close()
        conn.close()
        return redirect(url_for('index'))

    cursor.execute("""
        INSERT INTO tbl_siswa_azka (NIS,id_kelas, nama, alamat, Jenis_Kelamin)
        VALUES (%s, %s, %s, %s, %s)
    """, (AzkaNis,AzkaKelas, Azkanama, Azkaalamat, AzkaJenis_Kelamin))
    conn.commit()
    cursor.close()
    conn.close()

    flash('Data siswa berhasil disimpan!', 'success')
    return redirect(url_for('index'))


@app.route('/proses_nilai', methods=['POST'])
def proses_nilai():
    AzkaNis = request.form['AzkaNis']
    AzkaMapel = request.form['AzkaMapel']
    AzkaJam = request.form['AzkaJam']
    AzkaHarian = request.form['AzkaHarian']
    AzkaUTS = request.form['AzkaUTS']
    AzkaUAS = request.form['AzkaUAS']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("SELECT id_mapel FROM tbl_mapel_azka WHERE nama_mapel = %s", (AzkaMapel,))
        data_mapel = cursor.fetchone()

        if data_mapel:
            id_mapel = data_mapel['id_mapel']
        else:
            cursor.execute("INSERT INTO tbl_mapel_azka (nama_mapel, jumlah_jam) VALUES (%s, %s)",
                           (AzkaMapel, AzkaJam))
            conn.commit()
            id_mapel = cursor.lastrowid

        cursor.execute("""
            INSERT INTO tbl_nilai_azka (NIS, id_mapel, nilai_harian, nilai_uts, nilai_uas)
            VALUES (%s, %s, %s, %s, %s)
        """, (AzkaNis, id_mapel, AzkaHarian, AzkaUTS, AzkaUAS))
        conn.commit()

        flash('Data nilai dan mapel berhasil disimpan!', 'success')

    except Exception as e:
        conn.rollback()
        flash(f'Terjadi kesalahan saat menyimpan data: {e}', 'error')

    cursor.close()
    conn.close()

    return redirect(url_for('data_nilai'))


@app.route('/proses_kelas', methods=['POST'])
def proses_kelas():
    AzkaKelas = request.form['AzkaKelas']
    AzkaWalas = request.form['AzkaWalas']
    AzkaJurusan = request.form['AzkaJurusan']
    AzkaSiswa = request.form['AzkaSiswa']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("SELECT id_guru FROM tbl_guru_azka WHERE nama_guru = %s", (AzkaWalas,))
        data_guru = cursor.fetchone()

        if data_guru:
            id_guru = data_guru['id_guru']
        else:
            cursor.execute("INSERT INTO tbl_guru_azka (nama_guru) VALUES (%s)", (AzkaWalas,))
            conn.commit()
            id_guru = cursor.lastrowid

        cursor.execute("""
            INSERT INTO tbl_kelas_azka (nama_kelas, wali_kelas, jurusan, jumlah_siswa, id_guru)
            VALUES (%s, %s, %s, %s, %s)
        """, (AzkaKelas, AzkaWalas, AzkaJurusan, AzkaSiswa, id_guru))
        conn.commit()

        flash('Data kelas berhasil disimpan!', 'success')

    except Exception as e:
        conn.rollback()
        flash(f'Terjadi kesalahan saat menyimpan data: {e}', 'error')

    cursor.close()
    conn.close()

    return redirect(url_for('kelas'))


@app.route('/delete', methods=['POST'])
def delete():
    AzkaNis = request.form.get('AzkaNis')
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM tbl_siswa_azka WHERE NIS = %s", (AzkaNis,))
    conn.commit()
    cursor.close()
    conn.close()
    flash(f'Data dengan NIS {AzkaNis} berhasil dihapus.')
    return redirect(url_for('index'))

@app.route('/edit/<nis>')
def edit_form(nis):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM tbl_siswa_azka WHERE NIS = %s", (nis,))
    siswa_edit = cursor.fetchone()

    cursor.execute("SELECT * FROM tbl_siswa_azka")
    semua_siswa = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('index.html', siswa=semua_siswa, siswa_edit=siswa_edit)


@app.route('/update', methods=['POST'])
def update():
    AzkaNis = request.form['AzkaNis']
    Azkanama = request.form['Azkanama']
    AzkaKelas = request.form['AzkaKelas']
    Azkaalamat = request.form['Azkaalamat']
    AzkaJenis_Kelamin = request.form['AzkaJenis_Kelamin']

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE tbl_siswa_azka 
        SET nama=%s, alamat=%s,id_kelas, Jenis_Kelamin=%s 
        WHERE NIS=%s
    """, (Azkanama, Azkaalamat,AzkaKelas, AzkaJenis_Kelamin, AzkaNis))
    conn.commit()
    cursor.close()
    conn.close()

    flash('Data siswa berhasil diperbarui!', 'success')
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)