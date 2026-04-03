function logout() {
    sessionStorage.clear();
    window.location.href = "landing.html";
}

function togglePassword(id) {
    const input = document.getElementById(id);
    input.type = input.type === "password" ? "text" : "password";
}

function validateForm() {
    const errorMsg = document.getElementById('errorMsg');
    const password = document.getElementById('password').value;
    const confirm = document.getElementById('confirm').value;
    const contact = document.getElementById('contact').value;

    const fields = ['firstName', 'lastName', 'email', 'username', 'birthday', 'contact', 'password', 'confirm'];
    for (let id of fields) {
        if (!document.getElementById(id).value.trim()) {
            errorMsg.textContent = "Please fill in all fields.";
            return false;
        }
    }
    if (password !== confirm) {
        errorMsg.textContent = "Passwords do not match!";
        return false;
    }
    if (password.length < 6) {
        errorMsg.textContent = "Password must be at least 6 characters.";
        return false;
    }
    if (!/^\d+$/.test(contact)) {
        errorMsg.textContent = "Contact number must contain digits only.";
        return false;
    }
    return true;
}

// ── CHARTS ────────────────────────────────────────────────────
let usageChart, statusChart, categoryChart;

function initCharts(data) {
    usageChart = new Chart(document.getElementById('usageChart'), {
        type: 'bar',
        data: {
            labels: ['Science', 'History', 'Math', 'Literature', 'Tech', 'Arts'],
            datasets: [{
                label: 'Books',
                data: data.usage,
                backgroundColor: ['#38bdf8','#818cf8','#34d399','#fb923c','#f472b6','#facc15']
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } } }
    });

    statusChart = new Chart(document.getElementById('statusChart'), {
        type: 'doughnut',
        data: {
            labels: ['Available', 'Issued', 'Pending'],
            datasets: [{
                data: data.status,
                backgroundColor: ['#34d399', '#f87171', '#facc15']
            }]
        },
        options: { responsive: true }
    });

    categoryChart = new Chart(document.getElementById('categoryChart'), {
        type: 'pie',
        data: {
            labels: data.categories.labels,
            datasets: [{
                data: data.categories.data,
                backgroundColor: ['#38bdf8', '#818cf8', '#34d399', '#fb923c']
            }]
        },
        options: { responsive: true }
    });
}

// ── DASHBOARD ─────────────────────────────────────────────────
function updateDashboard(period = 30) {
    fetch(`get_dashboard.php?period=${period}`)
        .then(res => res.json())
        .then(data => {
            document.getElementById('kpi-total').textContent = data.kpi.total;
            document.getElementById('kpi-available').textContent = data.kpi.available;
            document.getElementById('kpi-issued').textContent = data.kpi.issued;
            document.getElementById('kpi-rating').textContent = data.kpi.rating;
            document.getElementById('kpi-total-trend').textContent = data.kpi.trend;

            if (!usageChart) {
                initCharts(data);
            } else {
                usageChart.data.datasets[0].data = data.usage;
                usageChart.update();
                statusChart.data.datasets[0].data = data.status;
                statusChart.update();
                categoryChart.data.labels = data.categories.labels;
                categoryChart.data.datasets[0].data = data.categories.data;
                categoryChart.update();
            }

            const tbody = document.getElementById('bookTableBody');
            tbody.innerHTML = '';
            data.books.forEach(book => {
                const stars = '★'.repeat(Math.round(book.rating)) + '☆'.repeat(5 - Math.round(book.rating));
                tbody.innerHTML += `
                    <tr>
                        <td>#${book.id}</td>
                        <td>${book.title}</td>
                        <td>${book.author}</td>
                        <td><span class="status ${book.status.toLowerCase()}">${book.status}</span></td>
                        <td><span class="rating">${stars} ${parseFloat(book.rating).toFixed(1)}</span></td>
                        <td>
                            <button class="edit-btn" onclick="openEditModal(${book.id}, '${book.title}', '${book.author}', '${book.status}', ${book.rating}, '${book.category}')">Edit</button>
                            <button class="not-edit-btn" onclick="deleteBook(${book.id})">Delete</button>
                        </td>
                    </tr>`;
            });

            const feed = document.getElementById('activityFeed');
            feed.innerHTML = '';
            data.activities.forEach(act => {
                const time = new Date(act.created_at).toLocaleTimeString();
                feed.innerHTML += `
                    <div class="activity-item">
                        <span class="activity-icon">${act.icon}</span>
                        <div class="activity-content">
                            ${act.description}
                            <span class="activity-time">${time}</span>
                        </div>
                    </div>`;
            });
        })
        .catch(err => console.error('Dashboard fetch error:', err));
}

// ── ADD BOOK ──────────────────────────────────────────────────
function openAddModal() {
    ['newTitle','newAuthor','newRating'].forEach(id => document.getElementById(id).value = '');
    document.getElementById('newStatus').value = 'Available';
    document.getElementById('newCategory').value = 'Fiction';
    document.getElementById('addModal').style.display = 'flex';
}

function addBook() {
    const body = new FormData();
    body.append('title',    document.getElementById('newTitle').value.trim());
    body.append('author',   document.getElementById('newAuthor').value.trim());
    body.append('status',   document.getElementById('newStatus').value);
    body.append('rating',   document.getElementById('newRating').value);
    body.append('category', document.getElementById('newCategory').value);

    if (!body.get('title') || !body.get('author') || !body.get('rating')) {
        alert('Please fill in all fields!'); return;
    }

    fetch('add_book.php', { method: 'POST', body })
        .then(res => res.json())
        .then(data => {
            if (data.success) { closeModal('addModal'); updateDashboard(); }
            else alert('Failed to add book: ' + data.error);
        });
}

// ── EDIT BOOK ─────────────────────────────────────────────────
function openEditModal(id, title, author, status, rating, category) {
    document.getElementById('editId').value = id;
    document.getElementById('editTitle').value = title;
    document.getElementById('editAuthor').value = author;
    document.getElementById('editStatus').value = status;
    document.getElementById('editRating').value = rating;
    document.getElementById('editCategory').value = category;
    document.getElementById('editModal').style.display = 'flex';
}

function saveEdit() {
    const body = new FormData();
    body.append('id',       document.getElementById('editId').value);
    body.append('title',    document.getElementById('editTitle').value.trim());
    body.append('author',   document.getElementById('editAuthor').value.trim());
    body.append('status',   document.getElementById('editStatus').value);
    body.append('rating',   document.getElementById('editRating').value);
    body.append('category', document.getElementById('editCategory').value);

    fetch('edit_book.php', { method: 'POST', body })
        .then(res => res.json())
        .then(data => {
            if (data.success) { closeModal('editModal'); updateDashboard(); }
            else alert('Failed to save: ' + data.error);
        });
}

// ── DELETE BOOK ───────────────────────────────────────────────
function deleteBook(id) {
    if (!confirm('Delete this book?')) return;
    const body = new FormData();
    body.append('id', id);
    fetch('delete_book.php', { method: 'POST', body })
        .then(res => res.json())
        .then(data => {
            if (data.success) updateDashboard();
            else alert('Failed to delete: ' + data.error);
        });
}

// ── MODAL CLOSE ───────────────────────────────────────────────
function closeModal(id) {
    document.getElementById(id).style.display = 'none';
}

// ── INIT ──────────────────────────────────────────────────────
document.addEventListener('DOMContentLoaded', function () {

    // Lesson Catalog table
    const LessonCatalog = [
        {ID: "1021", Title: "The Great Gatsby", Author: "F. Scott Fitzgerald", Status: "Available", Action: "Available"},
        {ID: "1022", Title: "Project Hail Mary", Author: "Andy Weir", Status: "Available", Action: "Not Available"},
        {ID: "1023", Title: "Dune", Author: "Frank Herbert", Status: "Available", Action: "Available"},
        {ID: "1024", Title: "Judge Stone", Author: "James Patterson, ", Status: "Available", Action: "Available"},
        {ID: "1025", Title: "The Messenger", Author: "Lois Lowry", Status: "Available", Action: "Available"}
    ];

    const availableCount = LessonCatalog.filter(book => book.Action === "Available").length;

    const CatalogList = document.getElementById('TBody');
    if (CatalogList) {
        LessonCatalog.forEach(function(LessonList) {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>#${LessonList.ID}</td>
                <td>${LessonList.Title}</td>
                <td>${LessonList.Author}</td>
                <td>${LessonList.Status}</td>
                <td><button class="${LessonList.Action === 'Not Available' ? 'not-edit-btn' : 'edit-btn'}">${LessonList.Action}</button></td>
            `;
            CatalogList.appendChild(row);
        });
    }

    const totalBooksindex = LessonCatalog.length;
    const totalbooks = document.getElementById('totalbooks');
    const totalavailable = document.getElementById('totalavailable');

    totalbooks.innerHTML = "Total Lessons: " + totalBooksindex;
    totalavailable.innerHTML = "Total Available: " + availableCount;

    // Modal close on outside click
    document.querySelectorAll('.modal-overlay').forEach(overlay => {
        overlay.addEventListener('click', function(e) {
            if (e.target === this) closeModal(this.id);
        });
    });

    // Login error message
    const params = new URLSearchParams(window.location.search);
    if (params.get('error') === 'incorrect') {
        const el = document.getElementById('errorMsg');
        if (el) el.textContent = 'Username or password is incorrect!';
    }

    // Init dashboard if on Index page
    if (document.getElementById('bookTableBody')) {
        updateDashboard(30);
    }
});